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
    sub	sp, sp, #1216
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    adrp	x12, :got:memo.lut.fib
    movz	x5,	#40763
    mov	w16,	w0
    movz	x27,	#65535
    movz	x7,	#40763
    movk	x5,	#1117,	lsl #16
    lsr	w9,	w16,	#16
    movk	x7,	#1117,	lsl #16
    eor	w1,	w16,	w9
    mul	w2,	w1,	w7
    lsr	w13,	w2,	#16
    eor	w4,	w2,	w13
    mul	w5,	w4,	w5
    lsr	w17,	w5,	#16
    eor	w13,	w5,	w17
    str	w13,	[sp, #512]

    ldr	w13,	[sp, #512]

    ldr	x12, [x12, #:got_lo12:memo.lut.fib]
    and	w18,	w13,	w27
    lsl	w19,	w18,	#3
    lsl	w22,	w19,	#0
    add	x7,	x12,	x22
    str	x7,	[sp, #504]

    ldr	x8,	[sp, #504]

    mov	x3,	x8
    str	x3,	[sp, #496]

    ldr	x4,	[sp, #496]

    ldr	w18,	[x4]

    ldr	x8,	[sp, #504]

    add	x3,	x8,	#8
    cmp	w18,	#0
    beq	fib_25

fib_17:
    ldr	w21,	[x3]

    ldr	w0,	[sp, #512]

    cmp	w21,	w0
    bne	fib_27

fib_21:
    ldr	x10,	[sp, #504]

    add	x1,	x10,	#4
    ldr	w0,	[x1]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #1216
    ret


fib_27:
    mov	x0,	x3
    str	x0,	[sp, #488]

    b	fib_28

fib_25:
    mov	x0,	x3
    str	x0,	[sp, #488]


fib_28:
    cmp	w16,	#2
    ble	fib_1891

fib_31:
    asr	w23,	w16,	#31
    lsr	w24,	w23,	#31
    add	w25,	w16,	w24
    asr	w19,	w25,	#1
    lsl	w20,	w19,	#1
    sub	w18,	w16,	w20
    str	w18,	[sp, #460]

    movz	w18,	#0
    ldr	w0,	[sp, #460]

    sub	w0,	w18,	w0
    str	w0,	[sp, #740]

    ldr	w20,	[sp, #460]

    cmp	w20,	#0
    asr	w26,	w16,	#31
    ldr	w19,	[sp, #740]

    ldr	w21,	[sp, #460]

    lsr	w27,	w26,	#31
    csel	w19,	w19,	w21,	lt
    movz	w26,	#0
    str	w19,	[sp, #320]

    add	w28,	w16,	w27
    asr	w28,	w28,	#1
    asr	w0,	w28,	#31
    lsr	w19,	w0,	#31
    add	w20,	w28,	w19
    asr	w0,	w20,	#1
    lsl	w19,	w0,	#1
    sub	w20,	w28,	w19
    str	w20,	[sp, #468]

    ldr	w23,	[sp, #468]

    sub	w26,	w26,	w23
    str	w26,	[sp, #760]

    ldr	w22,	[sp, #468]

    cmp	w22,	#0
    ldr	w19,	[sp, #760]

    asr	w20,	w28,	#31
    ldr	w23,	[sp, #468]

    lsr	w21,	w20,	#31
    csel	w23,	w19,	w23,	lt
    str	w23,	[sp, #324]

    add	w0,	w28,	w21
    asr	w19,	w0,	#1
    movz	w0,	#0
    asr	w23,	w19,	#31
    lsr	w24,	w23,	#31
    add	w25,	w19,	w24
    asr	w23,	w25,	#1
    lsl	w24,	w23,	#1
    sub	w25,	w19,	w24
    str	w25,	[sp, #476]

    ldr	w18,	[sp, #476]

    sub	w25,	w0,	w18
    str	w25,	[sp, #776]

    ldr	w27,	[sp, #476]

    cmp	w27,	#0
    asr	w27,	w19,	#31
    ldr	w20,	[sp, #776]

    ldr	w28,	[sp, #476]

    lsr	w0,	w27,	#31
    csel	w22,	w20,	w28,	lt
    str	w22,	[sp, #520]

    add	w18,	w19,	w0
    asr	w23,	w18,	#1
    asr	w19,	w23,	#31
    lsr	w20,	w19,	#31
    movz	w19,	#0
    add	w21,	w23,	w20
    asr	w21,	w21,	#1
    lsl	w22,	w21,	#1
    sub	w21,	w23,	w22
    str	w21,	[sp, #484]

    ldr	w0,	[sp, #484]

    sub	w22,	w19,	w0
    str	w22,	[sp, #424]

    ldr	w24,	[sp, #484]

    cmp	w24,	#0
    ldr	w18,	[sp, #424]

    asr	w24,	w23,	#31
    ldr	w25,	[sp, #484]

    lsr	w26,	w24,	#31
    csel	w0,	w18,	w25,	lt
    movz	w24,	#0
    str	w0,	[sp, #1040]

    add	w0,	w23,	w26
    asr	w20,	w0,	#1
    asr	w26,	w20,	#31
    lsr	w27,	w26,	#31
    add	w0,	w20,	w27
    asr	w18,	w0,	#1
    lsl	w19,	w18,	#1
    sub	w18,	w20,	w19
    str	w18,	[sp, #480]

    ldr	w22,	[sp, #480]

    sub	w0,	w24,	w22
    str	w0,	[sp, #436]

    ldr	w18,	[sp, #480]

    cmp	w18,	#0
    ldr	w22,	[sp, #436]

    ldr	w19,	[sp, #480]

    csel	w27,	w22,	w19,	lt
    str	w27,	[sp, #328]

    asr	w27,	w20,	#31
    lsr	w0,	w27,	#31
    add	w18,	w20,	w0
    asr	w27,	w18,	#1
    asr	w19,	w27,	#31
    lsr	w20,	w19,	#31
    add	w22,	w27,	w20
    asr	w19,	w22,	#1
    lsl	w20,	w19,	#1
    sub	w0,	w27,	w20
    str	w0,	[sp, #464]

    movz	w0,	#0
    ldr	w20,	[sp, #464]

    sub	w22,	w0,	w20
    str	w22,	[sp, #448]

    ldr	w19,	[sp, #464]

    cmp	w19,	#0
    ldr	w23,	[sp, #448]

    asr	w22,	w27,	#31
    ldr	w20,	[sp, #464]

    csel	w26,	w23,	w20,	lt
    str	w26,	[sp, #412]

    lsr	w26,	w22,	#31
    add	w0,	w27,	w26
    asr	w19,	w0,	#1
    asr	w26,	w19,	#31
    lsr	w27,	w26,	#31
    add	w0,	w19,	w27
    asr	w26,	w0,	#1
    lsl	w27,	w26,	#1
    sub	w27,	w19,	w27
    str	w27,	[sp, #456]

    movz	w27,	#0
    ldr	w18,	[sp, #456]

    sub	w23,	w27,	w18
    str	w23,	[sp, #440]

    ldr	w18,	[sp, #456]

    cmp	w18,	#0
    ldr	w24,	[sp, #440]

    asr	w18,	w19,	#31
    ldr	w0,	[sp, #456]

    lsr	w22,	w18,	#31
    csel	w23,	w24,	w0,	lt
    str	w23,	[sp, #376]

    add	w0,	w19,	w22
    asr	w22,	w0,	#1
    str	w22,	[sp, #336]

    ldr	w23,	[sp, #336]

    ldr	w24,	[sp, #336]

    asr	w26,	w23,	#31
    ldr	w25,	[sp, #336]

    lsr	w18,	w26,	#31
    add	w0,	w24,	w18
    movz	w18,	#0
    asr	w22,	w0,	#1
    lsl	w0,	w22,	#1
    sub	w27,	w25,	w0
    str	w27,	[sp, #444]

    ldr	w0,	[sp, #444]

    sub	w22,	w18,	w0
    str	w22,	[sp, #428]

    ldr	w18,	[sp, #444]

    cmp	w18,	#0
    ldr	w23,	[sp, #428]

    ldr	w0,	[sp, #444]

    csel	w22,	w23,	w0,	lt
    str	w22,	[sp, #1164]

    ldr	w26,	[sp, #336]

    asr	w0,	w26,	#31
    ldr	w27,	[sp, #336]

    lsr	w0,	w0,	#31
    add	w0,	w27,	w0
    asr	w23,	w0,	#1
    asr	w18,	w23,	#31
    lsr	w22,	w18,	#31
    add	w0,	w23,	w22
    asr	w18,	w0,	#1
    movz	w0,	#0
    lsl	w22,	w18,	#1
    sub	w22,	w23,	w22
    str	w22,	[sp, #432]

    ldr	w20,	[sp, #432]

    sub	w26,	w0,	w20
    str	w26,	[sp, #416]

    ldr	w25,	[sp, #432]

    cmp	w25,	#0
    asr	w0,	w23,	#31
    ldr	w27,	[sp, #416]

    ldr	w20,	[sp, #432]

    lsr	w26,	w0,	#31
    csel	w18,	w27,	w20,	lt
    str	w18,	[sp, #1160]

    add	w0,	w23,	w26
    asr	w18,	w0,	#1
    asr	w20,	w18,	#31
    lsr	w25,	w20,	#31
    add	w0,	w18,	w25
    asr	w0,	w0,	#1
    lsl	w20,	w0,	#1
    sub	w0,	w18,	w20
    str	w0,	[sp, #420]

    movz	w0,	#0
    ldr	w19,	[sp, #420]

    sub	w22,	w0,	w19
    str	w22,	[sp, #768]

    ldr	w20,	[sp, #420]

    cmp	w20,	#0
    ldr	w23,	[sp, #768]

    ldr	w20,	[sp, #420]

    csel	w28,	w23,	w20,	lt
    asr	w20,	w18,	#31
    str	w28,	[sp, #1200]

    lsr	w25,	w20,	#31
    add	w0,	w18,	w25
    asr	w23,	w0,	#1
    asr	w0,	w23,	#31
    lsr	w25,	w0,	#31
    add	w0,	w23,	w25
    asr	w25,	w0,	#1
    lsl	w0,	w25,	#1
    sub	w26,	w23,	w0
    str	w26,	[sp, #772]

    movz	w26,	#0
    ldr	w20,	[sp, #772]

    mov	w0,	w26
    sub	w18,	w0,	w20
    str	w18,	[sp, #756]

    ldr	w0,	[sp, #772]

    cmp	w0,	#0
    ldr	w0,	[sp, #756]

    ldr	w25,	[sp, #772]

    csel	w26,	w0,	w25,	lt
    str	w26,	[sp, #824]

    asr	w0,	w23,	#31
    lsr	w25,	w0,	#31
    add	w0,	w23,	w25
    asr	w25,	w0,	#1
    asr	w0,	w25,	#31
    lsr	w19,	w0,	#31
    add	w0,	w25,	w19
    asr	w0,	w0,	#1
    lsl	w19,	w0,	#1
    movz	w0,	#0
    sub	w26,	w25,	w19
    str	w26,	[sp, #764]

    ldr	w23,	[sp, #764]

    sub	w18,	w0,	w23
    str	w18,	[sp, #744]

    ldr	w0,	[sp, #764]

    cmp	w0,	#0
    ldr	w0,	[sp, #744]

    ldr	w22,	[sp, #764]

    csel	w23,	w0,	w22,	lt
    asr	w0,	w25,	#31
    str	w23,	[sp, #636]

    lsr	w19,	w0,	#31
    add	w0,	w25,	w19
    asr	w20,	w0,	#1
    asr	w19,	w20,	#31
    lsr	w25,	w19,	#31
    add	w0,	w20,	w25
    asr	w0,	w0,	#1
    lsl	w19,	w0,	#1
    sub	w22,	w20,	w19
    str	w22,	[sp, #748]

    movz	w22,	#0
    ldr	w27,	[sp, #748]

    mov	w0,	w22
    sub	w25,	w0,	w27
    str	w25,	[sp, #732]

    ldr	w24,	[sp, #748]

    cmp	w24,	#0
    asr	w19,	w20,	#31
    ldr	w26,	[sp, #732]

    ldr	w0,	[sp, #748]

    lsr	w25,	w19,	#31
    csel	w18,	w26,	w0,	lt
    str	w18,	[sp, #652]

    add	w0,	w20,	w25
    asr	w25,	w0,	#1
    asr	w0,	w25,	#31
    lsr	w19,	w0,	#31
    add	w0,	w25,	w19
    asr	w19,	w0,	#1
    lsl	w0,	w19,	#1
    sub	w18,	w25,	w0
    movz	w0,	#0
    str	w18,	[sp, #736]

    ldr	w23,	[sp, #736]

    sub	w23,	w0,	w23
    str	w23,	[sp, #724]

    ldr	w0,	[sp, #736]

    cmp	w0,	#0
    ldr	w26,	[sp, #724]

    asr	w0,	w25,	#31
    ldr	w19,	[sp, #736]

    csel	w22,	w26,	w19,	lt
    movz	w26,	#0
    lsr	w19,	w0,	#31
    str	w22,	[sp, #680]

    add	w0,	w25,	w19
    asr	w23,	w0,	#1
    asr	w0,	w23,	#31
    lsr	w25,	w0,	#31
    add	w0,	w23,	w25
    asr	w0,	w0,	#1
    lsl	w25,	w0,	#1
    mov	w0,	w26
    sub	w18,	w23,	w25
    str	w18,	[sp, #728]

    ldr	w22,	[sp, #728]

    sub	w25,	w0,	w22
    str	w25,	[sp, #716]

    ldr	w0,	[sp, #728]

    cmp	w0,	#0
    ldr	w26,	[sp, #716]

    ldr	w0,	[sp, #728]

    csel	w18,	w26,	w0,	lt
    str	w18,	[sp, #700]

    asr	w0,	w23,	#31
    lsr	w25,	w0,	#31
    add	w0,	w23,	w25
    asr	w25,	w0,	#1
    str	w25,	[sp, #952]

    ldr	w26,	[sp, #952]

    asr	w22,	w26,	#31
    ldr	w27,	[sp, #952]

    ldr	w28,	[sp, #952]

    lsr	w0,	w22,	#31
    add	w26,	w27,	w0
    asr	w26,	w26,	#1
    lsl	w0,	w26,	#1
    sub	w27,	w28,	w0
    movz	w0,	#0
    str	w27,	[sp, #720]

    ldr	w18,	[sp, #720]

    sub	w20,	w0,	w18
    str	w20,	[sp, #712]

    ldr	w18,	[sp, #720]

    cmp	w18,	#0
    ldr	w22,	[sp, #712]

    ldr	w18,	[sp, #720]

    csel	w26,	w22,	w18,	lt
    str	w26,	[sp, #696]

    ldr	w20,	[sp, #320]

    cmp	w20,	#0
    cset	w0,	ne
    mov	w26,	w0
    cmp	w26,	#0
    cset	w0,	eq
    mov	w22,	w0
    cmp	w22,	#0
    cset	w0,	ne
    mov	w26,	w0
    cmp	w26,	#0
    cset	w0,	ne
    mov	w22,	w0
    cmp	w22,	#0
    cset	w0,	ne
    mov	w23,	w0
    str	w23,	[sp, #704]

    ldr	w21,	[sp, #320]

    cmp	w21,	#0
    cset	w0,	ne
    mov	w22,	w0
    cmp	w22,	#0
    cset	w0,	ne
    mov	w21,	w0
    str	w21,	[sp, #348]

    ldr	w24,	[sp, #324]

    cmp	w24,	#0
    cset	w0,	ne
    mov	w22,	w0
    cmp	w22,	#0
    cset	w0,	eq
    mov	w26,	w0
    cmp	w26,	#0
    cset	w0,	ne
    mov	w27,	w0
    str	w27,	[sp, #1212]

    ldr	w22,	[sp, #348]

    cmp	w22,	#0
    ldr	w27,	[sp, #1212]

    cset	w0,	ne
    mov	w26,	w0
    cmp	w27,	#0
    movz	w24,	#1
    mov	w19,	w24
    csel	w22,	w19,	w26,	ne
    str	w22,	[sp, #932]

    ldr	w23,	[sp, #348]

    cmp	w23,	#0
    cset	w0,	ne
    mov	w26,	w0
    str	w26,	[sp, #96]

    ldr	w18,	[sp, #1212]

    cmp	w18,	#0
    movz	w0,	#0
    mov	w26,	w0
    ldr	w0,	[sp, #96]

    csel	w22,	w0,	w26,	ne
    cmp	w22,	#0
    cset	w0,	eq
    mov	w26,	w0
    cmp	w26,	#0
    cset	w0,	ne
    mov	w22,	w0
    ldr	w0,	[sp, #932]

    cmp	w0,	#0
    movz	w0,	#0
    mov	w19,	w0
    csel	w22,	w22,	w19,	ne
    str	w22,	[sp, #688]

    ldr	w25,	[sp, #324]

    cmp	w25,	#0
    cset	w0,	ne
    mov	w22,	w0
    ldr	w0,	[sp, #348]

    cmp	w0,	#0
    ldr	w20,	[sp, #1212]

    cset	w19,	ne
    mov	w25,	w19
    cmp	w20,	#0
    movz	w19,	#0
    mov	w0,	w19
    csel	w19,	w25,	w0,	ne
    cmp	w19,	#0
    cset	w0,	ne
    cmp	w22,	#0
    movz	w18,	#1
    csel	w26,	w18,	w0,	ne
    str	w26,	[sp, #1028]

    ldr	w23,	[sp, #520]

    cmp	w23,	#0
    cset	w0,	ne
    mov	w26,	w0
    cmp	w26,	#0
    cset	w0,	eq
    mov	w22,	w0
    cmp	w22,	#0
    cset	w0,	ne
    mov	w19,	w0
    str	w19,	[sp, #1032]

    ldr	w27,	[sp, #1028]

    cmp	w27,	#0
    cset	w0,	ne
    ldr	w19,	[sp, #1032]

    mov	w22,	w0
    cmp	w19,	#0
    movz	w0,	#1
    mov	w19,	w0
    csel	w23,	w19,	w22,	ne
    str	w23,	[sp, #1024]

    ldr	w28,	[sp, #1028]

    cmp	w28,	#0
    cset	w0,	ne
    mov	w22,	w0
    str	w22,	[sp, #820]

    ldr	w21,	[sp, #1032]

    cmp	w21,	#0
    movz	w26,	#0
    ldr	w25,	[sp, #820]

    csel	w26,	w25,	w26,	ne
    cmp	w26,	#0
    cset	w0,	eq
    mov	w22,	w0
    cmp	w22,	#0
    cset	w0,	ne
    ldr	w22,	[sp, #1024]

    mov	w26,	w0
    cmp	w22,	#0
    movz	w0,	#0
    csel	w26,	w26,	w0,	ne
    str	w26,	[sp, #664]

    ldr	w24,	[sp, #520]

    cmp	w24,	#0
    ldr	w28,	[sp, #1028]

    cset	w0,	ne
    mov	w22,	w0
    cmp	w28,	#0
    ldr	w19,	[sp, #1032]

    cset	w27,	ne
    mov	w0,	w27
    cmp	w19,	#0
    movz	w19,	#0
    csel	w23,	w0,	w19,	ne
    cmp	w23,	#0
    cset	w27,	ne
    mov	w19,	w27
    cmp	w22,	#0
    movz	w0,	#1
    mov	w27,	w0
    csel	w24,	w27,	w19,	ne
    str	w24,	[sp, #1036]

    ldr	w18,	[sp, #1040]

    cmp	w18,	#0
    cset	w27,	ne
    mov	w19,	w27
    cmp	w19,	#0
    cset	w0,	eq
    mov	w25,	w0
    cmp	w25,	#0
    cset	w27,	ne
    str	w27,	[sp, #1016]

    ldr	w25,	[sp, #1036]

    cmp	w25,	#0
    cset	w0,	ne
    ldr	w26,	[sp, #1016]

    mov	w25,	w0
    cmp	w26,	#0
    movz	w0,	#1
    csel	w20,	w0,	w25,	ne
    str	w20,	[sp, #1020]

    ldr	w26,	[sp, #1036]

    cmp	w26,	#0
    ldr	w27,	[sp, #1016]

    cset	w0,	ne
    mov	w25,	w0
    cmp	w27,	#0
    movz	w0,	#0
    mov	w22,	w0
    csel	w19,	w25,	w22,	ne
    cmp	w19,	#0
    cset	w0,	eq
    mov	w25,	w0
    cmp	w25,	#0
    cset	w27,	ne
    ldr	w20,	[sp, #1020]

    mov	w0,	w27
    cmp	w20,	#0
    movz	w19,	#0
    csel	w23,	w0,	w19,	ne
    str	w23,	[sp, #628]

    ldr	w19,	[sp, #1040]

    cmp	w19,	#0
    cset	w25,	ne
    mov	w26,	w25
    str	w26,	[sp, #284]

    ldr	w27,	[sp, #1036]

    cmp	w27,	#0
    ldr	w28,	[sp, #1016]

    cset	w0,	ne
    mov	w22,	w0
    cmp	w28,	#0
    movz	w0,	#0
    mov	w25,	w0
    csel	w0,	w22,	w25,	ne
    cmp	w0,	#0
    cset	w0,	ne
    ldr	w28,	[sp, #284]

    mov	w25,	w0
    cmp	w28,	#0
    movz	w27,	#1
    mov	w0,	w27
    csel	w23,	w0,	w25,	ne
    str	w23,	[sp, #392]

    ldr	w28,	[sp, #328]

    cmp	w28,	#0
    cset	w0,	ne
    mov	w23,	w0
    cmp	w23,	#0
    cset	w25,	eq
    mov	w0,	w25
    cmp	w0,	#0
    cset	w0,	ne
    mov	w26,	w0
    str	w26,	[sp, #352]

    ldr	w24,	[sp, #392]

    cmp	w24,	#0
    cset	w25,	ne
    ldr	w21,	[sp, #352]

    mov	w0,	w25
    cmp	w21,	#0
    movz	w27,	#1
    mov	w25,	w27
    csel	w19,	w25,	w0,	ne
    str	w19,	[sp, #332]

    ldr	w25,	[sp, #392]

    cmp	w25,	#0
    ldr	w22,	[sp, #352]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w22,	#0
    movz	w18,	#0
    csel	w23,	w0,	w18,	ne
    cmp	w23,	#0
    cset	w25,	eq
    mov	w0,	w25
    cmp	w0,	#0
    cset	w0,	ne
    ldr	w28,	[sp, #332]

    mov	w25,	w0
    cmp	w28,	#0
    movz	w27,	#0
    mov	w0,	w27
    csel	w21,	w25,	w0,	ne
    str	w21,	[sp, #616]

    ldr	w0,	[sp, #328]

    cmp	w0,	#0
    ldr	w25,	[sp, #392]

    cset	w0,	ne
    mov	w23,	w0
    cmp	w25,	#0
    ldr	w22,	[sp, #352]

    cset	w19,	ne
    mov	w0,	w19
    cmp	w22,	#0
    movz	w22,	#0
    csel	w19,	w0,	w22,	ne
    cmp	w19,	#0
    cset	w0,	ne
    mov	w27,	w0
    cmp	w23,	#0
    movz	w0,	#1
    csel	w18,	w0,	w27,	ne
    str	w18,	[sp, #956]

    ldr	w27,	[sp, #412]

    cmp	w27,	#0
    cset	w25,	ne
    mov	w0,	w25
    cmp	w0,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    cset	w25,	ne
    str	w25,	[sp, #144]

    ldr	w19,	[sp, #956]

    cmp	w19,	#0
    cset	w0,	ne
    mov	w23,	w0
    ldr	w0,	[sp, #144]

    cmp	w0,	#0
    movz	w27,	#1
    mov	w19,	w27
    csel	w0,	w19,	w23,	ne
    str	w0,	[sp, #340]

    ldr	w20,	[sp, #956]

    cmp	w20,	#0
    ldr	w18,	[sp, #144]

    cset	w0,	ne
    mov	w23,	w0
    cmp	w18,	#0
    movz	w19,	#0
    mov	w27,	w19
    csel	w0,	w23,	w27,	ne
    cmp	w0,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    cset	w25,	ne
    ldr	w27,	[sp, #340]

    mov	w0,	w25
    cmp	w27,	#0
    movz	w18,	#0
    csel	w0,	w0,	w18,	ne
    str	w0,	[sp, #804]

    ldr	w28,	[sp, #412]

    cmp	w28,	#0
    cset	w25,	ne
    mov	w28,	w25
    str	w28,	[sp, #268]

    ldr	w21,	[sp, #956]

    cmp	w21,	#0
    ldr	w19,	[sp, #144]

    cset	w0,	ne
    mov	w23,	w0
    cmp	w19,	#0
    movz	w27,	#0
    mov	w19,	w27
    csel	w0,	w23,	w19,	ne
    cmp	w0,	#0
    cset	w0,	ne
    mov	w23,	w0
    ldr	w0,	[sp, #268]

    cmp	w0,	#0
    movz	w19,	#1
    mov	w27,	w19
    csel	w20,	w27,	w23,	ne
    str	w20,	[sp, #1176]

    ldr	w24,	[sp, #376]

    cmp	w24,	#0
    cset	w0,	ne
    mov	w23,	w0
    cmp	w23,	#0
    cset	w25,	eq
    mov	w0,	w25
    cmp	w0,	#0
    cset	w0,	ne
    mov	w20,	w0
    str	w20,	[sp, #360]

    ldr	w21,	[sp, #1176]

    cmp	w21,	#0
    cset	w25,	ne
    ldr	w27,	[sp, #360]

    mov	w0,	w25
    cmp	w27,	#0
    movz	w18,	#1
    csel	w20,	w18,	w0,	ne
    str	w20,	[sp, #372]

    ldr	w22,	[sp, #1176]

    cmp	w22,	#0
    cset	w25,	ne
    ldr	w28,	[sp, #360]

    mov	w0,	w25
    cmp	w28,	#0
    movz	w25,	#0
    mov	w27,	w25
    csel	w23,	w0,	w27,	ne
    cmp	w23,	#0
    cset	w25,	eq
    mov	w0,	w25
    cmp	w0,	#0
    ldr	w18,	[sp, #372]

    cset	w0,	ne
    mov	w23,	w0
    cmp	w18,	#0
    movz	w19,	#0
    mov	w27,	w19
    csel	w28,	w23,	w27,	ne
    str	w28,	[sp, #940]

    ldr	w25,	[sp, #376]

    cmp	w25,	#0
    cset	w0,	ne
    ldr	w25,	[sp, #1176]

    mov	w23,	w0
    cmp	w25,	#0
    ldr	w0,	[sp, #360]

    cset	w27,	ne
    mov	w19,	w27
    cmp	w0,	#0
    movz	w0,	#0
    csel	w19,	w19,	w0,	ne
    cmp	w19,	#0
    cset	w27,	ne
    mov	w19,	w27
    cmp	w23,	#0
    movz	w25,	#1
    mov	w27,	w25
    csel	w23,	w27,	w19,	ne
    str	w23,	[sp, #1000]

    ldr	w23,	[sp, #1164]

    cmp	w23,	#0
    cset	w25,	ne
    mov	w0,	w25
    cmp	w0,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    cset	w25,	ne
    mov	w18,	w25
    str	w18,	[sp, #148]

    ldr	w24,	[sp, #1000]

    cmp	w24,	#0
    cset	w0,	ne
    ldr	w22,	[sp, #148]

    mov	w23,	w0
    cmp	w22,	#0
    movz	w19,	#1
    mov	w27,	w19
    csel	w28,	w27,	w23,	ne
    str	w28,	[sp, #396]

    ldr	w25,	[sp, #1000]

    cmp	w25,	#0
    ldr	w24,	[sp, #148]

    cset	w0,	ne
    mov	w23,	w0
    cmp	w24,	#0
    movz	w0,	#0
    csel	w0,	w23,	w0,	ne
    cmp	w0,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    cset	w25,	ne
    ldr	w28,	[sp, #396]

    mov	w0,	w25
    cmp	w28,	#0
    movz	w25,	#0
    mov	w27,	w25
    csel	w19,	w0,	w27,	ne
    str	w19,	[sp, #944]

    ldr	w24,	[sp, #1164]

    cmp	w24,	#0
    cset	w25,	ne
    mov	w19,	w25
    str	w19,	[sp, #296]

    ldr	w26,	[sp, #1000]

    cmp	w26,	#0
    ldr	w25,	[sp, #148]

    cset	w0,	ne
    mov	w23,	w0
    cmp	w25,	#0
    movz	w19,	#0
    mov	w27,	w19
    csel	w0,	w23,	w27,	ne
    cmp	w0,	#0
    cset	w0,	ne
    ldr	w21,	[sp, #296]

    mov	w23,	w0
    cmp	w21,	#0
    movz	w0,	#1
    csel	w28,	w0,	w23,	ne
    str	w28,	[sp, #1004]

    ldr	w19,	[sp, #1160]

    cmp	w19,	#0
    cset	w0,	ne
    mov	w23,	w0
    cmp	w23,	#0
    cset	w25,	eq
    mov	w0,	w25
    cmp	w0,	#0
    cset	w0,	ne
    mov	w23,	w0
    str	w23,	[sp, #152]

    ldr	w0,	[sp, #1004]

    cmp	w0,	#0
    ldr	w28,	[sp, #152]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w28,	#0
    movz	w25,	#1
    mov	w27,	w25
    csel	w25,	w27,	w0,	ne
    str	w25,	[sp, #1180]

    ldr	w18,	[sp, #1004]

    cmp	w18,	#0
    ldr	w18,	[sp, #152]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w18,	#0
    movz	w27,	#0
    mov	w25,	w27
    csel	w23,	w0,	w25,	ne
    cmp	w23,	#0
    cset	w25,	eq
    mov	w0,	w25
    cmp	w0,	#0
    cset	w0,	ne
    ldr	w28,	[sp, #1180]

    mov	w23,	w0
    cmp	w28,	#0
    movz	w0,	#0
    csel	w25,	w23,	w0,	ne
    str	w25,	[sp, #936]

    ldr	w20,	[sp, #1160]

    cmp	w20,	#0
    cset	w0,	ne
    ldr	w28,	[sp, #1004]

    mov	w18,	w0
    cmp	w28,	#0
    ldr	w28,	[sp, #152]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w28,	#0
    movz	w25,	#0
    mov	w27,	w25
    csel	w20,	w0,	w27,	ne
    cmp	w20,	#0
    cset	w25,	ne
    mov	w0,	w25
    cmp	w18,	#0
    movz	w27,	#1
    mov	w25,	w27
    csel	w21,	w25,	w0,	ne
    str	w21,	[sp, #1008]

    ldr	w0,	[sp, #1200]

    cmp	w0,	#0
    cset	w25,	ne
    mov	w0,	w25
    cmp	w0,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    cset	w25,	ne
    mov	w28,	w25
    str	w28,	[sp, #344]

    ldr	w22,	[sp, #1008]

    cmp	w22,	#0
    cset	w0,	ne
    ldr	w21,	[sp, #344]

    mov	w23,	w0
    cmp	w21,	#0
    movz	w0,	#1
    csel	w28,	w0,	w23,	ne
    str	w28,	[sp, #1184]

    ldr	w23,	[sp, #1008]

    cmp	w23,	#0
    ldr	w22,	[sp, #344]

    cset	w0,	ne
    mov	w23,	w0
    cmp	w22,	#0
    movz	w27,	#0
    mov	w19,	w27
    csel	w0,	w23,	w19,	ne
    cmp	w0,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    ldr	w20,	[sp, #1184]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w20,	#0
    movz	w27,	#0
    mov	w25,	w27
    csel	w22,	w0,	w25,	ne
    str	w22,	[sp, #948]

    ldr	w18,	[sp, #1200]

    cmp	w18,	#0
    ldr	w21,	[sp, #1008]

    cset	w25,	ne
    mov	w22,	w25
    cmp	w21,	#0
    ldr	w21,	[sp, #344]

    cset	w0,	ne
    mov	w23,	w0
    cmp	w21,	#0
    movz	w0,	#0
    csel	w27,	w23,	w0,	ne
    cmp	w27,	#0
    cset	w0,	ne
    mov	w23,	w0
    cmp	w22,	#0
    movz	w27,	#1
    mov	w19,	w27
    csel	w24,	w19,	w23,	ne
    str	w24,	[sp, #924]

    ldr	w21,	[sp, #824]

    cmp	w21,	#0
    cset	w0,	ne
    mov	w23,	w0
    cmp	w23,	#0
    cset	w25,	eq
    mov	w0,	w25
    cmp	w0,	#0
    cset	w0,	ne
    mov	w25,	w0
    str	w25,	[sp, #364]

    ldr	w25,	[sp, #924]

    cmp	w25,	#0
    ldr	w21,	[sp, #364]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w21,	#0
    movz	w27,	#1
    mov	w25,	w27
    csel	w20,	w25,	w0,	ne
    str	w20,	[sp, #1204]

    ldr	w26,	[sp, #924]

    cmp	w26,	#0
    ldr	w22,	[sp, #364]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w22,	#0
    movz	w18,	#0
    csel	w23,	w0,	w18,	ne
    cmp	w23,	#0
    cset	w25,	eq
    mov	w0,	w25
    cmp	w0,	#0
    cset	w0,	ne
    ldr	w25,	[sp, #1204]

    mov	w23,	w0
    cmp	w25,	#0
    movz	w27,	#0
    mov	w19,	w27
    csel	w23,	w23,	w19,	ne
    str	w23,	[sp, #1208]

    ldr	w0,	[sp, #824]

    cmp	w0,	#0
    cset	w0,	ne
    ldr	w20,	[sp, #924]

    mov	w23,	w0
    cmp	w20,	#0
    ldr	w24,	[sp, #364]

    cset	w19,	ne
    mov	w0,	w19
    cmp	w24,	#0
    movz	w22,	#0
    csel	w19,	w0,	w22,	ne
    cmp	w19,	#0
    cset	w0,	ne
    mov	w27,	w0
    cmp	w23,	#0
    movz	w0,	#1
    csel	w0,	w0,	w27,	ne
    str	w0,	[sp, #928]

    ldr	w28,	[sp, #636]

    cmp	w28,	#0
    cset	w25,	ne
    mov	w0,	w25
    cmp	w0,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    cset	w25,	ne
    mov	w20,	w25
    str	w20,	[sp, #140]

    ldr	w18,	[sp, #928]

    cmp	w18,	#0
    ldr	w24,	[sp, #140]

    cset	w0,	ne
    mov	w23,	w0
    cmp	w24,	#0
    movz	w27,	#1
    mov	w19,	w27
    csel	w19,	w19,	w23,	ne
    str	w19,	[sp, #1188]

    ldr	w19,	[sp, #928]

    cmp	w19,	#0
    cset	w0,	ne
    ldr	w25,	[sp, #140]

    mov	w23,	w0
    cmp	w25,	#0
    movz	w19,	#0
    mov	w27,	w19
    csel	w0,	w23,	w27,	ne
    cmp	w0,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    ldr	w23,	[sp, #1188]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w23,	#0
    movz	w18,	#0
    csel	w22,	w0,	w18,	ne
    str	w22,	[sp, #404]

    ldr	w0,	[sp, #636]

    cmp	w0,	#0
    cset	w25,	ne
    ldr	w26,	[sp, #928]

    mov	w0,	w25
    cmp	w26,	#0
    cset	w27,	ne
    ldr	w23,	[sp, #140]

    mov	w18,	w27
    cmp	w23,	#0
    movz	w27,	#0
    csel	w27,	w18,	w27,	ne
    cmp	w27,	#0
    cset	w18,	ne
    mov	w25,	w18
    cmp	w0,	#0
    movz	w19,	#1
    mov	w27,	w19
    csel	w26,	w27,	w25,	ne
    str	w26,	[sp, #916]

    ldr	w21,	[sp, #652]

    cmp	w21,	#0
    cset	w0,	ne
    mov	w23,	w0
    cmp	w23,	#0
    cset	w25,	eq
    mov	w0,	w25
    cmp	w0,	#0
    cset	w0,	ne
    mov	w22,	w0
    str	w22,	[sp, #300]

    ldr	w27,	[sp, #916]

    cmp	w27,	#0
    cset	w25,	ne
    mov	w0,	w25
    ldr	w25,	[sp, #300]

    cmp	w25,	#0
    movz	w18,	#1
    csel	w22,	w18,	w0,	ne
    str	w22,	[sp, #1192]

    ldr	w28,	[sp, #916]

    cmp	w28,	#0
    ldr	w26,	[sp, #300]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w26,	#0
    movz	w25,	#0
    mov	w27,	w25
    csel	w23,	w0,	w27,	ne
    cmp	w23,	#0
    cset	w25,	eq
    mov	w0,	w25
    cmp	w0,	#0
    ldr	w26,	[sp, #1192]

    cset	w0,	ne
    mov	w23,	w0
    cmp	w26,	#0
    movz	w19,	#0
    mov	w27,	w19
    csel	w19,	w23,	w27,	ne
    str	w19,	[sp, #400]

    ldr	w0,	[sp, #652]

    cmp	w0,	#0
    cset	w0,	ne
    ldr	w21,	[sp, #916]

    mov	w23,	w0
    cmp	w21,	#0
    ldr	w22,	[sp, #300]

    cset	w19,	ne
    mov	w0,	w19
    cmp	w22,	#0
    movz	w22,	#0
    csel	w19,	w0,	w22,	ne
    cmp	w19,	#0
    cset	w0,	ne
    mov	w27,	w0
    cmp	w23,	#0
    movz	w24,	#1
    mov	w19,	w24
    csel	w19,	w19,	w27,	ne
    str	w19,	[sp, #920]

    ldr	w23,	[sp, #680]

    cmp	w23,	#0
    cset	w25,	ne
    mov	w0,	w25
    cmp	w0,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    cset	w25,	ne
    mov	w27,	w25
    str	w27,	[sp, #304]

    ldr	w20,	[sp, #920]

    cmp	w20,	#0
    cset	w0,	ne
    ldr	w18,	[sp, #304]

    mov	w23,	w0
    cmp	w18,	#0
    movz	w19,	#1
    mov	w27,	w19
    csel	w25,	w27,	w23,	ne
    str	w25,	[sp, #1196]

    ldr	w21,	[sp, #920]

    cmp	w21,	#0
    ldr	w19,	[sp, #304]

    cset	w0,	ne
    mov	w23,	w0
    cmp	w19,	#0
    movz	w0,	#0
    csel	w0,	w23,	w0,	ne
    cmp	w0,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    ldr	w18,	[sp, #1196]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w18,	#0
    movz	w25,	#0
    mov	w27,	w25
    csel	w26,	w0,	w27,	ne
    str	w26,	[sp, #1168]

    ldr	w24,	[sp, #680]

    cmp	w24,	#0
    ldr	w27,	[sp, #920]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w27,	#0
    cset	w27,	ne
    ldr	w28,	[sp, #304]

    mov	w18,	w27
    cmp	w28,	#0
    movz	w27,	#0
    csel	w27,	w18,	w27,	ne
    cmp	w27,	#0
    cset	w18,	ne
    mov	w25,	w18
    cmp	w0,	#0
    movz	w0,	#1
    csel	w21,	w0,	w25,	ne
    str	w21,	[sp, #796]

    ldr	w27,	[sp, #700]

    cmp	w27,	#0
    cset	w0,	ne
    mov	w23,	w0
    cmp	w23,	#0
    cset	w25,	eq
    mov	w0,	w25
    cmp	w0,	#0
    ldr	w20,	[sp, #796]

    cset	w0,	ne
    mov	w23,	w0
    cmp	w20,	#0
    cset	w27,	ne
    mov	w19,	w27
    cmp	w23,	#0
    movz	w0,	#1
    csel	w27,	w0,	w19,	ne
    str	w27,	[sp, #524]

    ldr	w21,	[sp, #796]

    cmp	w21,	#0
    cset	w19,	ne
    mov	w27,	w19
    cmp	w23,	#0
    movz	w21,	#0
    csel	w19,	w27,	w21,	ne
    cmp	w19,	#0
    cset	w0,	eq
    mov	w27,	w0
    cmp	w27,	#0
    cset	w19,	ne
    ldr	w27,	[sp, #524]

    mov	w22,	w19
    cmp	w27,	#0
    movz	w0,	#0
    csel	w26,	w22,	w0,	ne
    str	w26,	[sp, #384]

    ldr	w26,	[sp, #700]

    cmp	w26,	#0
    cset	w0,	ne
    ldr	w18,	[sp, #796]

    mov	w27,	w0
    cmp	w18,	#0
    cset	w0,	ne
    mov	w21,	w0
    cmp	w23,	#0
    movz	w26,	#0
    csel	w19,	w21,	w26,	ne
    cmp	w19,	#0
    cset	w0,	ne
    mov	w24,	w0
    cmp	w27,	#0
    movz	w19,	#1
    mov	w27,	w19
    csel	w19,	w27,	w24,	ne
    str	w19,	[sp, #388]

    ldr	w24,	[sp, #696]

    cmp	w24,	#0
    cset	w25,	ne
    mov	w0,	w25
    cmp	w0,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    ldr	w19,	[sp, #388]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w19,	#0
    cset	w25,	ne
    mov	w18,	w25
    str	w18,	[sp, #800]

    cmp	w0,	#0
    movz	w18,	#1
    ldr	w22,	[sp, #800]

    csel	w19,	w18,	w22,	ne
    str	w19,	[sp, #1172]

    ldr	w20,	[sp, #388]

    cmp	w20,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w0,	#0
    movz	w27,	#0
    mov	w20,	w27
    csel	w0,	w18,	w20,	ne
    cmp	w0,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    cset	w25,	ne
    ldr	w20,	[sp, #1172]

    mov	w0,	w25
    cmp	w20,	#0
    movz	w27,	#0
    mov	w25,	w27
    csel	w23,	w0,	w25,	ne
    lsl	w27,	w23,	#1
    ldr	w0,	[sp, #384]

    add	w0,	w27,	w0
    ldr	w27,	[sp, #1168]

    ldr	w20,	[sp, #400]

    lsl	w0,	w0,	#1
    add	w23,	w0,	w27
    lsl	w27,	w23,	#1
    ldr	w23,	[sp, #404]

    add	w0,	w27,	w20
    ldr	w24,	[sp, #1208]

    lsl	w0,	w0,	#1
    add	w23,	w0,	w23
    lsl	w27,	w23,	#1
    ldr	w23,	[sp, #948]

    add	w0,	w27,	w24
    ldr	w26,	[sp, #936]

    ldr	w20,	[sp, #944]

    lsl	w0,	w0,	#1
    add	w23,	w0,	w23
    lsl	w27,	w23,	#1
    add	w0,	w27,	w26
    lsl	w0,	w0,	#1
    add	w23,	w0,	w20
    ldr	w0,	[sp, #940]

    ldr	w18,	[sp, #804]

    lsl	w27,	w23,	#1
    add	w0,	w27,	w0
    lsl	w0,	w0,	#1
    add	w23,	w0,	w18
    ldr	w0,	[sp, #616]

    lsl	w25,	w23,	#1
    add	w0,	w25,	w0
    ldr	w25,	[sp, #628]

    lsl	w0,	w0,	#1
    add	w23,	w0,	w25
    ldr	w0,	[sp, #664]

    ldr	w27,	[sp, #688]

    lsl	w25,	w23,	#1
    add	w0,	w25,	w0
    lsl	w0,	w0,	#1
    add	w23,	w0,	w27
    ldr	w0,	[sp, #704]

    lsl	w25,	w23,	#1
    add	w0,	w25,	w0
    bl	fib
    str	w0,	[sp, #708]

    ldr	w0,	[sp, #460]

    cmp	w0,	#0
    ldr	w21,	[sp, #740]

    ldr	w23,	[sp, #460]

    csel	w0,	w21,	w23,	lt
    ldr	w18,	[sp, #468]

    cmp	w18,	#0
    ldr	w23,	[sp, #760]

    ldr	w25,	[sp, #468]

    csel	w27,	w23,	w25,	lt
    str	w27,	[sp, #136]

    ldr	w21,	[sp, #476]

    cmp	w21,	#0
    ldr	w26,	[sp, #776]

    ldr	w22,	[sp, #476]

    csel	w27,	w26,	w22,	lt
    str	w27,	[sp, #124]

    ldr	w24,	[sp, #484]

    cmp	w24,	#0
    ldr	w20,	[sp, #424]

    ldr	w18,	[sp, #484]

    csel	w27,	w20,	w18,	lt
    str	w27,	[sp, #980]

    ldr	w18,	[sp, #480]

    cmp	w18,	#0
    ldr	w24,	[sp, #436]

    ldr	w19,	[sp, #480]

    csel	w25,	w24,	w19,	lt
    str	w25,	[sp, #108]

    ldr	w28,	[sp, #464]

    cmp	w28,	#0
    ldr	w28,	[sp, #448]

    ldr	w18,	[sp, #464]

    csel	w18,	w28,	w18,	lt
    str	w18,	[sp, #112]

    ldr	w24,	[sp, #456]

    cmp	w24,	#0
    ldr	w27,	[sp, #440]

    ldr	w18,	[sp, #456]

    csel	w22,	w27,	w18,	lt
    str	w22,	[sp, #116]

    ldr	w23,	[sp, #444]

    cmp	w23,	#0
    ldr	w19,	[sp, #428]

    ldr	w24,	[sp, #444]

    csel	w20,	w19,	w24,	lt
    str	w20,	[sp, #1148]

    ldr	w28,	[sp, #432]

    cmp	w28,	#0
    ldr	w23,	[sp, #416]

    ldr	w20,	[sp, #432]

    csel	w23,	w23,	w20,	lt
    str	w23,	[sp, #132]

    ldr	w18,	[sp, #420]

    cmp	w18,	#0
    ldr	w19,	[sp, #768]

    ldr	w27,	[sp, #420]

    csel	w24,	w19,	w27,	lt
    str	w24,	[sp, #1152]

    ldr	w18,	[sp, #772]

    cmp	w18,	#0
    ldr	w25,	[sp, #756]

    ldr	w21,	[sp, #772]

    csel	w25,	w25,	w21,	lt
    str	w25,	[sp, #1100]

    ldr	w18,	[sp, #764]

    cmp	w18,	#0
    ldr	w25,	[sp, #744]

    ldr	w20,	[sp, #764]

    csel	w28,	w25,	w20,	lt
    str	w28,	[sp, #832]

    ldr	w21,	[sp, #748]

    cmp	w21,	#0
    ldr	w22,	[sp, #732]

    ldr	w26,	[sp, #748]

    csel	w26,	w22,	w26,	lt
    str	w26,	[sp, #632]

    ldr	w28,	[sp, #736]

    cmp	w28,	#0
    ldr	w22,	[sp, #724]

    ldr	w19,	[sp, #736]

    csel	w24,	w22,	w19,	lt
    str	w24,	[sp, #660]

    ldr	w28,	[sp, #728]

    cmp	w28,	#0
    ldr	w22,	[sp, #716]

    ldr	w28,	[sp, #728]

    csel	w23,	w22,	w28,	lt
    str	w23,	[sp, #672]

    ldr	w28,	[sp, #720]

    cmp	w28,	#0
    ldr	w18,	[sp, #712]

    ldr	w27,	[sp, #720]

    csel	w26,	w18,	w27,	lt
    str	w26,	[sp, #676]

    cmp	w0,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w20,	ne
    str	w20,	[sp, #692]

    ldr	w23,	[sp, #136]

    cmp	w23,	#0
    cset	w27,	ne
    cmp	w27,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w28,	ne
    str	w28,	[sp, #684]

    ldr	w24,	[sp, #136]

    cmp	w24,	#0
    cset	w28,	ne
    cmp	w28,	#0
    ldr	w27,	[sp, #124]

    cset	w28,	ne
    cmp	w27,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w20,	ne
    str	w20,	[sp, #784]

    cmp	w28,	#0
    cset	w22,	ne
    ldr	w21,	[sp, #784]

    mov	w25,	w22
    cmp	w21,	#0
    movz	w0,	#1
    csel	w20,	w0,	w25,	ne
    cmp	w28,	#0
    cset	w23,	ne
    str	w23,	[sp, #780]

    ldr	w22,	[sp, #784]

    cmp	w22,	#0
    ldr	w19,	[sp, #780]

    movz	w0,	#0
    mov	w23,	w0
    csel	w25,	w19,	w23,	ne
    cmp	w25,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w0,	ne
    cmp	w20,	#0
    movz	w27,	#0
    csel	w22,	w0,	w27,	ne
    str	w22,	[sp, #668]

    ldr	w0,	[sp, #124]

    cmp	w0,	#0
    cset	w20,	ne
    cmp	w28,	#0
    cset	w23,	ne
    ldr	w24,	[sp, #784]

    mov	w26,	w23
    cmp	w24,	#0
    movz	w0,	#0
    csel	w18,	w26,	w0,	ne
    cmp	w18,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w20,	#0
    movz	w21,	#1
    ldr	w28,	[sp, #980]

    csel	w18,	w21,	w18,	ne
    cmp	w28,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w28,	ne
    cmp	w18,	#0
    cset	w20,	ne
    mov	w23,	w20
    cmp	w28,	#0
    movz	w22,	#1
    csel	w24,	w22,	w23,	ne
    cmp	w18,	#0
    cset	w27,	ne
    str	w27,	[sp, #828]

    cmp	w28,	#0
    movz	w21,	#0
    ldr	w23,	[sp, #828]

    csel	w23,	w23,	w21,	ne
    cmp	w23,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w22,	ne
    mov	w25,	w22
    cmp	w24,	#0
    movz	w0,	#0
    csel	w23,	w25,	w0,	ne
    str	w23,	[sp, #648]

    ldr	w22,	[sp, #980]

    cmp	w22,	#0
    cset	w27,	ne
    cmp	w18,	#0
    cset	w22,	ne
    mov	w25,	w22
    cmp	w28,	#0
    movz	w0,	#0
    csel	w22,	w25,	w0,	ne
    cmp	w22,	#0
    cset	w0,	ne
    cmp	w27,	#0
    ldr	w23,	[sp, #108]

    movz	w27,	#1
    csel	w19,	w27,	w0,	ne
    cmp	w23,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w0,	ne
    cmp	w19,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w0,	#0
    movz	w27,	#1
    csel	w22,	w27,	w20,	ne
    cmp	w19,	#0
    cset	w23,	ne
    mov	w26,	w23
    cmp	w0,	#0
    movz	w24,	#0
    csel	w21,	w26,	w24,	ne
    cmp	w21,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w21,	ne
    mov	w24,	w21
    cmp	w22,	#0
    movz	w23,	#0
    csel	w27,	w24,	w23,	ne
    str	w27,	[sp, #620]

    ldr	w27,	[sp, #108]

    cmp	w27,	#0
    cset	w27,	ne
    cmp	w19,	#0
    cset	w25,	ne
    mov	w18,	w25
    cmp	w0,	#0
    movz	w20,	#0
    csel	w20,	w18,	w20,	ne
    cmp	w20,	#0
    cset	w22,	ne
    mov	w25,	w22
    cmp	w27,	#0
    movz	w18,	#1
    csel	w20,	w18,	w25,	ne
    str	w20,	[sp, #276]

    ldr	w27,	[sp, #112]

    cmp	w27,	#0
    cset	w21,	ne
    cmp	w21,	#0
    cset	w25,	eq
    cmp	w25,	#0
    ldr	w21,	[sp, #276]

    cset	w28,	ne
    cmp	w21,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w28,	#0
    ldr	w22,	[sp, #276]

    movz	w0,	#1
    csel	w21,	w0,	w18,	ne
    cmp	w22,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w28,	#0
    movz	w26,	#0
    csel	w22,	w22,	w26,	ne
    cmp	w22,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w27,	ne
    mov	w19,	w27
    cmp	w21,	#0
    movz	w0,	#0
    csel	w24,	w19,	w0,	ne
    str	w24,	[sp, #816]

    ldr	w19,	[sp, #112]

    cmp	w19,	#0
    ldr	w0,	[sp, #276]

    cset	w22,	ne
    cmp	w0,	#0
    cset	w0,	ne
    cmp	w28,	#0
    movz	w24,	#0
    csel	w28,	w0,	w24,	ne
    cmp	w28,	#0
    cset	w18,	ne
    mov	w21,	w18
    cmp	w22,	#0
    ldr	w19,	[sp, #116]

    movz	w0,	#1
    csel	w22,	w0,	w21,	ne
    cmp	w19,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w0,	ne
    cmp	w22,	#0
    cset	w23,	ne
    mov	w26,	w23
    cmp	w0,	#0
    movz	w21,	#1
    csel	w25,	w21,	w26,	ne
    cmp	w22,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w0,	#0
    movz	w21,	#0
    csel	w21,	w20,	w21,	ne
    cmp	w21,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w25,	#0
    movz	w19,	#0
    csel	w24,	w18,	w19,	ne
    str	w24,	[sp, #1112]

    ldr	w24,	[sp, #116]

    cmp	w24,	#0
    cset	w21,	ne
    cmp	w22,	#0
    cset	w20,	ne
    mov	w23,	w20
    cmp	w0,	#0
    movz	w27,	#0
    csel	w0,	w23,	w27,	ne
    cmp	w0,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w21,	#0
    movz	w28,	#1
    ldr	w27,	[sp, #1148]

    csel	w26,	w28,	w18,	ne
    cmp	w27,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w28,	ne
    cmp	w26,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w28,	#0
    movz	w23,	#1
    csel	w21,	w23,	w22,	ne
    cmp	w26,	#0
    cset	w0,	ne
    cmp	w28,	#0
    movz	w22,	#0
    csel	w27,	w0,	w22,	ne
    cmp	w27,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w22,	ne
    mov	w25,	w22
    cmp	w21,	#0
    movz	w20,	#0
    csel	w20,	w25,	w20,	ne
    str	w20,	[sp, #1108]

    ldr	w21,	[sp, #1148]

    cmp	w21,	#0
    cset	w27,	ne
    cmp	w26,	#0
    cset	w23,	ne
    mov	w26,	w23
    cmp	w28,	#0
    movz	w18,	#0
    csel	w22,	w26,	w18,	ne
    cmp	w22,	#0
    cset	w0,	ne
    cmp	w27,	#0
    movz	w20,	#1
    ldr	w19,	[sp, #132]

    csel	w26,	w20,	w0,	ne
    cmp	w19,	#0
    cset	w21,	ne
    cmp	w21,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w0,	ne
    cmp	w26,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w0,	#0
    movz	w28,	#1
    csel	w24,	w28,	w20,	ne
    cmp	w26,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w0,	#0
    movz	w27,	#0
    csel	w27,	w25,	w27,	ne
    cmp	w27,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w24,	#0
    movz	w24,	#0
    csel	w27,	w23,	w24,	ne
    str	w27,	[sp, #1124]

    ldr	w25,	[sp, #132]

    cmp	w25,	#0
    cset	w27,	ne
    cmp	w26,	#0
    cset	w26,	ne
    mov	w19,	w26
    cmp	w0,	#0
    movz	w21,	#0
    csel	w20,	w19,	w21,	ne
    cmp	w20,	#0
    cset	w22,	ne
    mov	w24,	w22
    cmp	w27,	#0
    movz	w25,	#1
    ldr	w19,	[sp, #1152]

    csel	w21,	w25,	w24,	ne
    cmp	w19,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w28,	ne
    cmp	w21,	#0
    cset	w23,	ne
    mov	w26,	w23
    cmp	w28,	#0
    movz	w0,	#1
    csel	w23,	w0,	w26,	ne
    cmp	w21,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w28,	#0
    movz	w27,	#0
    csel	w22,	w22,	w27,	ne
    cmp	w22,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w23,	#0
    movz	w26,	#0
    csel	w18,	w18,	w26,	ne
    str	w18,	[sp, #1128]

    ldr	w25,	[sp, #1152]

    cmp	w25,	#0
    cset	w22,	ne
    cmp	w21,	#0
    cset	w0,	ne
    mov	w20,	w0
    cmp	w28,	#0
    movz	w0,	#0
    csel	w28,	w20,	w0,	ne
    cmp	w28,	#0
    cset	w18,	ne
    mov	w21,	w18
    cmp	w22,	#0
    movz	w18,	#1
    csel	w25,	w18,	w21,	ne
    str	w25,	[sp, #1132]

    ldr	w19,	[sp, #1100]

    cmp	w19,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w20,	eq
    cmp	w20,	#0
    ldr	w23,	[sp, #1132]

    cset	w21,	ne
    mov	w0,	w21
    cmp	w23,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w0,	#0
    movz	w19,	#1
    ldr	w24,	[sp, #1132]

    csel	w26,	w19,	w20,	ne
    cmp	w24,	#0
    cset	w22,	ne
    mov	w24,	w22
    cmp	w0,	#0
    movz	w28,	#0
    csel	w21,	w24,	w28,	ne
    cmp	w21,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w26,	#0
    movz	w27,	#0
    csel	w18,	w20,	w27,	ne
    str	w18,	[sp, #1104]

    ldr	w27,	[sp, #1100]

    cmp	w27,	#0
    ldr	w26,	[sp, #1132]

    cset	w23,	ne
    cmp	w26,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w0,	#0
    movz	w28,	#0
    csel	w0,	w27,	w28,	ne
    cmp	w0,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w23,	#0
    movz	w21,	#1
    csel	w18,	w21,	w18,	ne
    str	w18,	[sp, #1136]

    ldr	w28,	[sp, #832]

    cmp	w28,	#0
    cset	w21,	ne
    cmp	w21,	#0
    cset	w25,	eq
    cmp	w25,	#0
    ldr	w28,	[sp, #1136]

    cset	w26,	ne
    cmp	w28,	#0
    cset	w20,	ne
    mov	w23,	w20
    cmp	w26,	#0
    movz	w22,	#1
    ldr	w0,	[sp, #1136]

    csel	w28,	w22,	w23,	ne
    cmp	w0,	#0
    cset	w0,	ne
    cmp	w26,	#0
    movz	w21,	#0
    csel	w0,	w0,	w21,	ne
    cmp	w0,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w21,	ne
    mov	w24,	w21
    cmp	w28,	#0
    movz	w18,	#0
    csel	w19,	w24,	w18,	ne
    str	w19,	[sp, #1088]

    ldr	w18,	[sp, #832]

    cmp	w18,	#0
    cset	w27,	ne
    ldr	w19,	[sp, #1136]

    cmp	w19,	#0
    cset	w22,	ne
    mov	w25,	w22
    cmp	w26,	#0
    movz	w21,	#0
    csel	w22,	w25,	w21,	ne
    cmp	w22,	#0
    cset	w0,	ne
    cmp	w27,	#0
    movz	w27,	#1
    csel	w24,	w27,	w0,	ne
    ldr	w27,	[sp, #632]

    cmp	w27,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w0,	ne
    cmp	w24,	#0
    cset	w18,	ne
    mov	w21,	w18
    cmp	w0,	#0
    movz	w19,	#1
    csel	w22,	w19,	w21,	ne
    cmp	w24,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w0,	#0
    movz	w28,	#0
    csel	w25,	w25,	w28,	ne
    cmp	w25,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w22,	#0
    movz	w27,	#0
    csel	w20,	w23,	w27,	ne
    str	w20,	[sp, #128]

    ldr	w18,	[sp, #632]

    cmp	w18,	#0
    cset	w18,	ne
    cmp	w24,	#0
    cset	w25,	ne
    mov	w28,	w25
    cmp	w0,	#0
    movz	w23,	#0
    csel	w21,	w28,	w23,	ne
    cmp	w21,	#0
    cset	w27,	ne
    mov	w0,	w27
    cmp	w18,	#0
    movz	w19,	#1
    csel	w23,	w19,	w0,	ne
    ldr	w0,	[sp, #660]

    cmp	w0,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w28,	ne
    cmp	w23,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w28,	#0
    movz	w20,	#1
    csel	w18,	w20,	w18,	ne
    cmp	w23,	#0
    cset	w21,	ne
    mov	w24,	w21
    cmp	w28,	#0
    movz	w0,	#0
    csel	w22,	w24,	w0,	ne
    cmp	w22,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w27,	ne
    mov	w19,	w27
    cmp	w18,	#0
    movz	w0,	#0
    csel	w27,	w19,	w0,	ne
    str	w27,	[sp, #1056]

    ldr	w26,	[sp, #660]

    cmp	w26,	#0
    cset	w22,	ne
    cmp	w23,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w28,	#0
    movz	w27,	#0
    csel	w20,	w20,	w27,	ne
    cmp	w20,	#0
    cset	w18,	ne
    mov	w21,	w18
    cmp	w22,	#0
    ldr	w26,	[sp, #672]

    movz	w0,	#1
    csel	w20,	w0,	w21,	ne
    cmp	w26,	#0
    cset	w21,	ne
    cmp	w21,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w20,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w0,	#0
    movz	w24,	#1
    csel	w21,	w24,	w23,	ne
    cmp	w20,	#0
    cset	w27,	ne
    str	w27,	[sp, #808]

    cmp	w0,	#0
    movz	w19,	#0
    ldr	w28,	[sp, #808]

    mov	w24,	w19
    csel	w22,	w28,	w24,	ne
    cmp	w22,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w22,	ne
    mov	w25,	w22
    cmp	w21,	#0
    movz	w21,	#0
    csel	w28,	w25,	w21,	ne
    str	w28,	[sp, #1156]

    ldr	w28,	[sp, #672]

    cmp	w28,	#0
    cset	w27,	ne
    cmp	w20,	#0
    cset	w25,	ne
    mov	w19,	w25
    cmp	w0,	#0
    movz	w18,	#0
    csel	w0,	w19,	w18,	ne
    cmp	w0,	#0
    cset	w22,	ne
    mov	w24,	w22
    cmp	w27,	#0
    ldr	w21,	[sp, #676]

    movz	w28,	#1
    csel	w18,	w28,	w24,	ne
    cmp	w21,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w21,	eq
    cmp	w21,	#0
    cset	w24,	ne
    mov	w28,	w24
    cmp	w18,	#0
    cset	w26,	ne
    str	w26,	[sp, #812]

    cmp	w28,	#0
    movz	w0,	#1
    ldr	w23,	[sp, #812]

    csel	w22,	w0,	w23,	ne
    cmp	w18,	#0
    cset	w20,	ne
    mov	w23,	w20
    cmp	w28,	#0
    movz	w21,	#0
    csel	w20,	w23,	w21,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w24,	ne
    mov	w26,	w24
    cmp	w22,	#0
    ldr	w23,	[sp, #1156]

    movz	w20,	#0
    ldr	w25,	[sp, #1056]

    csel	w18,	w26,	w20,	ne
    ldr	w28,	[sp, #128]

    lsl	w21,	w18,	#1
    ldr	w26,	[sp, #1088]

    add	w20,	w21,	w23
    lsl	w21,	w20,	#1
    add	w19,	w21,	w25
    lsl	w22,	w19,	#1
    add	w21,	w22,	w28
    lsl	w0,	w21,	#1
    add	w23,	w0,	w26
    lsl	w26,	w23,	#1
    ldr	w23,	[sp, #1104]

    add	w25,	w26,	w23
    ldr	w23,	[sp, #1128]

    ldr	w20,	[sp, #1124]

    lsl	w28,	w25,	#1
    ldr	w26,	[sp, #1108]

    ldr	w0,	[sp, #1112]

    add	w27,	w28,	w23
    lsl	w18,	w27,	#1
    ldr	w27,	[sp, #816]

    add	w18,	w18,	w20
    ldr	w28,	[sp, #620]

    lsl	w21,	w18,	#1
    add	w20,	w21,	w26
    lsl	w24,	w20,	#1
    add	w0,	w24,	w0
    lsl	w23,	w0,	#1
    add	w24,	w23,	w27
    ldr	w23,	[sp, #648]

    ldr	w20,	[sp, #668]

    lsl	w25,	w24,	#1
    ldr	w24,	[sp, #684]

    add	w26,	w25,	w28
    lsl	w27,	w26,	#1
    add	w28,	w27,	w23
    lsl	w18,	w28,	#1
    add	w19,	w18,	w20
    lsl	w20,	w19,	#1
    ldr	w19,	[sp, #692]

    add	w21,	w20,	w24
    lsl	w0,	w21,	#1
    add	w0,	w0,	w19
    bl	fib
    movz	w4,	#0
    ldr	w14,	[sp, #708]

    ldr	w20,	[sp, #708]

    asr	w12,	w14,	#31
    ldr	w21,	[sp, #708]

    lsr	w13,	w12,	#31
    add	w14,	w20,	w13
    asr	w5,	w14,	#1
    lsl	w6,	w5,	#1
    sub	w1,	w21,	w6
    sub	w3,	w4,	w1
    cmp	w1,	#0
    ldr	w22,	[sp, #708]

    csel	w7,	w3,	w1,	lt
    asr	w23,	w22,	#31
    ldr	w28,	[sp, #708]

    movz	w1,	#0
    lsr	w24,	w23,	#31
    add	w25,	w28,	w24
    asr	w5,	w25,	#1
    asr	w2,	w5,	#31
    lsr	w3,	w2,	#31
    add	w6,	w5,	w3
    asr	w11,	w6,	#1
    lsl	w12,	w11,	#1
    sub	w3,	w5,	w12
    sub	w6,	w1,	w3
    cmp	w3,	#0
    movz	w25,	#0
    asr	w8,	w5,	#31
    csel	w9,	w6,	w3,	lt
    lsr	w10,	w8,	#31
    str	w9,	[sp, #564]

    add	w2,	w5,	w10
    asr	w11,	w2,	#1
    asr	w10,	w11,	#31
    lsr	w13,	w10,	#31
    add	w14,	w11,	w13
    asr	w3,	w14,	#1
    lsl	w4,	w3,	#1
    sub	w5,	w11,	w4
    sub	w10,	w25,	w5
    cmp	w5,	#0
    csel	w12,	w10,	w5,	lt
    asr	w15,	w11,	#31
    movz	w21,	#0
    str	w12,	[sp, #908]

    lsr	w16,	w15,	#31
    add	w10,	w11,	w16
    asr	w17,	w10,	#1
    asr	w18,	w17,	#31
    lsr	w19,	w18,	#31
    add	w20,	w17,	w19
    asr	w1,	w20,	#1
    lsl	w2,	w1,	#1
    sub	w12,	w17,	w2
    sub	w15,	w21,	w12
    cmp	w12,	#0
    asr	w21,	w17,	#31
    csel	w3,	w15,	w12,	lt
    str	w3,	[sp, #560]

    lsr	w22,	w21,	#31
    add	w16,	w17,	w22
    movz	w17,	#0
    asr	w24,	w16,	#1
    asr	w23,	w24,	#31
    lsr	w25,	w23,	#31
    add	w26,	w24,	w25
    asr	w25,	w26,	#1
    lsl	w26,	w25,	#1
    sub	w19,	w24,	w26
    sub	w20,	w17,	w19
    cmp	w19,	#0
    movz	w13,	#0
    asr	w27,	w24,	#31
    csel	w14,	w20,	w19,	lt
    lsr	w28,	w27,	#31
    str	w14,	[sp, #568]

    add	w22,	w24,	w28
    asr	w1,	w22,	#1
    asr	w3,	w1,	#31
    lsr	w4,	w3,	#31
    add	w3,	w1,	w4
    asr	w20,	w3,	#1
    lsl	w21,	w20,	#1
    sub	w25,	w1,	w21
    sub	w26,	w13,	w25
    cmp	w25,	#0
    movz	w9,	#0
    asr	w4,	w1,	#31
    csel	w25,	w26,	w25,	lt
    lsr	w5,	w4,	#31
    str	w25,	[sp, #872]

    add	w28,	w1,	w5
    asr	w3,	w28,	#1
    asr	w10,	w3,	#31
    lsr	w11,	w10,	#31
    add	w12,	w3,	w11
    asr	w17,	w12,	#1
    lsl	w18,	w17,	#1
    sub	w4,	w3,	w18
    sub	w6,	w9,	w4
    cmp	w4,	#0
    asr	w13,	w3,	#31
    csel	w19,	w6,	w4,	lt
    movz	w4,	#0
    str	w19,	[sp, #572]

    lsr	w14,	w13,	#31
    add	w5,	w3,	w14
    asr	w12,	w5,	#1
    asr	w16,	w12,	#31
    lsr	w17,	w16,	#31
    add	w18,	w12,	w17
    asr	w13,	w18,	#1
    lsl	w14,	w13,	#1
    sub	w8,	w12,	w14
    sub	w10,	w4,	w8
    cmp	w8,	#0
    csel	w24,	w10,	w8,	lt
    asr	w19,	w12,	#31
    movz	w1,	#0
    str	w24,	[sp, #576]

    lsr	w20,	w19,	#31
    add	w13,	w12,	w20
    asr	w16,	w13,	#1
    asr	w22,	w16,	#31
    lsr	w23,	w22,	#31
    add	w24,	w16,	w23
    asr	w5,	w24,	#1
    lsl	w6,	w5,	#1
    sub	w13,	w16,	w6
    sub	w15,	w1,	w13
    cmp	w13,	#0
    csel	w1,	w15,	w13,	lt
    asr	w25,	w16,	#31
    str	w1,	[sp, #580]

    lsr	w26,	w25,	#31
    movz	w25,	#0
    add	w19,	w16,	w26
    asr	w21,	w19,	#1
    asr	w28,	w21,	#31
    lsr	w1,	w28,	#31
    add	w2,	w21,	w1
    asr	w3,	w2,	#1
    lsl	w2,	w3,	#1
    sub	w17,	w21,	w2
    sub	w20,	w25,	w17
    cmp	w17,	#0
    asr	w3,	w21,	#31
    csel	w6,	w20,	w17,	lt
    str	w6,	[sp, #856]

    lsr	w2,	w3,	#31
    add	w25,	w21,	w2
    movz	w21,	#0
    asr	w26,	w25,	#1
    asr	w4,	w26,	#31
    lsr	w5,	w4,	#31
    add	w6,	w26,	w5
    asr	w27,	w6,	#1
    lsl	w28,	w27,	#1
    sub	w24,	w26,	w28
    sub	w27,	w21,	w24
    cmp	w24,	#0
    asr	w9,	w26,	#31
    movz	w17,	#0
    csel	w12,	w27,	w24,	lt
    lsr	w10,	w9,	#31
    str	w12,	[sp, #860]

    add	w2,	w26,	w10
    asr	w2,	w2,	#1
    asr	w13,	w2,	#31
    lsr	w14,	w13,	#31
    add	w15,	w2,	w14
    asr	w22,	w15,	#1
    lsl	w23,	w22,	#1
    sub	w3,	w2,	w23
    sub	w6,	w17,	w3
    cmp	w3,	#0
    movz	w13,	#0
    csel	w17,	w6,	w3,	lt
    asr	w16,	w2,	#31
    str	w17,	[sp, #912]

    lsr	w17,	w16,	#31
    add	w10,	w2,	w17
    asr	w5,	w10,	#1
    asr	w20,	w5,	#31
    lsr	w21,	w20,	#31
    add	w22,	w5,	w21
    asr	w19,	w22,	#1
    lsl	w20,	w19,	#1
    sub	w8,	w5,	w20
    sub	w12,	w13,	w8
    cmp	w8,	#0
    asr	w23,	w5,	#31
    csel	w17,	w12,	w8,	lt
    movz	w9,	#0
    str	w17,	[sp, #864]

    lsr	w24,	w23,	#31
    add	w16,	w5,	w24
    asr	w14,	w16,	#1
    asr	w17,	w14,	#31
    lsr	w18,	w17,	#31
    add	w19,	w14,	w18
    asr	w27,	w19,	#1
    lsl	w28,	w27,	#1
    sub	w17,	w14,	w28
    sub	w18,	w9,	w17
    cmp	w17,	#0
    csel	w20,	w18,	w17,	lt
    movz	w4,	#0
    str	w20,	[sp, #892]

    asr	w20,	w14,	#31
    lsr	w21,	w20,	#31
    add	w22,	w14,	w21
    asr	w14,	w22,	#1
    asr	w23,	w14,	#31
    lsr	w24,	w23,	#31
    add	w25,	w14,	w24
    asr	w23,	w25,	#1
    lsl	w24,	w23,	#1
    sub	w22,	w14,	w24
    sub	w23,	w4,	w22
    cmp	w22,	#0
    movz	w1,	#0
    asr	w26,	w14,	#31
    csel	w11,	w23,	w22,	lt
    lsr	w27,	w26,	#31
    str	w11,	[sp, #884]

    add	w28,	w14,	w27
    asr	w22,	w28,	#1
    asr	w10,	w22,	#31
    lsr	w11,	w10,	#31
    add	w12,	w22,	w11
    asr	w3,	w12,	#1
    lsl	w4,	w3,	#1
    sub	w26,	w22,	w4
    sub	w28,	w1,	w26
    cmp	w26,	#0
    asr	w3,	w0,	#31
    csel	w16,	w28,	w26,	lt
    movz	w26,	#0
    str	w16,	[sp, #888]

    lsr	w4,	w3,	#31
    add	w5,	w0,	w4
    asr	w16,	w5,	#1
    lsl	w17,	w16,	#1
    sub	w3,	w0,	w17
    sub	w2,	w26,	w3
    cmp	w3,	#0
    csel	w6,	w2,	w3,	lt
    movz	w13,	#0
    asr	w17,	w0,	#31
    lsr	w18,	w17,	#31
    add	w9,	w0,	w18
    asr	w26,	w9,	#1
    asr	w10,	w26,	#31
    lsr	w11,	w10,	#31
    add	w12,	w26,	w11
    asr	w11,	w12,	#1
    lsl	w12,	w11,	#1
    sub	w4,	w26,	w12
    sub	w10,	w13,	w4
    cmp	w4,	#0
    asr	w22,	w26,	#31
    csel	w1,	w10,	w4,	lt
    movz	w10,	#0
    lsr	w23,	w22,	#31
    add	w24,	w26,	w23
    asr	w17,	w24,	#1
    asr	w25,	w17,	#31
    lsr	w26,	w25,	#31
    add	w27,	w17,	w26
    asr	w20,	w27,	#1
    lsl	w21,	w20,	#1
    sub	w13,	w17,	w21
    sub	w14,	w10,	w13
    cmp	w13,	#0
    asr	w12,	w17,	#31
    csel	w8,	w14,	w13,	lt
    lsr	w13,	w12,	#31
    add	w14,	w17,	w13
    asr	w14,	w14,	#1
    asr	w2,	w14,	#31
    lsr	w3,	w2,	#31
    add	w4,	w14,	w3
    asr	w20,	w4,	#1
    movz	w4,	#0
    lsl	w21,	w20,	#1
    sub	w22,	w14,	w21
    sub	w16,	w4,	w22
    cmp	w22,	#0
    asr	w5,	w14,	#31
    movz	w4,	#0
    csel	w20,	w16,	w22,	lt
    lsr	w9,	w5,	#31
    str	w20,	[sp, #904]

    add	w20,	w14,	w9
    asr	w3,	w20,	#1
    asr	w15,	w3,	#31
    lsr	w16,	w15,	#31
    add	w17,	w3,	w16
    asr	w16,	w17,	#1
    lsl	w17,	w16,	#1
    sub	w26,	w3,	w17
    sub	w21,	w4,	w26
    cmp	w26,	#0
    csel	w25,	w21,	w26,	lt
    asr	w10,	w3,	#31
    lsr	w0,	w10,	#31
    add	w18,	w3,	w0
    movz	w0,	#0
    asr	w15,	w18,	#1
    asr	w3,	w15,	#31
    lsr	w4,	w3,	#31
    add	w5,	w15,	w4
    asr	w21,	w5,	#1
    lsl	w22,	w21,	#1
    sub	w27,	w15,	w22
    sub	w17,	w0,	w27
    cmp	w27,	#0
    csel	w9,	w17,	w27,	lt
    str	w9,	[sp, #548]

    asr	w9,	w15,	#31
    lsr	w12,	w9,	#31
    add	w24,	w15,	w12
    asr	w20,	w24,	#1
    movz	w24,	#0
    asr	w14,	w20,	#31
    lsr	w15,	w14,	#31
    add	w16,	w20,	w15
    asr	w15,	w16,	#1
    lsl	w16,	w15,	#1
    sub	w9,	w20,	w16
    sub	w23,	w24,	w9
    cmp	w9,	#0
    csel	w10,	w23,	w9,	lt
    asr	w17,	w20,	#31
    str	w10,	[sp, #900]

    lsr	w19,	w17,	#31
    add	w0,	w20,	w19
    movz	w20,	#0
    asr	w2,	w0,	#1
    asr	w22,	w2,	#31
    lsr	w23,	w22,	#31
    add	w24,	w2,	w23
    asr	w13,	w24,	#1
    lsl	w14,	w13,	#1
    sub	w5,	w2,	w14
    sub	w13,	w20,	w5
    cmp	w5,	#0
    csel	w19,	w13,	w5,	lt
    movz	w16,	#0
    str	w19,	[sp, #556]

    asr	w5,	w2,	#31
    lsr	w9,	w5,	#31
    add	w12,	w2,	w9
    asr	w9,	w12,	#1
    asr	w13,	w9,	#31
    lsr	w14,	w13,	#31
    add	w15,	w9,	w14
    asr	w22,	w15,	#1
    lsl	w23,	w22,	#1
    sub	w15,	w9,	w23
    sub	w18,	w16,	w15
    cmp	w15,	#0
    asr	w16,	w9,	#31
    csel	w11,	w18,	w15,	lt
    movz	w12,	#0
    str	w11,	[sp, #880]

    lsr	w17,	w16,	#31
    add	w18,	w9,	w17
    asr	w24,	w18,	#1
    asr	w19,	w24,	#31
    lsr	w20,	w19,	#31
    add	w21,	w24,	w20
    asr	w18,	w21,	#1
    lsl	w19,	w18,	#1
    sub	w22,	w24,	w19
    sub	w23,	w12,	w22
    cmp	w22,	#0
    csel	w14,	w23,	w22,	lt
    movz	w5,	#0
    asr	w22,	w24,	#31
    str	w14,	[sp, #552]

    lsr	w23,	w22,	#31
    add	w24,	w24,	w23
    asr	w27,	w24,	#1
    asr	w15,	w27,	#31
    lsr	w16,	w15,	#31
    add	w17,	w27,	w16
    asr	w22,	w17,	#1
    lsl	w23,	w22,	#1
    sub	w19,	w27,	w23
    sub	w20,	w5,	w19
    cmp	w19,	#0
    csel	w4,	w20,	w19,	lt
    asr	w18,	w27,	#31
    str	w4,	[sp, #848]

    lsr	w19,	w18,	#31
    add	w0,	w27,	w19
    asr	w3,	w0,	#1
    movz	w0,	#0
    asr	w23,	w3,	#31
    lsr	w24,	w23,	#31
    add	w26,	w3,	w24
    asr	w20,	w26,	#1
    lsl	w21,	w20,	#1
    sub	w27,	w3,	w21
    sub	w28,	w0,	w27
    cmp	w27,	#0
    movz	w2,	#0
    csel	w4,	w28,	w27,	lt
    asr	w27,	w3,	#31
    str	w4,	[sp, #656]

    lsr	w28,	w27,	#31
    add	w12,	w3,	w28
    asr	w10,	w12,	#1
    asr	w3,	w10,	#31
    lsr	w9,	w3,	#31
    add	w0,	w10,	w9
    asr	w16,	w0,	#1
    lsl	w17,	w16,	#1
    sub	w12,	w10,	w17
    sub	w0,	w2,	w12
    cmp	w12,	#0
    movz	w26,	#0
    csel	w20,	w0,	w12,	lt
    asr	w2,	w10,	#31
    str	w20,	[sp, #644]

    lsr	w3,	w2,	#31
    add	w18,	w10,	w3
    asr	w16,	w18,	#1
    asr	w5,	w16,	#31
    lsr	w9,	w5,	#31
    add	w12,	w16,	w9
    asr	w5,	w12,	#1
    lsl	w9,	w5,	#1
    sub	w5,	w16,	w9
    sub	w13,	w26,	w5
    cmp	w5,	#0
    csel	w13,	w13,	w5,	lt
    movz	w21,	#0
    str	w13,	[sp, #640]

    asr	w13,	w16,	#31
    lsr	w14,	w13,	#31
    add	w24,	w16,	w14
    asr	w23,	w24,	#1
    asr	w16,	w23,	#31
    lsr	w17,	w16,	#31
    add	w18,	w23,	w17
    asr	w0,	w18,	#1
    lsl	w2,	w0,	#1
    sub	w15,	w23,	w2
    sub	w18,	w21,	w15
    cmp	w15,	#0
    csel	w20,	w18,	w15,	lt
    asr	w19,	w23,	#31
    movz	w17,	#0
    str	w20,	[sp, #624]

    lsr	w20,	w19,	#31
    add	w0,	w23,	w20
    asr	w10,	w0,	#1
    asr	w2,	w10,	#31
    lsr	w3,	w2,	#31
    add	w4,	w10,	w3
    asr	w18,	w4,	#1
    lsl	w19,	w18,	#1
    sub	w3,	w10,	w19
    sub	w10,	w17,	w3
    cmp	w3,	#0
    csel	w3,	w10,	w3,	lt
    str	w3,	[sp, #896]

    cmp	w6,	#0
    cset	w9,	ne
    cmp	w7,	#0
    movz	w24,	#1
    mov	w23,	w24
    csel	w15,	w23,	w9,	ne
    str	w15,	[sp, #836]

    cmp	w6,	#0
    cset	w20,	ne
    mov	w21,	w20
    cmp	w7,	#0
    movz	w15,	#0
    csel	w19,	w21,	w15,	ne
    cmp	w19,	#0
    cset	w17,	eq
    cmp	w17,	#0
    cset	w19,	ne
    ldr	w27,	[sp, #836]

    cmp	w27,	#0
    movz	w22,	#0
    mov	w21,	w22
    csel	w26,	w19,	w21,	ne
    cmp	w26,	#0
    cset	w23,	ne
    cmp	w23,	#0
    cset	w26,	ne
    mov	w21,	w26
    cmp	w6,	#0
    cset	w2,	ne
    cmp	w7,	#0
    movz	w4,	#0
    mov	w3,	w4
    csel	w0,	w2,	w3,	ne
    cmp	w0,	#0
    cset	w20,	ne
    cmp	w1,	#0
    cset	w24,	ne
    ldr	w19,	[sp, #564]

    mov	w26,	w24
    cmp	w19,	#0
    movz	w12,	#1
    csel	w15,	w12,	w26,	ne
    str	w15,	[sp, #840]

    cmp	w1,	#0
    cset	w2,	ne
    ldr	w23,	[sp, #564]

    mov	w3,	w2
    cmp	w23,	#0
    movz	w12,	#0
    mov	w11,	w12
    csel	w16,	w3,	w11,	ne
    cmp	w16,	#0
    cset	w0,	eq
    cmp	w0,	#0
    ldr	w6,	[sp, #840]

    cset	w3,	ne
    cmp	w6,	#0
    movz	w12,	#0
    mov	w11,	w12
    csel	w24,	w3,	w11,	ne
    str	w24,	[sp, #792]

    cmp	w20,	#0
    cset	w7,	ne
    ldr	w3,	[sp, #792]

    cmp	w3,	#0
    movz	w11,	#1
    mov	w10,	w11
    csel	w18,	w10,	w7,	ne
    str	w18,	[sp, #788]

    cmp	w20,	#0
    cset	w23,	ne
    ldr	w4,	[sp, #792]

    mov	w24,	w23
    cmp	w4,	#0
    movz	w12,	#0
    csel	w4,	w24,	w12,	ne
    cmp	w4,	#0
    cset	w16,	eq
    cmp	w16,	#0
    ldr	w6,	[sp, #788]

    cset	w18,	ne
    mov	w19,	w18
    cmp	w6,	#0
    movz	w6,	#0
    csel	w3,	w19,	w6,	ne
    str	w3,	[sp, #852]

    cmp	w1,	#0
    ldr	w4,	[sp, #564]

    cset	w26,	ne
    mov	w27,	w26
    cmp	w4,	#0
    movz	w4,	#0
    csel	w14,	w27,	w4,	ne
    cmp	w20,	#0
    cset	w12,	ne
    ldr	w2,	[sp, #792]

    cmp	w2,	#0
    movz	w26,	#0
    mov	w24,	w26
    csel	w12,	w12,	w24,	ne
    cmp	w12,	#0
    cset	w16,	ne
    cmp	w14,	#0
    movz	w23,	#1
    csel	w6,	w23,	w16,	ne
    cmp	w8,	#0
    cset	w20,	ne
    ldr	w26,	[sp, #908]

    mov	w22,	w20
    cmp	w26,	#0
    movz	w19,	#1
    csel	w13,	w19,	w22,	ne
    cmp	w8,	#0
    cset	w27,	ne
    ldr	w26,	[sp, #908]

    mov	w28,	w27
    cmp	w26,	#0
    movz	w18,	#0
    csel	w5,	w28,	w18,	ne
    cmp	w5,	#0
    cset	w2,	eq
    cmp	w2,	#0
    cset	w1,	ne
    cmp	w13,	#0
    movz	w19,	#0
    mov	w18,	w19
    csel	w24,	w1,	w18,	ne
    cmp	w6,	#0
    cset	w5,	ne
    cmp	w24,	#0
    movz	w18,	#1
    mov	w17,	w18
    csel	w19,	w17,	w5,	ne
    str	w19,	[sp, #844]

    cmp	w6,	#0
    cset	w28,	ne
    mov	w0,	w28
    cmp	w24,	#0
    movz	w2,	#0
    mov	w1,	w2
    csel	w15,	w0,	w1,	ne
    cmp	w15,	#0
    cset	w14,	eq
    cmp	w14,	#0
    ldr	w23,	[sp, #844]

    cset	w16,	ne
    mov	w17,	w16
    cmp	w23,	#0
    movz	w14,	#0
    csel	w4,	w17,	w14,	ne
    str	w4,	[sp, #876]

    cmp	w8,	#0
    ldr	w17,	[sp, #908]

    cset	w19,	ne
    mov	w20,	w19
    cmp	w17,	#0
    movz	w12,	#0
    csel	w7,	w20,	w12,	ne
    cmp	w6,	#0
    cset	w26,	ne
    mov	w27,	w26
    cmp	w24,	#0
    movz	w11,	#0
    csel	w27,	w27,	w11,	ne
    cmp	w27,	#0
    cset	w1,	ne
    cmp	w7,	#0
    movz	w11,	#1
    ldr	w6,	[sp, #904]

    csel	w27,	w11,	w1,	ne
    cmp	w6,	#0
    ldr	w4,	[sp, #560]

    cset	w3,	ne
    cmp	w4,	#0
    movz	w11,	#1
    ldr	w7,	[sp, #904]

    mov	w10,	w11
    csel	w1,	w10,	w3,	ne
    cmp	w7,	#0
    cset	w7,	ne
    ldr	w4,	[sp, #560]

    cmp	w4,	#0
    movz	w10,	#0
    mov	w9,	w10
    csel	w14,	w7,	w9,	ne
    cmp	w14,	#0
    cset	w11,	eq
    cmp	w11,	#0
    cset	w13,	ne
    mov	w14,	w13
    cmp	w1,	#0
    movz	w7,	#0
    csel	w14,	w14,	w7,	ne
    cmp	w27,	#0
    cset	w17,	ne
    mov	w18,	w17
    cmp	w14,	#0
    movz	w6,	#1
    csel	w13,	w6,	w18,	ne
    cmp	w27,	#0
    cset	w9,	ne
    cmp	w14,	#0
    movz	w22,	#0
    mov	w20,	w22
    csel	w26,	w9,	w20,	ne
    cmp	w26,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w1,	ne
    mov	w2,	w1
    cmp	w13,	#0
    movz	w5,	#0
    mov	w4,	w5
    csel	w20,	w2,	w4,	ne
    str	w20,	[sp, #868]

    ldr	w8,	[sp, #904]

    cmp	w8,	#0
    ldr	w6,	[sp, #560]

    cset	w3,	ne
    cmp	w6,	#0
    movz	w5,	#0
    mov	w4,	w5
    csel	w3,	w3,	w4,	ne
    cmp	w27,	#0
    cset	w7,	ne
    cmp	w14,	#0
    movz	w2,	#0
    csel	w10,	w7,	w2,	ne
    cmp	w10,	#0
    cset	w11,	ne
    cmp	w3,	#0
    movz	w1,	#1
    csel	w4,	w1,	w11,	ne
    cmp	w25,	#0
    cset	w15,	ne
    ldr	w13,	[sp, #568]

    mov	w16,	w15
    cmp	w13,	#0
    movz	w0,	#1
    csel	w13,	w0,	w16,	ne
    cmp	w25,	#0
    cset	w19,	ne
    ldr	w14,	[sp, #568]

    mov	w20,	w19
    cmp	w14,	#0
    movz	w2,	#0
    mov	w1,	w2
    csel	w27,	w20,	w1,	ne
    cmp	w27,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    cmp	w13,	#0
    movz	w1,	#0
    csel	w13,	w28,	w1,	ne
    cmp	w4,	#0
    cset	w1,	ne
    cmp	w13,	#0
    movz	w0,	#1
    mov	w28,	w0
    csel	w2,	w28,	w1,	ne
    cmp	w4,	#0
    cset	w26,	ne
    mov	w27,	w26
    cmp	w13,	#0
    movz	w11,	#0
    csel	w28,	w27,	w11,	ne
    cmp	w28,	#0
    cset	w9,	eq
    cmp	w9,	#0
    cset	w11,	ne
    cmp	w2,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w28,	w11,	w26,	ne
    str	w28,	[sp, #612]

    cmp	w25,	#0
    ldr	w16,	[sp, #568]

    cset	w15,	ne
    cmp	w16,	#0
    movz	w25,	#0
    mov	w24,	w25
    csel	w1,	w15,	w24,	ne
    cmp	w4,	#0
    cset	w19,	ne
    cmp	w13,	#0
    movz	w24,	#0
    csel	w13,	w19,	w24,	ne
    cmp	w13,	#0
    cset	w25,	ne
    cmp	w1,	#0
    movz	w19,	#1
    ldr	w18,	[sp, #548]

    csel	w6,	w19,	w25,	ne
    cmp	w18,	#0
    cset	w0,	ne
    ldr	w26,	[sp, #872]

    cmp	w26,	#0
    movz	w19,	#1
    csel	w16,	w19,	w0,	ne
    ldr	w19,	[sp, #548]

    cmp	w19,	#0
    ldr	w27,	[sp, #872]

    cset	w3,	ne
    cmp	w27,	#0
    movz	w19,	#0
    mov	w18,	w19
    csel	w5,	w3,	w18,	ne
    cmp	w5,	#0
    cset	w7,	eq
    cmp	w7,	#0
    cset	w9,	ne
    cmp	w16,	#0
    movz	w18,	#0
    csel	w24,	w9,	w18,	ne
    cmp	w6,	#0
    cset	w13,	ne
    cmp	w24,	#0
    movz	w17,	#1
    mov	w16,	w17
    csel	w9,	w16,	w13,	ne
    cmp	w6,	#0
    cset	w17,	ne
    mov	w18,	w17
    cmp	w24,	#0
    movz	w14,	#0
    csel	w19,	w18,	w14,	ne
    cmp	w19,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w9,	#0
    movz	w13,	#0
    csel	w25,	w26,	w13,	ne
    str	w25,	[sp, #608]

    ldr	w20,	[sp, #548]

    cmp	w20,	#0
    cset	w0,	ne
    ldr	w28,	[sp, #872]

    cmp	w28,	#0
    movz	w13,	#0
    csel	w23,	w0,	w13,	ne
    cmp	w6,	#0
    cset	w3,	ne
    cmp	w24,	#0
    movz	w13,	#0
    csel	w28,	w3,	w13,	ne
    cmp	w28,	#0
    cset	w7,	ne
    cmp	w23,	#0
    ldr	w28,	[sp, #900]

    movz	w12,	#1
    csel	w14,	w12,	w7,	ne
    cmp	w28,	#0
    cset	w11,	ne
    ldr	w19,	[sp, #572]

    cmp	w19,	#0
    ldr	w0,	[sp, #900]

    movz	w9,	#1
    csel	w10,	w9,	w11,	ne
    cmp	w0,	#0
    ldr	w20,	[sp, #572]

    cset	w15,	ne
    mov	w16,	w15
    cmp	w20,	#0
    movz	w8,	#0
    csel	w17,	w16,	w8,	ne
    cmp	w17,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w23,	ne
    cmp	w10,	#0
    movz	w7,	#0
    csel	w17,	w23,	w7,	ne
    cmp	w14,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w17,	#0
    movz	w6,	#1
    csel	w15,	w6,	w28,	ne
    cmp	w14,	#0
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
    csel	w22,	w7,	w4,	ne
    str	w22,	[sp, #604]

    ldr	w1,	[sp, #900]

    cmp	w1,	#0
    cset	w11,	ne
    ldr	w22,	[sp, #572]

    cmp	w22,	#0
    movz	w3,	#0
    csel	w8,	w11,	w3,	ne
    cmp	w14,	#0
    cset	w15,	ne
    cmp	w17,	#0
    movz	w2,	#0
    csel	w12,	w15,	w2,	ne
    cmp	w12,	#0
    cset	w19,	ne
    cmp	w8,	#0
    ldr	w0,	[sp, #556]

    movz	w1,	#1
    csel	w20,	w1,	w19,	ne
    cmp	w0,	#0
    ldr	w24,	[sp, #576]

    cset	w25,	ne
    cmp	w24,	#0
    ldr	w1,	[sp, #556]

    movz	w0,	#1
    csel	w24,	w0,	w25,	ne
    cmp	w1,	#0
    ldr	w26,	[sp, #576]

    cset	w0,	ne
    mov	w1,	w0
    cmp	w26,	#0
    movz	w0,	#0
    mov	w28,	w0
    csel	w1,	w1,	w28,	ne
    cmp	w1,	#0
    cset	w3,	eq
    cmp	w3,	#0
    cset	w5,	ne
    cmp	w24,	#0
    movz	w0,	#0
    csel	w22,	w5,	w0,	ne
    cmp	w20,	#0
    cset	w9,	ne
    cmp	w22,	#0
    movz	w28,	#1
    csel	w18,	w28,	w9,	ne
    cmp	w20,	#0
    cset	w13,	ne
    cmp	w22,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w9,	w13,	w26,	ne
    cmp	w9,	#0
    cset	w17,	eq
    cmp	w17,	#0
    cset	w19,	ne
    cmp	w18,	#0
    movz	w26,	#0
    csel	w18,	w19,	w26,	ne
    str	w18,	[sp, #600]

    ldr	w2,	[sp, #556]

    cmp	w2,	#0
    cset	w25,	ne
    ldr	w27,	[sp, #576]

    cmp	w27,	#0
    movz	w23,	#0
    csel	w17,	w25,	w23,	ne
    cmp	w20,	#0
    cset	w0,	ne
    cmp	w22,	#0
    movz	w22,	#0
    csel	w27,	w0,	w22,	ne
    cmp	w27,	#0
    cset	w3,	ne
    cmp	w17,	#0
    movz	w22,	#1
    ldr	w4,	[sp, #880]

    csel	w24,	w22,	w3,	ne
    cmp	w4,	#0
    ldr	w1,	[sp, #580]

    cset	w7,	ne
    cmp	w1,	#0
    movz	w20,	#1
    ldr	w5,	[sp, #880]

    csel	w14,	w20,	w7,	ne
    cmp	w5,	#0
    cset	w11,	ne
    ldr	w2,	[sp, #580]

    cmp	w2,	#0
    movz	w19,	#0
    csel	w13,	w11,	w19,	ne
    cmp	w13,	#0
    cset	w15,	eq
    cmp	w15,	#0
    cset	w17,	ne
    cmp	w14,	#0
    movz	w16,	#0
    csel	w12,	w17,	w16,	ne
    cmp	w24,	#0
    cset	w23,	ne
    cmp	w12,	#0
    movz	w15,	#1
    csel	w5,	w15,	w23,	ne
    cmp	w24,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w12,	#0
    movz	w14,	#0
    csel	w0,	w28,	w14,	ne
    cmp	w0,	#0
    cset	w1,	eq
    cmp	w1,	#0
    cset	w3,	ne
    cmp	w5,	#0
    movz	w15,	#0
    csel	w15,	w3,	w15,	ne
    str	w15,	[sp, #596]

    ldr	w6,	[sp, #880]

    cmp	w6,	#0
    cset	w7,	ne
    ldr	w3,	[sp, #580]

    cmp	w3,	#0
    movz	w14,	#0
    csel	w16,	w7,	w14,	ne
    cmp	w24,	#0
    cset	w11,	ne
    cmp	w12,	#0
    movz	w13,	#0
    csel	w9,	w11,	w13,	ne
    cmp	w9,	#0
    cset	w15,	ne
    cmp	w16,	#0
    ldr	w24,	[sp, #552]

    movz	w10,	#1
    csel	w14,	w10,	w15,	ne
    cmp	w24,	#0
    ldr	w6,	[sp, #856]

    cset	w19,	ne
    cmp	w6,	#0
    ldr	w25,	[sp, #552]

    movz	w9,	#1
    csel	w24,	w9,	w19,	ne
    cmp	w25,	#0
    ldr	w7,	[sp, #856]

    cset	w25,	ne
    cmp	w7,	#0
    movz	w8,	#0
    csel	w25,	w25,	w8,	ne
    cmp	w25,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w1,	ne
    cmp	w24,	#0
    movz	w9,	#0
    csel	w23,	w1,	w9,	ne
    cmp	w14,	#0
    cset	w5,	ne
    cmp	w23,	#0
    movz	w8,	#1
    csel	w11,	w8,	w5,	ne
    cmp	w14,	#0
    cset	w9,	ne
    mov	w10,	w9
    cmp	w23,	#0
    movz	w5,	#0
    csel	w9,	w10,	w5,	ne
    cmp	w9,	#0
    cset	w13,	eq
    cmp	w13,	#0
    cset	w15,	ne
    cmp	w11,	#0
    movz	w4,	#0
    csel	w12,	w15,	w4,	ne
    str	w12,	[sp, #592]

    ldr	w26,	[sp, #552]

    cmp	w26,	#0
    cset	w19,	ne
    ldr	w8,	[sp, #856]

    cmp	w8,	#0
    movz	w3,	#0
    csel	w3,	w19,	w3,	ne
    cmp	w14,	#0
    cset	w25,	ne
    cmp	w23,	#0
    movz	w2,	#0
    csel	w26,	w25,	w2,	ne
    cmp	w26,	#0
    cset	w0,	ne
    cmp	w3,	#0
    ldr	w9,	[sp, #848]

    movz	w2,	#1
    csel	w6,	w2,	w0,	ne
    cmp	w9,	#0
    cset	w3,	ne
    ldr	w12,	[sp, #860]

    cmp	w12,	#0
    movz	w0,	#1
    ldr	w10,	[sp, #848]

    csel	w14,	w0,	w3,	ne
    cmp	w10,	#0
    cset	w7,	ne
    ldr	w13,	[sp, #860]

    cmp	w13,	#0
    movz	w1,	#0
    csel	w1,	w7,	w1,	ne
    cmp	w1,	#0
    cset	w11,	eq
    cmp	w11,	#0
    cset	w13,	ne
    cmp	w14,	#0
    movz	w0,	#0
    csel	w16,	w13,	w0,	ne
    cmp	w6,	#0
    cset	w17,	ne
    cmp	w16,	#0
    movz	w28,	#1
    csel	w4,	w28,	w17,	ne
    cmp	w6,	#0
    cset	w23,	ne
    cmp	w16,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w24,	w23,	w26,	ne
    cmp	w24,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w0,	ne
    cmp	w4,	#0
    movz	w25,	#0
    csel	w9,	w0,	w25,	ne
    str	w9,	[sp, #588]

    ldr	w12,	[sp, #848]

    cmp	w12,	#0
    ldr	w14,	[sp, #860]

    cset	w3,	ne
    cmp	w14,	#0
    movz	w25,	#0
    csel	w20,	w3,	w25,	ne
    cmp	w6,	#0
    cset	w7,	ne
    cmp	w16,	#0
    movz	w24,	#0
    csel	w8,	w7,	w24,	ne
    cmp	w8,	#0
    cset	w11,	ne
    cmp	w20,	#0
    movz	w22,	#1
    ldr	w28,	[sp, #656]

    csel	w13,	w22,	w11,	ne
    cmp	w28,	#0
    ldr	w17,	[sp, #912]

    cset	w15,	ne
    cmp	w17,	#0
    movz	w20,	#1
    ldr	w0,	[sp, #656]

    csel	w18,	w20,	w15,	ne
    cmp	w0,	#0
    cset	w19,	ne
    ldr	w17,	[sp, #912]

    cmp	w17,	#0
    movz	w17,	#0
    csel	w19,	w19,	w17,	ne
    cmp	w19,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w27,	ne
    cmp	w18,	#0
    movz	w16,	#0
    csel	w23,	w27,	w16,	ne
    cmp	w13,	#0
    cset	w1,	ne
    cmp	w23,	#0
    movz	w17,	#1
    csel	w3,	w17,	w1,	ne
    cmp	w13,	#0
    cset	w5,	ne
    cmp	w23,	#0
    movz	w16,	#0
    csel	w27,	w5,	w16,	ne
    cmp	w27,	#0
    cset	w9,	eq
    cmp	w9,	#0
    cset	w11,	ne
    cmp	w3,	#0
    movz	w15,	#0
    csel	w6,	w11,	w15,	ne
    str	w6,	[sp, #584]

    ldr	w1,	[sp, #656]

    cmp	w1,	#0
    cset	w15,	ne
    ldr	w19,	[sp, #912]

    cmp	w19,	#0
    movz	w12,	#0
    csel	w2,	w15,	w12,	ne
    cmp	w13,	#0
    cset	w19,	ne
    cmp	w23,	#0
    movz	w11,	#0
    csel	w24,	w19,	w11,	ne
    cmp	w24,	#0
    cset	w25,	ne
    cmp	w2,	#0
    movz	w10,	#1
    ldr	w13,	[sp, #644]

    csel	w24,	w10,	w25,	ne
    cmp	w13,	#0
    cset	w0,	ne
    ldr	w17,	[sp, #864]

    cmp	w17,	#0
    movz	w10,	#1
    ldr	w16,	[sp, #644]

    csel	w0,	w10,	w0,	ne
    cmp	w16,	#0
    cset	w3,	ne
    ldr	w18,	[sp, #864]

    cmp	w18,	#0
    movz	w10,	#0
    csel	w4,	w3,	w10,	ne
    cmp	w4,	#0
    cset	w7,	eq
    cmp	w7,	#0
    cset	w9,	ne
    cmp	w0,	#0
    movz	w7,	#0
    csel	w12,	w9,	w7,	ne
    cmp	w24,	#0
    cset	w13,	ne
    cmp	w12,	#0
    movz	w6,	#1
    csel	w26,	w6,	w13,	ne
    cmp	w24,	#0
    cset	w17,	ne
    cmp	w12,	#0
    movz	w5,	#0
    csel	w14,	w17,	w5,	ne
    cmp	w14,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w25,	ne
    cmp	w26,	#0
    movz	w4,	#0
    ldr	w23,	[sp, #644]

    csel	w4,	w25,	w4,	ne
    cmp	w23,	#0
    cset	w1,	ne
    ldr	w23,	[sp, #864]

    cmp	w23,	#0
    movz	w5,	#0
    csel	w7,	w1,	w5,	ne
    cmp	w24,	#0
    cset	w3,	ne
    cmp	w12,	#0
    movz	w2,	#0
    csel	w8,	w3,	w2,	ne
    cmp	w8,	#0
    cset	w8,	ne
    cmp	w7,	#0
    ldr	w11,	[sp, #640]

    movz	w1,	#1
    csel	w3,	w1,	w8,	ne
    cmp	w11,	#0
    ldr	w25,	[sp, #892]

    cset	w12,	ne
    cmp	w25,	#0
    ldr	w17,	[sp, #640]

    movz	w0,	#1
    csel	w6,	w0,	w12,	ne
    cmp	w17,	#0
    ldr	w26,	[sp, #892]

    cset	w16,	ne
    cmp	w26,	#0
    movz	w2,	#0
    csel	w18,	w16,	w2,	ne
    cmp	w18,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w24,	ne
    cmp	w6,	#0
    movz	w1,	#0
    csel	w15,	w24,	w1,	ne
    cmp	w3,	#0
    cset	w28,	ne
    cmp	w15,	#0
    movz	w27,	#1
    csel	w0,	w27,	w28,	ne
    cmp	w3,	#0
    cset	w1,	ne
    cmp	w15,	#0
    movz	w27,	#0
    csel	w2,	w1,	w27,	ne
    cmp	w2,	#0
    cset	w6,	eq
    cmp	w6,	#0
    cset	w8,	ne
    cmp	w0,	#0
    ldr	w0,	[sp, #640]

    movz	w27,	#0
    csel	w2,	w8,	w27,	ne
    cmp	w0,	#0
    cset	w13,	ne
    ldr	w7,	[sp, #892]

    cmp	w7,	#0
    movz	w26,	#0
    csel	w18,	w13,	w26,	ne
    cmp	w3,	#0
    cset	w17,	ne
    cmp	w15,	#0
    movz	w26,	#0
    csel	w22,	w17,	w26,	ne
    cmp	w22,	#0
    cset	w22,	ne
    cmp	w18,	#0
    movz	w24,	#1
    ldr	w27,	[sp, #624]

    csel	w6,	w24,	w22,	ne
    cmp	w27,	#0
    ldr	w22,	[sp, #884]

    cset	w27,	ne
    cmp	w22,	#0
    ldr	w14,	[sp, #624]

    movz	w20,	#1
    csel	w1,	w20,	w27,	ne
    cmp	w14,	#0
    cset	w5,	ne
    ldr	w24,	[sp, #884]

    cmp	w24,	#0
    movz	w19,	#0
    csel	w12,	w5,	w19,	ne
    cmp	w12,	#0
    cset	w5,	eq
    cmp	w5,	#0
    cset	w7,	ne
    cmp	w1,	#0
    movz	w20,	#0
    csel	w7,	w7,	w20,	ne
    cmp	w6,	#0
    cset	w11,	ne
    cmp	w7,	#0
    movz	w18,	#1
    csel	w14,	w18,	w11,	ne
    cmp	w6,	#0
    cset	w15,	ne
    cmp	w7,	#0
    movz	w17,	#0
    csel	w26,	w15,	w17,	ne
    cmp	w26,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w22,	ne
    cmp	w14,	#0
    ldr	w0,	[sp, #624]

    movz	w15,	#0
    csel	w20,	w22,	w15,	ne
    cmp	w0,	#0
    cset	w28,	ne
    ldr	w24,	[sp, #884]

    cmp	w24,	#0
    movz	w14,	#0
    csel	w1,	w28,	w14,	ne
    cmp	w6,	#0
    cset	w5,	ne
    cmp	w7,	#0
    movz	w13,	#0
    csel	w15,	w5,	w13,	ne
    cmp	w15,	#0
    cset	w5,	ne
    cmp	w1,	#0
    movz	w14,	#1
    ldr	w1,	[sp, #896]

    csel	w27,	w14,	w5,	ne
    cmp	w1,	#0
    ldr	w28,	[sp, #888]

    cset	w9,	ne
    cmp	w28,	#0
    ldr	w3,	[sp, #896]

    movz	w12,	#1
    csel	w28,	w12,	w9,	ne
    cmp	w3,	#0
    ldr	w0,	[sp, #888]

    cset	w14,	ne
    cmp	w0,	#0
    movz	w10,	#0
    csel	w1,	w14,	w10,	ne
    cmp	w1,	#0
    cset	w17,	eq
    cmp	w17,	#0
    cset	w19,	ne
    cmp	w28,	#0
    movz	w9,	#0
    csel	w7,	w19,	w9,	ne
    cmp	w27,	#0
    cset	w26,	ne
    cmp	w7,	#0
    movz	w8,	#1
    csel	w13,	w8,	w26,	ne
    cmp	w27,	#0
    cset	w1,	ne
    cmp	w7,	#0
    movz	w7,	#0
    csel	w17,	w1,	w7,	ne
    cmp	w17,	#0
    cset	w1,	eq
    cmp	w1,	#0
    cset	w5,	ne
    cmp	w13,	#0
    ldr	w7,	[sp, #584]

    movz	w8,	#0
    ldr	w10,	[sp, #588]

    csel	w16,	w5,	w8,	ne
    lsl	w17,	w16,	#1
    add	w19,	w17,	w20
    lsl	w20,	w19,	#1
    add	w17,	w20,	w2
    lsl	w18,	w17,	#1
    add	w11,	w18,	w4
    lsl	w13,	w11,	#1
    add	w13,	w13,	w7
    lsl	w15,	w13,	#1
    ldr	w13,	[sp, #592]

    add	w15,	w15,	w10
    ldr	w16,	[sp, #596]

    lsl	w17,	w15,	#1
    add	w17,	w17,	w13
    lsl	w19,	w17,	#1
    add	w19,	w19,	w16
    lsl	w22,	w19,	#1
    ldr	w19,	[sp, #600]

    add	w23,	w22,	w19
    lsl	w25,	w23,	#1
    ldr	w23,	[sp, #604]

    ldr	w26,	[sp, #608]

    add	w25,	w25,	w23
    ldr	w0,	[sp, #612]

    ldr	w22,	[sp, #868]

    lsl	w27,	w25,	#1
    add	w27,	w27,	w26
    lsl	w1,	w27,	#1
    add	w0,	w1,	w0
    lsl	w0,	w0,	#1
    add	w1,	w0,	w22
    lsl	w3,	w1,	#1
    ldr	w1,	[sp, #876]

    add	w3,	w3,	w1
    lsl	w5,	w3,	#1
    ldr	w3,	[sp, #852]

    add	w5,	w5,	w3
    lsl	w6,	w5,	#1
    add	w0,	w6,	w21
    b	fib_1892

fib_1891:
    movz	w0,	#1

fib_1892:
    movz	w17,	#1
    ldr	x16,	[sp, #496]

    str	w17,	[x16]

    ldr	x12,	[sp, #488]

    ldr	w17,	[sp, #512]

    str	w17,	[x12]

    ldr	x12,	[sp, #504]

    add	x11,	x12,	#4
    str	w0,	[x11]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #1216
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


