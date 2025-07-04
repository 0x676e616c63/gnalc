.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global memo.lut.fib
.align	2
memo.lut.fib:
.type memo.lut.fib, %object
    .zero	524288

.data

.text

.globl fib
.align 2
.p2align 4,,11
.type fib, %function
fib:
fib_1:
    sub	sp, sp, #1216
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	x5,	#40763
    movz	x27,	#65535
    mov	w24,	w0
    movz	x6,	#40763
    adrp	x12, :got:memo.lut.fib
    movk	x5,	#1117,	lsl #16
    lsr	w9,	w24,	#16
    movk	x6,	#1117,	lsl #16
    eor	w1,	w24,	w9
    mul	w2,	w1,	w6
    lsr	w13,	w2,	#16
    eor	w4,	w2,	w13
    mul	w14,	w4,	w5
    lsr	w6,	w14,	#16
    eor	w13,	w14,	w6
    str	w13,	[sp, #308]

    ldr	w13,	[sp, #308]

    ldr	x12, [x12, #:got_lo12:memo.lut.fib]
    and	w17,	w13,	w27
    lsl	w18,	w17,	#3
    lsl	w21,	w18,	#0
    add	x7,	x12,	x21
    str	x7,	[sp, #472]

    ldr	x3,	[sp, #472]

    str	x3,	[sp, #464]

    ldr	x4,	[sp, #464]

    ldr	w10,	[x4]

    ldr	x9,	[sp, #472]

    add	x0,	x9,	#8
    cmp	w10,	#0
    bne	fib_17

fib_25:
    str	x0,	[sp, #456]

    b	fib_28

fib_17:
    ldr	w14,	[x0]

    ldr	w17,	[sp, #308]

    cmp	w14,	w17
    beq	fib_21

fib_27:
    str	x0,	[sp, #456]


fib_28:
    cmp	w24,	#2
    bgt	fib_31

fib_1891:
    movz	w0,	#1
    b	fib_1892

fib_31:
    asr	w23,	w24,	#31
    movz	w21,	#0
    lsr	w0,	w23,	#31
    add	w25,	w24,	w0
    asr	w22,	w25,	#1
    lsl	w23,	w22,	#1
    sub	w28,	w24,	w23
    str	w28,	[sp, #432]

    ldr	w0,	[sp, #432]

    sub	w18,	w21,	w0
    str	w18,	[sp, #356]

    ldr	w18,	[sp, #432]

    cmp	w18,	#0
    asr	w26,	w24,	#31
    ldr	w21,	[sp, #356]

    ldr	w20,	[sp, #432]

    lsr	w27,	w26,	#31
    csel	w22,	w21,	w20,	lt
    movz	w26,	#0
    str	w22,	[sp, #932]

    add	w28,	w24,	w27
    asr	w27,	w28,	#1
    asr	w18,	w27,	#31
    lsr	w19,	w18,	#31
    add	w20,	w27,	w19
    asr	w18,	w20,	#1
    lsl	w19,	w18,	#1
    sub	w20,	w27,	w19
    str	w20,	[sp, #440]

    ldr	w23,	[sp, #440]

    sub	w28,	w26,	w23
    str	w28,	[sp, #372]

    ldr	w22,	[sp, #440]

    cmp	w22,	#0
    ldr	w20,	[sp, #372]

    asr	w22,	w27,	#31
    ldr	w23,	[sp, #440]

    csel	w19,	w20,	w23,	lt
    str	w19,	[sp, #1124]

    lsr	w23,	w22,	#31
    add	w0,	w27,	w23
    asr	w19,	w0,	#1
    movz	w0,	#0
    asr	w25,	w19,	#31
    lsr	w26,	w25,	#31
    add	w27,	w19,	w26
    asr	w25,	w27,	#1
    lsl	w26,	w25,	#1
    sub	w27,	w19,	w26
    str	w27,	[sp, #444]

    ldr	w20,	[sp, #444]

    sub	w27,	w0,	w20
    str	w27,	[sp, #388]

    ldr	w0,	[sp, #444]

    cmp	w0,	#0
    asr	w28,	w19,	#31
    ldr	w25,	[sp, #388]

    ldr	w18,	[sp, #444]

    lsr	w0,	w28,	#31
    csel	w18,	w25,	w18,	lt
    str	w18,	[sp, #936]

    add	w18,	w19,	w0
    asr	w25,	w18,	#1
    asr	w19,	w25,	#31
    lsr	w20,	w19,	#31
    add	w21,	w25,	w20
    movz	w20,	#0
    asr	w21,	w21,	#1
    lsl	w22,	w21,	#1
    sub	w21,	w25,	w22
    str	w21,	[sp, #452]

    ldr	w0,	[sp, #452]

    sub	w22,	w20,	w0
    str	w22,	[sp, #400]

    ldr	w23,	[sp, #452]

    cmp	w23,	#0
    ldr	w19,	[sp, #400]

    ldr	w26,	[sp, #452]

    csel	w24,	w19,	w26,	lt
    str	w24,	[sp, #1140]

    asr	w26,	w25,	#31
    lsr	w27,	w26,	#31
    movz	w26,	#0
    add	w18,	w25,	w27
    asr	w21,	w18,	#1
    asr	w27,	w21,	#31
    lsr	w28,	w27,	#31
    add	w18,	w21,	w28
    asr	w19,	w18,	#1
    lsl	w20,	w19,	#1
    sub	w19,	w21,	w20
    str	w19,	[sp, #448]

    ldr	w22,	[sp, #448]

    sub	w18,	w26,	w22
    str	w18,	[sp, #412]

    ldr	w19,	[sp, #448]

    cmp	w19,	#0
    asr	w18,	w21,	#31
    ldr	w22,	[sp, #412]

    ldr	w20,	[sp, #448]

    lsr	w19,	w18,	#31
    csel	w26,	w22,	w20,	lt
    str	w26,	[sp, #944]

    add	w20,	w21,	w19
    asr	w19,	w20,	#1
    asr	w21,	w19,	#31
    lsr	w23,	w21,	#31
    add	w25,	w19,	w23
    asr	w21,	w25,	#1
    lsl	w23,	w21,	#1
    sub	w18,	w19,	w23
    str	w18,	[sp, #436]

    ldr	w22,	[sp, #436]

    movz	w18,	#0
    sub	w23,	w18,	w22
    str	w23,	[sp, #424]

    ldr	w20,	[sp, #436]

    cmp	w20,	#0
    ldr	w23,	[sp, #424]

    asr	w25,	w19,	#31
    ldr	w22,	[sp, #436]

    lsr	w26,	w25,	#31
    csel	w22,	w23,	w22,	lt
    str	w22,	[sp, #940]

    add	w18,	w19,	w26
    asr	w25,	w18,	#1
    asr	w27,	w25,	#31
    lsr	w18,	w27,	#31
    add	w20,	w25,	w18
    asr	w27,	w20,	#1
    lsl	w18,	w27,	#1
    sub	w28,	w25,	w18
    movz	w18,	#0
    str	w28,	[sp, #428]

    ldr	w20,	[sp, #428]

    sub	w21,	w18,	w20
    str	w21,	[sp, #416]

    ldr	w19,	[sp, #428]

    cmp	w19,	#0
    asr	w23,	w25,	#31
    ldr	w22,	[sp, #416]

    ldr	w18,	[sp, #428]

    lsr	w26,	w23,	#31
    csel	w18,	w22,	w18,	lt
    str	w18,	[sp, #948]

    add	w18,	w25,	w26
    asr	w19,	w18,	#1
    str	w19,	[sp, #1100]

    ldr	w20,	[sp, #1100]

    asr	w27,	w20,	#31
    ldr	w21,	[sp, #1100]

    ldr	w22,	[sp, #1100]

    lsr	w20,	w27,	#31
    add	w20,	w21,	w20
    movz	w21,	#0
    asr	w26,	w20,	#1
    lsl	w18,	w26,	#1
    sub	w28,	w22,	w18
    str	w28,	[sp, #420]

    ldr	w18,	[sp, #420]

    sub	w22,	w21,	w18
    str	w22,	[sp, #404]

    ldr	w19,	[sp, #420]

    cmp	w19,	#0
    ldr	w23,	[sp, #404]

    ldr	w18,	[sp, #420]

    csel	w0,	w23,	w18,	lt
    str	w0,	[sp, #956]

    ldr	w23,	[sp, #1100]

    ldr	w24,	[sp, #1100]

    asr	w21,	w23,	#31
    lsr	w23,	w21,	#31
    add	w18,	w24,	w23
    asr	w22,	w18,	#1
    str	w22,	[sp, #952]

    ldr	w23,	[sp, #952]

    asr	w27,	w23,	#31
    ldr	w24,	[sp, #952]

    ldr	w25,	[sp, #952]

    lsr	w18,	w27,	#31
    add	w20,	w24,	w18
    movz	w18,	#0
    asr	w27,	w20,	#1
    lsl	w20,	w27,	#1
    sub	w27,	w25,	w20
    str	w27,	[sp, #408]

    ldr	w25,	[sp, #408]

    sub	w19,	w18,	w25
    str	w19,	[sp, #392]

    ldr	w27,	[sp, #408]

    cmp	w27,	#0
    ldr	w20,	[sp, #392]

    movz	w23,	#0
    ldr	w27,	[sp, #408]

    csel	w27,	w20,	w27,	lt
    str	w27,	[sp, #868]

    ldr	w26,	[sp, #952]

    ldr	w27,	[sp, #952]

    asr	w21,	w26,	#31
    lsr	w26,	w21,	#31
    add	w18,	w27,	w26
    asr	w19,	w18,	#1
    asr	w27,	w19,	#31
    lsr	w18,	w27,	#31
    add	w20,	w19,	w18
    asr	w20,	w20,	#1
    lsl	w21,	w20,	#1
    sub	w18,	w19,	w21
    str	w18,	[sp, #396]

    ldr	w28,	[sp, #396]

    sub	w22,	w23,	w28
    str	w22,	[sp, #380]

    ldr	w21,	[sp, #396]

    cmp	w21,	#0
    ldr	w23,	[sp, #380]

    ldr	w21,	[sp, #396]

    csel	w23,	w23,	w21,	lt
    str	w23,	[sp, #764]

    asr	w23,	w19,	#31
    lsr	w25,	w23,	#31
    add	w18,	w19,	w25
    asr	w20,	w18,	#1
    asr	w18,	w20,	#31
    lsr	w18,	w18,	#31
    add	w21,	w20,	w18
    asr	w18,	w21,	#1
    lsl	w18,	w18,	#1
    sub	w26,	w20,	w18
    movz	w18,	#0
    mov	w21,	w18
    str	w26,	[sp, #384]

    ldr	w18,	[sp, #384]

    sub	w19,	w21,	w18
    str	w19,	[sp, #368]

    ldr	w18,	[sp, #384]

    cmp	w18,	#0
    ldr	w18,	[sp, #368]

    asr	w23,	w20,	#31
    ldr	w25,	[sp, #384]

    csel	w26,	w18,	w25,	lt
    lsr	w25,	w23,	#31
    str	w26,	[sp, #280]

    add	w18,	w20,	w25
    asr	w23,	w18,	#1
    asr	w18,	w23,	#31
    lsr	w22,	w18,	#31
    add	w25,	w23,	w22
    asr	w18,	w25,	#1
    lsl	w22,	w18,	#1
    sub	w27,	w23,	w22
    str	w27,	[sp, #376]

    ldr	w25,	[sp, #376]

    movz	w27,	#0
    mov	w18,	w27
    sub	w19,	w18,	w25
    str	w19,	[sp, #360]

    ldr	w18,	[sp, #376]

    cmp	w18,	#0
    asr	w27,	w23,	#31
    ldr	w18,	[sp, #360]

    ldr	w22,	[sp, #376]

    csel	w26,	w18,	w22,	lt
    lsr	w18,	w27,	#31
    str	w26,	[sp, #500]

    add	w18,	w23,	w18
    asr	w19,	w18,	#1
    movz	w18,	#0
    asr	w23,	w19,	#31
    lsr	w25,	w23,	#31
    add	w27,	w19,	w25
    asr	w23,	w27,	#1
    lsl	w25,	w23,	#1
    sub	w22,	w19,	w25
    str	w22,	[sp, #364]

    ldr	w28,	[sp, #364]

    sub	w26,	w18,	w28
    str	w26,	[sp, #348]

    ldr	w25,	[sp, #364]

    cmp	w25,	#0
    ldr	w27,	[sp, #348]

    ldr	w18,	[sp, #364]

    csel	w20,	w27,	w18,	lt
    str	w20,	[sp, #516]

    asr	w18,	w19,	#31
    movz	w20,	#0
    lsr	w21,	w18,	#31
    add	w18,	w19,	w21
    mov	w21,	w20
    asr	w25,	w18,	#1
    asr	w23,	w25,	#31
    lsr	w27,	w23,	#31
    add	w18,	w25,	w27
    asr	w23,	w18,	#1
    lsl	w27,	w23,	#1
    sub	w19,	w25,	w27
    str	w19,	[sp, #352]

    ldr	w23,	[sp, #352]

    sub	w26,	w21,	w23
    str	w26,	[sp, #156]

    ldr	w18,	[sp, #352]

    cmp	w18,	#0
    movz	w21,	#0
    ldr	w27,	[sp, #156]

    asr	w18,	w25,	#31
    ldr	w20,	[sp, #352]

    csel	w23,	w27,	w20,	lt
    lsr	w22,	w18,	#31
    str	w23,	[sp, #112]

    add	w18,	w25,	w22
    asr	w20,	w18,	#1
    asr	w25,	w20,	#31
    lsr	w18,	w25,	#31
    add	w18,	w20,	w18
    asr	w25,	w18,	#1
    lsl	w18,	w25,	#1
    sub	w19,	w20,	w18
    mov	w18,	w21
    str	w19,	[sp, #160]

    ldr	w23,	[sp, #160]

    sub	w25,	w18,	w23
    str	w25,	[sp, #148]

    ldr	w18,	[sp, #160]

    cmp	w18,	#0
    asr	w21,	w20,	#31
    ldr	w26,	[sp, #148]

    ldr	w18,	[sp, #160]

    lsr	w23,	w21,	#31
    csel	w19,	w26,	w18,	lt
    str	w19,	[sp, #132]

    add	w18,	w20,	w23
    movz	w23,	#0
    asr	w19,	w18,	#1
    asr	w27,	w19,	#31
    lsr	w18,	w27,	#31
    add	w20,	w19,	w18
    mov	w18,	w23
    asr	w20,	w20,	#1
    lsl	w21,	w20,	#1
    sub	w28,	w19,	w21
    str	w28,	[sp, #152]

    ldr	w19,	[sp, #152]

    sub	w21,	w18,	w19
    str	w21,	[sp, #144]

    ldr	w19,	[sp, #152]

    cmp	w19,	#0
    ldr	w22,	[sp, #144]

    ldr	w19,	[sp, #152]

    csel	w27,	w22,	w19,	lt
    str	w27,	[sp, #128]

    ldr	w27,	[sp, #932]

    cmp	w27,	#0
    cset	w23,	ne
    mov	w18,	w23
    cmp	w18,	#0
    cset	w27,	eq
    mov	w18,	w27
    cmp	w18,	#0
    cset	w20,	ne
    mov	w21,	w20
    cmp	w21,	#0
    cset	w23,	ne
    mov	w18,	w23
    cmp	w18,	#0
    cset	w27,	ne
    mov	w23,	w27
    str	w23,	[sp, #136]

    ldr	w28,	[sp, #932]

    cmp	w28,	#0
    cset	w20,	ne
    mov	w21,	w20
    cmp	w21,	#0
    cset	w23,	ne
    mov	w22,	w23
    str	w22,	[sp, #1152]

    ldr	w20,	[sp, #1124]

    cmp	w20,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w18,	#0
    cset	w20,	eq
    mov	w21,	w20
    cmp	w21,	#0
    cset	w23,	ne
    mov	w28,	w23
    str	w28,	[sp, #96]

    ldr	w23,	[sp, #1152]

    cmp	w23,	#0
    cset	w27,	ne
    ldr	w28,	[sp, #96]

    mov	w18,	w27
    cmp	w28,	#0
    movz	w27,	#1
    ldr	w24,	[sp, #1152]

    mov	w25,	w27
    csel	w26,	w25,	w18,	ne
    cmp	w24,	#0
    cset	w23,	ne
    mov	w27,	w23
    str	w27,	[sp, #344]

    ldr	w18,	[sp, #96]

    cmp	w18,	#0
    movz	w18,	#0
    ldr	w28,	[sp, #344]

    mov	w20,	w18
    csel	w22,	w28,	w20,	ne
    cmp	w22,	#0
    cset	w20,	eq
    mov	w21,	w20
    cmp	w21,	#0
    cset	w23,	ne
    mov	w18,	w23
    cmp	w26,	#0
    movz	w21,	#0
    csel	w22,	w18,	w21,	ne
    str	w22,	[sp, #120]

    ldr	w21,	[sp, #1124]

    cmp	w21,	#0
    cset	w18,	ne
    ldr	w26,	[sp, #1152]

    mov	w20,	w18
    cmp	w26,	#0
    cset	w21,	ne
    ldr	w19,	[sp, #96]

    mov	w22,	w21
    cmp	w19,	#0
    movz	w18,	#0
    mov	w19,	w18
    csel	w24,	w22,	w19,	ne
    cmp	w24,	#0
    cset	w18,	ne
    mov	w22,	w18
    cmp	w20,	#0
    movz	w20,	#1
    mov	w21,	w20
    csel	w21,	w21,	w22,	ne
    str	w21,	[sp, #832]

    ldr	w19,	[sp, #936]

    cmp	w19,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w27,	#0
    cset	w18,	eq
    mov	w19,	w18
    cmp	w19,	#0
    cset	w21,	ne
    str	w21,	[sp, #660]

    ldr	w22,	[sp, #832]

    cmp	w22,	#0
    ldr	w26,	[sp, #660]

    cset	w25,	ne
    mov	w27,	w25
    cmp	w26,	#0
    movz	w23,	#1
    mov	w21,	w23
    csel	w20,	w21,	w27,	ne
    str	w20,	[sp, #276]

    ldr	w23,	[sp, #832]

    cmp	w23,	#0
    cset	w21,	ne
    ldr	w28,	[sp, #660]

    mov	w18,	w21
    cmp	w28,	#0
    movz	w27,	#0
    mov	w21,	w27
    csel	w27,	w18,	w21,	ne
    cmp	w27,	#0
    cset	w18,	eq
    mov	w19,	w18
    cmp	w19,	#0
    ldr	w22,	[sp, #276]

    cset	w21,	ne
    mov	w18,	w21
    cmp	w22,	#0
    movz	w19,	#0
    csel	w24,	w18,	w19,	ne
    str	w24,	[sp, #528]

    ldr	w20,	[sp, #936]

    cmp	w20,	#0
    ldr	w24,	[sp, #832]

    cset	w18,	ne
    mov	w19,	w18
    cmp	w24,	#0
    ldr	w26,	[sp, #660]

    cset	w27,	ne
    mov	w18,	w27
    cmp	w26,	#0
    movz	w20,	#0
    mov	w27,	w20
    csel	w24,	w18,	w27,	ne
    cmp	w24,	#0
    cset	w18,	ne
    mov	w27,	w18
    cmp	w19,	#0
    movz	w21,	#1
    mov	w23,	w21
    csel	w26,	w23,	w27,	ne
    str	w26,	[sp, #1132]

    ldr	w25,	[sp, #1140]

    cmp	w25,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w27,	#0
    cset	w18,	eq
    mov	w19,	w18
    cmp	w19,	#0
    cset	w21,	ne
    mov	w19,	w21
    str	w19,	[sp, #1136]

    ldr	w27,	[sp, #1132]

    cmp	w27,	#0
    cset	w25,	ne
    ldr	w19,	[sp, #1136]

    cmp	w19,	#0
    movz	w21,	#1
    csel	w23,	w21,	w25,	ne
    str	w23,	[sp, #1128]

    ldr	w28,	[sp, #1132]

    cmp	w28,	#0
    cset	w21,	ne
    mov	w18,	w21
    ldr	w21,	[sp, #1136]

    cmp	w21,	#0
    movz	w27,	#0
    mov	w21,	w27
    csel	w27,	w18,	w21,	ne
    cmp	w27,	#0
    cset	w18,	eq
    mov	w19,	w18
    cmp	w19,	#0
    ldr	w23,	[sp, #1128]

    cset	w21,	ne
    cmp	w23,	#0
    movz	w18,	#0
    mov	w25,	w18
    csel	w23,	w21,	w25,	ne
    str	w23,	[sp, #492]

    ldr	w26,	[sp, #1140]

    cmp	w26,	#0
    cset	w27,	ne
    ldr	w28,	[sp, #1132]

    mov	w0,	w27
    cmp	w28,	#0
    ldr	w19,	[sp, #1136]

    cset	w18,	ne
    mov	w26,	w18
    cmp	w19,	#0
    movz	w28,	#0
    csel	w21,	w26,	w28,	ne
    cmp	w21,	#0
    cset	w23,	ne
    mov	w24,	w23
    cmp	w0,	#0
    movz	w0,	#1
    mov	w27,	w0
    csel	w24,	w27,	w24,	ne
    str	w24,	[sp, #980]

    ldr	w27,	[sp, #944]

    cmp	w27,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    str	w18,	[sp, #688]

    ldr	w25,	[sp, #980]

    cmp	w25,	#0
    cset	w23,	ne
    mov	w25,	w23
    ldr	w23,	[sp, #688]

    cmp	w23,	#0
    movz	w20,	#1
    mov	w18,	w20
    csel	w27,	w18,	w25,	ne
    str	w27,	[sp, #840]

    ldr	w26,	[sp, #980]

    cmp	w26,	#0
    ldr	w25,	[sp, #688]

    cset	w18,	ne
    mov	w0,	w18
    cmp	w25,	#0
    movz	w25,	#0
    mov	w18,	w25
    csel	w25,	w0,	w18,	ne
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    ldr	w28,	[sp, #840]

    mov	w0,	w18
    cmp	w28,	#0
    movz	w27,	#0
    csel	w21,	w0,	w27,	ne
    str	w21,	[sp, #480]

    ldr	w28,	[sp, #944]

    cmp	w28,	#0
    cset	w27,	ne
    ldr	w23,	[sp, #980]

    mov	w20,	w27
    cmp	w23,	#0
    ldr	w25,	[sp, #688]

    cset	w28,	ne
    mov	w18,	w28
    cmp	w25,	#0
    movz	w25,	#0
    mov	w23,	w25
    csel	w21,	w18,	w23,	ne
    cmp	w21,	#0
    cset	w25,	ne
    mov	w19,	w25
    cmp	w20,	#0
    movz	w0,	#1
    mov	w18,	w0
    csel	w18,	w18,	w19,	ne
    str	w18,	[sp, #844]

    ldr	w23,	[sp, #940]

    cmp	w23,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    mov	w25,	w18
    str	w25,	[sp, #1092]

    ldr	w19,	[sp, #844]

    cmp	w19,	#0
    ldr	w21,	[sp, #1092]

    cset	w23,	ne
    mov	w25,	w23
    cmp	w21,	#0
    movz	w20,	#1
    mov	w18,	w20
    ldr	w20,	[sp, #844]

    csel	w19,	w18,	w25,	ne
    cmp	w20,	#0
    ldr	w23,	[sp, #1092]

    cset	w18,	ne
    mov	w0,	w18
    cmp	w23,	#0
    movz	w25,	#0
    mov	w18,	w25
    csel	w0,	w0,	w18,	ne
    cmp	w0,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    mov	w0,	w18
    cmp	w19,	#0
    movz	w27,	#0
    mov	w25,	w27
    csel	w0,	w0,	w25,	ne
    str	w0,	[sp, #260]

    ldr	w24,	[sp, #940]

    cmp	w24,	#0
    cset	w27,	ne
    ldr	w21,	[sp, #844]

    mov	w28,	w27
    cmp	w21,	#0
    cset	w24,	ne
    mov	w26,	w24
    ldr	w24,	[sp, #1092]

    cmp	w24,	#0
    movz	w22,	#0
    mov	w0,	w22
    csel	w20,	w26,	w0,	ne
    cmp	w20,	#0
    cset	w0,	ne
    mov	w24,	w0
    cmp	w28,	#0
    movz	w18,	#1
    mov	w20,	w18
    csel	w0,	w20,	w24,	ne
    str	w0,	[sp, #984]

    ldr	w19,	[sp, #948]

    cmp	w19,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    mov	w23,	w18
    str	w23,	[sp, #692]

    ldr	w18,	[sp, #984]

    cmp	w18,	#0
    ldr	w0,	[sp, #692]

    cset	w23,	ne
    mov	w25,	w23
    cmp	w0,	#0
    movz	w20,	#1
    mov	w18,	w20
    csel	w23,	w18,	w25,	ne
    str	w23,	[sp, #848]

    ldr	w19,	[sp, #984]

    cmp	w19,	#0
    ldr	w19,	[sp, #692]

    cset	w18,	ne
    mov	w0,	w18
    cmp	w19,	#0
    movz	w25,	#0
    mov	w18,	w25
    csel	w25,	w0,	w18,	ne
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    ldr	w25,	[sp, #848]

    cset	w18,	ne
    mov	w0,	w18
    cmp	w25,	#0
    movz	w27,	#0
    csel	w27,	w0,	w27,	ne
    str	w27,	[sp, #968]

    ldr	w20,	[sp, #948]

    cmp	w20,	#0
    ldr	w28,	[sp, #984]

    cset	w27,	ne
    mov	w25,	w27
    cmp	w28,	#0
    cset	w20,	ne
    ldr	w19,	[sp, #692]

    mov	w0,	w20
    cmp	w19,	#0
    movz	w20,	#0
    mov	w27,	w20
    csel	w20,	w0,	w27,	ne
    cmp	w20,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w25,	#0
    movz	w0,	#1
    mov	w21,	w0
    csel	w22,	w21,	w18,	ne
    str	w22,	[sp, #988]

    ldr	w18,	[sp, #956]

    cmp	w18,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    mov	w28,	w18
    str	w28,	[sp, #1072]

    ldr	w23,	[sp, #988]

    cmp	w23,	#0
    cset	w23,	ne
    ldr	w22,	[sp, #1072]

    mov	w25,	w23
    cmp	w22,	#0
    movz	w20,	#1
    mov	w18,	w20
    csel	w27,	w18,	w25,	ne
    str	w27,	[sp, #768]

    ldr	w24,	[sp, #988]

    cmp	w24,	#0
    cset	w18,	ne
    ldr	w24,	[sp, #1072]

    mov	w0,	w18
    cmp	w24,	#0
    movz	w25,	#0
    mov	w18,	w25
    csel	w25,	w0,	w18,	ne
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    ldr	w20,	[sp, #768]

    cset	w18,	ne
    mov	w0,	w18
    cmp	w20,	#0
    movz	w25,	#0
    mov	w18,	w25
    csel	w21,	w0,	w18,	ne
    str	w21,	[sp, #976]

    ldr	w19,	[sp, #956]

    cmp	w19,	#0
    ldr	w21,	[sp, #988]

    cset	w27,	ne
    mov	w26,	w27
    cmp	w21,	#0
    cset	w18,	ne
    ldr	w24,	[sp, #1072]

    mov	w0,	w18
    cmp	w24,	#0
    movz	w18,	#0
    mov	w25,	w18
    csel	w20,	w0,	w25,	ne
    cmp	w20,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w26,	#0
    movz	w0,	#1
    mov	w20,	w0
    csel	w27,	w20,	w28,	ne
    str	w27,	[sp, #992]

    ldr	w28,	[sp, #868]

    cmp	w28,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    mov	w21,	w18
    str	w21,	[sp, #1076]

    ldr	w28,	[sp, #992]

    cmp	w28,	#0
    cset	w23,	ne
    ldr	w28,	[sp, #1076]

    mov	w25,	w23
    cmp	w28,	#0
    movz	w20,	#1
    mov	w18,	w20
    csel	w27,	w18,	w25,	ne
    str	w27,	[sp, #792]

    ldr	w0,	[sp, #992]

    cmp	w0,	#0
    cset	w18,	ne
    mov	w0,	w18
    ldr	w18,	[sp, #1076]

    cmp	w18,	#0
    movz	w25,	#0
    mov	w18,	w25
    csel	w25,	w0,	w18,	ne
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    ldr	w22,	[sp, #792]

    mov	w0,	w18
    cmp	w22,	#0
    movz	w27,	#0
    csel	w24,	w0,	w27,	ne
    str	w24,	[sp, #964]

    ldr	w0,	[sp, #868]

    cmp	w0,	#0
    cset	w27,	ne
    mov	w26,	w27
    ldr	w27,	[sp, #992]

    cmp	w27,	#0
    ldr	w19,	[sp, #1076]

    cset	w18,	ne
    mov	w0,	w18
    cmp	w19,	#0
    movz	w18,	#0
    mov	w25,	w18
    csel	w20,	w0,	w25,	ne
    cmp	w20,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w26,	#0
    movz	w0,	#1
    mov	w20,	w0
    csel	w20,	w20,	w28,	ne
    str	w20,	[sp, #996]

    ldr	w24,	[sp, #764]

    cmp	w24,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    mov	w26,	w18
    str	w26,	[sp, #1080]

    ldr	w21,	[sp, #996]

    cmp	w21,	#0
    ldr	w21,	[sp, #1080]

    cset	w23,	ne
    mov	w25,	w23
    cmp	w21,	#0
    movz	w20,	#1
    mov	w18,	w20
    csel	w18,	w18,	w25,	ne
    str	w18,	[sp, #796]

    ldr	w22,	[sp, #996]

    cmp	w22,	#0
    cset	w18,	ne
    ldr	w23,	[sp, #1080]

    mov	w0,	w18
    cmp	w23,	#0
    movz	w25,	#0
    mov	w18,	w25
    csel	w25,	w0,	w18,	ne
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    ldr	w25,	[sp, #796]

    cset	w18,	ne
    mov	w0,	w18
    cmp	w25,	#0
    movz	w27,	#0
    csel	w18,	w0,	w27,	ne
    str	w18,	[sp, #972]

    ldr	w25,	[sp, #764]

    cmp	w25,	#0
    cset	w27,	ne
    ldr	w20,	[sp, #996]

    mov	w26,	w27
    cmp	w20,	#0
    ldr	w24,	[sp, #1080]

    cset	w18,	ne
    mov	w0,	w18
    cmp	w24,	#0
    movz	w18,	#0
    mov	w25,	w18
    csel	w20,	w0,	w25,	ne
    cmp	w20,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w26,	#0
    movz	w0,	#1
    mov	w20,	w0
    csel	w25,	w20,	w28,	ne
    str	w25,	[sp, #1000]

    ldr	w21,	[sp, #280]

    cmp	w21,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    mov	w19,	w18
    str	w19,	[sp, #1084]

    ldr	w26,	[sp, #1000]

    cmp	w26,	#0
    ldr	w27,	[sp, #1084]

    cset	w23,	ne
    mov	w25,	w23
    cmp	w27,	#0
    movz	w20,	#1
    mov	w18,	w20
    csel	w21,	w18,	w25,	ne
    str	w21,	[sp, #960]

    ldr	w27,	[sp, #1000]

    cmp	w27,	#0
    ldr	w28,	[sp, #1084]

    cset	w18,	ne
    mov	w0,	w18
    cmp	w28,	#0
    movz	w25,	#0
    mov	w18,	w25
    csel	w25,	w0,	w18,	ne
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    ldr	w28,	[sp, #960]

    mov	w0,	w18
    cmp	w28,	#0
    movz	w27,	#0
    csel	w24,	w0,	w27,	ne
    str	w24,	[sp, #864]

    ldr	w0,	[sp, #280]

    cmp	w0,	#0
    cset	w27,	ne
    ldr	w25,	[sp, #1000]

    mov	w26,	w27
    cmp	w25,	#0
    ldr	w19,	[sp, #1084]

    cset	w18,	ne
    mov	w0,	w18
    cmp	w19,	#0
    movz	w18,	#0
    mov	w25,	w18
    csel	w20,	w0,	w25,	ne
    cmp	w20,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w26,	#0
    movz	w0,	#1
    mov	w20,	w0
    csel	w19,	w20,	w28,	ne
    str	w19,	[sp, #784]

    ldr	w28,	[sp, #500]

    cmp	w28,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    mov	w25,	w18
    str	w25,	[sp, #684]

    ldr	w20,	[sp, #784]

    cmp	w20,	#0
    cset	w23,	ne
    ldr	w18,	[sp, #684]

    mov	w25,	w23
    cmp	w18,	#0
    ldr	w21,	[sp, #784]

    movz	w20,	#1
    mov	w18,	w20
    csel	w19,	w18,	w25,	ne
    cmp	w21,	#0
    cset	w18,	ne
    ldr	w20,	[sp, #684]

    mov	w0,	w18
    cmp	w20,	#0
    movz	w25,	#0
    mov	w18,	w25
    csel	w0,	w0,	w18,	ne
    cmp	w0,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    mov	w0,	w18
    cmp	w19,	#0
    movz	w27,	#0
    csel	w20,	w0,	w27,	ne
    str	w20,	[sp, #760]

    ldr	w0,	[sp, #500]

    cmp	w0,	#0
    ldr	w26,	[sp, #784]

    cset	w27,	ne
    mov	w28,	w27
    cmp	w26,	#0
    ldr	w18,	[sp, #684]

    cset	w24,	ne
    mov	w26,	w24
    cmp	w18,	#0
    movz	w25,	#0
    mov	w19,	w25
    csel	w20,	w26,	w19,	ne
    cmp	w20,	#0
    cset	w0,	ne
    mov	w24,	w0
    cmp	w28,	#0
    movz	w18,	#1
    mov	w20,	w18
    csel	w18,	w20,	w24,	ne
    str	w18,	[sp, #772]

    ldr	w21,	[sp, #516]

    cmp	w21,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    mov	w27,	w18
    str	w27,	[sp, #676]

    ldr	w19,	[sp, #772]

    cmp	w19,	#0
    cset	w23,	ne
    ldr	w19,	[sp, #676]

    mov	w25,	w23
    cmp	w19,	#0
    movz	w20,	#1
    mov	w18,	w20
    csel	w19,	w18,	w25,	ne
    ldr	w20,	[sp, #772]

    cmp	w20,	#0
    cset	w18,	ne
    ldr	w21,	[sp, #676]

    mov	w0,	w18
    cmp	w21,	#0
    movz	w25,	#0
    mov	w18,	w25
    csel	w0,	w0,	w18,	ne
    cmp	w0,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    mov	w0,	w18
    cmp	w19,	#0
    movz	w27,	#0
    csel	w21,	w0,	w27,	ne
    str	w21,	[sp, #860]

    ldr	w0,	[sp, #516]

    cmp	w0,	#0
    ldr	w24,	[sp, #772]

    cset	w27,	ne
    mov	w28,	w27
    cmp	w24,	#0
    ldr	w18,	[sp, #676]

    cset	w24,	ne
    mov	w26,	w24
    cmp	w18,	#0
    movz	w19,	#0
    mov	w25,	w19
    csel	w20,	w26,	w25,	ne
    cmp	w20,	#0
    cset	w0,	ne
    mov	w24,	w0
    cmp	w28,	#0
    movz	w18,	#1
    mov	w20,	w18
    csel	w23,	w20,	w24,	ne
    str	w23,	[sp, #776]

    ldr	w23,	[sp, #112]

    cmp	w23,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    mov	w20,	w18
    str	w20,	[sp, #680]

    ldr	w24,	[sp, #776]

    cmp	w24,	#0
    cset	w23,	ne
    ldr	w24,	[sp, #680]

    mov	w25,	w23
    cmp	w24,	#0
    movz	w20,	#1
    mov	w18,	w20
    csel	w28,	w18,	w25,	ne
    str	w28,	[sp, #780]

    ldr	w25,	[sp, #776]

    cmp	w25,	#0
    ldr	w26,	[sp, #680]

    cset	w18,	ne
    mov	w0,	w18
    cmp	w26,	#0
    movz	w25,	#0
    mov	w18,	w25
    csel	w25,	w0,	w18,	ne
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    ldr	w22,	[sp, #780]

    cset	w18,	ne
    mov	w0,	w18
    cmp	w22,	#0
    movz	w27,	#0
    csel	w24,	w0,	w27,	ne
    str	w24,	[sp, #788]

    ldr	w24,	[sp, #112]

    cmp	w24,	#0
    ldr	w18,	[sp, #776]

    cset	w27,	ne
    mov	w28,	w27
    cmp	w18,	#0
    cset	w24,	ne
    ldr	w23,	[sp, #680]

    mov	w26,	w24
    cmp	w23,	#0
    movz	w22,	#0
    mov	w0,	w22
    csel	w20,	w26,	w0,	ne
    cmp	w20,	#0
    cset	w0,	ne
    mov	w24,	w0
    cmp	w28,	#0
    movz	w18,	#1
    mov	w20,	w18
    csel	w21,	w20,	w24,	ne
    str	w21,	[sp, #252]

    ldr	w27,	[sp, #132]

    cmp	w27,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    ldr	w21,	[sp, #252]

    mov	w0,	w18
    cmp	w21,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w0,	#0
    movz	w20,	#1
    mov	w21,	w20
    csel	w28,	w21,	w27,	ne
    str	w28,	[sp, #1156]

    ldr	w22,	[sp, #252]

    cmp	w22,	#0
    cset	w21,	ne
    mov	w27,	w21
    cmp	w0,	#0
    movz	w26,	#0
    mov	w20,	w26
    csel	w18,	w27,	w20,	ne
    cmp	w18,	#0
    cset	w19,	eq
    mov	w21,	w19
    cmp	w21,	#0
    ldr	w28,	[sp, #1156]

    cset	w25,	ne
    mov	w21,	w25
    cmp	w28,	#0
    movz	w27,	#0
    csel	w27,	w21,	w27,	ne
    str	w27,	[sp, #852]

    ldr	w26,	[sp, #132]

    cmp	w26,	#0
    cset	w21,	ne
    ldr	w19,	[sp, #252]

    mov	w25,	w21
    cmp	w19,	#0
    cset	w23,	ne
    mov	w18,	w23
    cmp	w0,	#0
    movz	w0,	#0
    mov	w23,	w0
    csel	w20,	w18,	w23,	ne
    cmp	w20,	#0
    cset	w0,	ne
    mov	w27,	w0
    cmp	w25,	#0
    movz	w18,	#1
    mov	w20,	w18
    csel	w0,	w20,	w27,	ne
    str	w0,	[sp, #856]

    ldr	w24,	[sp, #128]

    cmp	w24,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w25,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    ldr	w20,	[sp, #856]

    mov	w0,	w18
    cmp	w20,	#0
    cset	w25,	ne
    str	w25,	[sp, #256]

    cmp	w0,	#0
    movz	w21,	#1
    ldr	w23,	[sp, #256]

    mov	w19,	w21
    csel	w22,	w19,	w23,	ne
    ldr	w21,	[sp, #856]

    cmp	w21,	#0
    cset	w21,	ne
    mov	w25,	w21
    cmp	w0,	#0
    movz	w0,	#0
    csel	w0,	w25,	w0,	ne
    cmp	w0,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w18,	ne
    mov	w0,	w18
    cmp	w22,	#0
    movz	w27,	#0
    csel	w25,	w0,	w27,	ne
    lsl	w0,	w25,	#1
    ldr	w27,	[sp, #852]

    ldr	w25,	[sp, #788]

    add	w28,	w0,	w27
    ldr	w22,	[sp, #860]

    ldr	w21,	[sp, #760]

    lsl	w20,	w28,	#1
    add	w0,	w20,	w25
    lsl	w25,	w0,	#1
    add	w25,	w25,	w22
    lsl	w0,	w25,	#1
    ldr	w25,	[sp, #864]

    add	w28,	w0,	w21
    ldr	w19,	[sp, #972]

    lsl	w20,	w28,	#1
    add	w0,	w20,	w25
    lsl	w25,	w0,	#1
    add	w25,	w25,	w19
    lsl	w0,	w25,	#1
    ldr	w25,	[sp, #964]

    ldr	w22,	[sp, #976]

    add	w28,	w0,	w25
    lsl	w20,	w28,	#1
    ldr	w28,	[sp, #968]

    add	w0,	w20,	w22
    lsl	w24,	w0,	#1
    add	w25,	w24,	w28
    ldr	w28,	[sp, #260]

    ldr	w0,	[sp, #480]

    lsl	w27,	w25,	#1
    add	w28,	w27,	w28
    lsl	w18,	w28,	#1
    add	w0,	w18,	w0
    lsl	w23,	w0,	#1
    ldr	w0,	[sp, #492]

    add	w25,	w23,	w0
    ldr	w28,	[sp, #528]

    ldr	w26,	[sp, #120]

    lsl	w27,	w25,	#1
    add	w28,	w27,	w28
    lsl	w18,	w28,	#1
    add	w0,	w18,	w26
    lsl	w23,	w0,	#1
    ldr	w0,	[sp, #136]

    add	w0,	w23,	w0
    bl	fib
    str	w0,	[sp, #140]

    ldr	w0,	[sp, #432]

    cmp	w0,	#0
    ldr	w21,	[sp, #356]

    ldr	w23,	[sp, #432]

    csel	w0,	w21,	w23,	lt
    str	w0,	[sp, #1032]

    ldr	w0,	[sp, #440]

    cmp	w0,	#0
    ldr	w20,	[sp, #372]

    ldr	w23,	[sp, #440]

    ldr	w21,	[sp, #444]

    csel	w24,	w20,	w23,	lt
    cmp	w21,	#0
    ldr	w0,	[sp, #388]

    ldr	w22,	[sp, #444]

    csel	w28,	w0,	w22,	lt
    str	w28,	[sp, #552]

    ldr	w26,	[sp, #452]

    cmp	w26,	#0
    ldr	w26,	[sp, #400]

    ldr	w27,	[sp, #452]

    csel	w20,	w26,	w27,	lt
    str	w20,	[sp, #556]

    ldr	w0,	[sp, #448]

    cmp	w0,	#0
    ldr	w23,	[sp, #412]

    ldr	w19,	[sp, #448]

    csel	w25,	w23,	w19,	lt
    str	w25,	[sp, #560]

    ldr	w28,	[sp, #436]

    cmp	w28,	#0
    ldr	w18,	[sp, #424]

    ldr	w0,	[sp, #436]

    csel	w21,	w18,	w0,	lt
    str	w21,	[sp, #572]

    ldr	w23,	[sp, #428]

    cmp	w23,	#0
    ldr	w28,	[sp, #416]

    ldr	w0,	[sp, #428]

    csel	w0,	w28,	w0,	lt
    str	w0,	[sp, #568]

    ldr	w22,	[sp, #420]

    cmp	w22,	#0
    ldr	w18,	[sp, #404]

    ldr	w23,	[sp, #420]

    csel	w26,	w18,	w23,	lt
    str	w26,	[sp, #576]

    ldr	w28,	[sp, #408]

    cmp	w28,	#0
    ldr	w27,	[sp, #392]

    ldr	w28,	[sp, #408]

    csel	w18,	w27,	w28,	lt
    str	w18,	[sp, #580]

    ldr	w22,	[sp, #396]

    cmp	w22,	#0
    ldr	w21,	[sp, #380]

    ldr	w19,	[sp, #396]

    csel	w23,	w21,	w19,	lt
    str	w23,	[sp, #704]

    ldr	w28,	[sp, #384]

    cmp	w28,	#0
    ldr	w27,	[sp, #368]

    ldr	w25,	[sp, #384]

    csel	w23,	w27,	w25,	lt
    str	w23,	[sp, #720]

    ldr	w27,	[sp, #376]

    cmp	w27,	#0
    ldr	w26,	[sp, #360]

    ldr	w22,	[sp, #376]

    csel	w23,	w26,	w22,	lt
    str	w23,	[sp, #288]

    ldr	w21,	[sp, #364]

    cmp	w21,	#0
    ldr	w20,	[sp, #348]

    ldr	w27,	[sp, #364]

    csel	w26,	w20,	w27,	lt
    str	w26,	[sp, #496]

    ldr	w27,	[sp, #352]

    cmp	w27,	#0
    ldr	w19,	[sp, #156]

    ldr	w0,	[sp, #352]

    csel	w26,	w19,	w0,	lt
    str	w26,	[sp, #524]

    ldr	w26,	[sp, #160]

    cmp	w26,	#0
    ldr	w0,	[sp, #148]

    ldr	w18,	[sp, #160]

    csel	w26,	w0,	w18,	lt
    str	w26,	[sp, #104]

    ldr	w0,	[sp, #152]

    cmp	w0,	#0
    ldr	w0,	[sp, #144]

    ldr	w26,	[sp, #152]

    csel	w19,	w0,	w26,	lt
    str	w19,	[sp, #108]

    ldr	w23,	[sp, #1032]

    cmp	w23,	#0
    cset	w27,	ne
    cmp	w27,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w21,	ne
    str	w21,	[sp, #124]

    cmp	w24,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    cmp	w28,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w28,	ne
    str	w28,	[sp, #116]

    cmp	w24,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w25,	ne
    mov	w0,	w25
    str	w0,	[sp, #1148]

    ldr	w23,	[sp, #552]

    cmp	w23,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w0,	ne
    mov	w20,	w0
    str	w20,	[sp, #240]

    ldr	w18,	[sp, #1148]

    cmp	w18,	#0
    cset	w27,	ne
    ldr	w19,	[sp, #240]

    mov	w18,	w27
    cmp	w19,	#0
    movz	w0,	#1
    csel	w0,	w0,	w18,	ne
    str	w0,	[sp, #236]

    ldr	w19,	[sp, #1148]

    cmp	w19,	#0
    ldr	w0,	[sp, #240]

    cset	w21,	ne
    mov	w24,	w21
    cmp	w0,	#0
    movz	w28,	#0
    mov	w0,	w28
    csel	w27,	w24,	w0,	ne
    cmp	w27,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w18,	ne
    ldr	w26,	[sp, #236]

    mov	w20,	w18
    cmp	w26,	#0
    movz	w24,	#0
    csel	w24,	w20,	w24,	ne
    str	w24,	[sp, #100]

    ldr	w24,	[sp, #552]

    cmp	w24,	#0
    cset	w24,	ne
    ldr	w20,	[sp, #1148]

    cmp	w20,	#0
    ldr	w26,	[sp, #240]

    cset	w23,	ne
    mov	w28,	w23
    cmp	w26,	#0
    movz	w0,	#0
    csel	w0,	w28,	w0,	ne
    cmp	w0,	#0
    cset	w0,	ne
    mov	w19,	w0
    cmp	w24,	#0
    movz	w22,	#1
    ldr	w27,	[sp, #556]

    csel	w21,	w22,	w19,	ne
    cmp	w27,	#0
    cset	w27,	ne
    cmp	w27,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w27,	ne
    cmp	w21,	#0
    cset	w23,	ne
    mov	w28,	w23
    cmp	w27,	#0
    movz	w20,	#1
    csel	w22,	w20,	w28,	ne
    cmp	w21,	#0
    cset	w20,	ne
    str	w20,	[sp, #284]

    cmp	w27,	#0
    movz	w20,	#0
    ldr	w24,	[sp, #284]

    csel	w28,	w24,	w20,	ne
    cmp	w28,	#0
    cset	w24,	eq
    cmp	w24,	#0
    cset	w25,	ne
    mov	w0,	w25
    cmp	w22,	#0
    movz	w19,	#0
    csel	w22,	w0,	w19,	ne
    str	w22,	[sp, #512]

    ldr	w22,	[sp, #556]

    cmp	w22,	#0
    cset	w25,	ne
    cmp	w21,	#0
    cset	w18,	ne
    mov	w21,	w18
    cmp	w27,	#0
    movz	w19,	#0
    csel	w0,	w21,	w19,	ne
    cmp	w0,	#0
    cset	w23,	ne
    mov	w28,	w23
    cmp	w25,	#0
    movz	w18,	#1
    csel	w24,	w18,	w28,	ne
    str	w24,	[sp, #1120]

    ldr	w19,	[sp, #560]

    cmp	w19,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w27,	eq
    cmp	w27,	#0
    ldr	w26,	[sp, #1120]

    cset	w21,	ne
    cmp	w26,	#0
    cset	w0,	ne
    cmp	w21,	#0
    movz	w25,	#1
    ldr	w27,	[sp, #1120]

    csel	w28,	w25,	w0,	ne
    cmp	w27,	#0
    cset	w19,	ne
    mov	w23,	w19
    cmp	w21,	#0
    movz	w20,	#0
    csel	w25,	w23,	w20,	ne
    cmp	w25,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w0,	ne
    mov	w20,	w0
    cmp	w28,	#0
    movz	w19,	#0
    csel	w26,	w20,	w19,	ne
    str	w26,	[sp, #484]

    ldr	w27,	[sp, #560]

    cmp	w27,	#0
    ldr	w23,	[sp, #1120]

    cset	w0,	ne
    cmp	w23,	#0
    cset	w23,	ne
    mov	w27,	w23
    cmp	w21,	#0
    movz	w18,	#0
    csel	w21,	w27,	w18,	ne
    cmp	w21,	#0
    cset	w25,	ne
    mov	w18,	w25
    cmp	w0,	#0
    movz	w27,	#1
    csel	w23,	w27,	w18,	ne
    str	w23,	[sp, #736]

    ldr	w27,	[sp, #572]

    cmp	w27,	#0
    cset	w22,	ne
    cmp	w22,	#0
    cset	w24,	eq
    cmp	w24,	#0
    ldr	w25,	[sp, #736]

    cset	w27,	ne
    cmp	w25,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w27,	#0
    movz	w0,	#1
    ldr	w26,	[sp, #736]

    csel	w22,	w0,	w19,	ne
    cmp	w26,	#0
    cset	w24,	ne
    mov	w0,	w24
    cmp	w27,	#0
    movz	w23,	#0
    csel	w25,	w0,	w23,	ne
    cmp	w25,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w23,	ne
    mov	w28,	w23
    cmp	w22,	#0
    movz	w20,	#0
    csel	w24,	w28,	w20,	ne
    str	w24,	[sp, #272]

    ldr	w23,	[sp, #572]

    cmp	w23,	#0
    cset	w28,	ne
    ldr	w22,	[sp, #736]

    cmp	w22,	#0
    cset	w22,	ne
    mov	w25,	w22
    cmp	w27,	#0
    movz	w19,	#0
    csel	w24,	w25,	w19,	ne
    cmp	w24,	#0
    cset	w25,	ne
    mov	w0,	w25
    cmp	w28,	#0
    ldr	w23,	[sp, #568]

    movz	w21,	#1
    csel	w28,	w21,	w0,	ne
    cmp	w23,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w21,	ne
    cmp	w28,	#0
    cset	w19,	ne
    mov	w22,	w19
    cmp	w21,	#0
    movz	w27,	#1
    csel	w23,	w27,	w22,	ne
    cmp	w28,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w21,	#0
    movz	w0,	#0
    csel	w0,	w18,	w0,	ne
    cmp	w0,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w0,	ne
    cmp	w23,	#0
    movz	w25,	#0
    csel	w22,	w0,	w25,	ne
    str	w22,	[sp, #1116]

    ldr	w19,	[sp, #568]

    cmp	w19,	#0
    cset	w19,	ne
    cmp	w28,	#0
    cset	w20,	ne
    mov	w23,	w20
    cmp	w21,	#0
    movz	w24,	#0
    csel	w27,	w23,	w24,	ne
    cmp	w27,	#0
    cset	w0,	ne
    mov	w21,	w0
    cmp	w19,	#0
    movz	w0,	#1
    csel	w28,	w0,	w21,	ne
    str	w28,	[sp, #740]

    ldr	w19,	[sp, #576]

    cmp	w19,	#0
    cset	w27,	ne
    cmp	w27,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w27,	ne
    ldr	w19,	[sp, #740]

    cmp	w19,	#0
    cset	w24,	ne
    mov	w0,	w24
    cmp	w27,	#0
    movz	w28,	#1
    ldr	w20,	[sp, #740]

    csel	w23,	w28,	w0,	ne
    cmp	w20,	#0
    cset	w19,	ne
    mov	w21,	w19
    cmp	w27,	#0
    movz	w25,	#0
    csel	w0,	w21,	w25,	ne
    cmp	w0,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w23,	#0
    movz	w0,	#0
    csel	w18,	w19,	w0,	ne
    str	w18,	[sp, #1112]

    ldr	w28,	[sp, #576]

    cmp	w28,	#0
    cset	w24,	ne
    ldr	w0,	[sp, #740]

    cmp	w0,	#0
    cset	w21,	ne
    mov	w25,	w21
    cmp	w27,	#0
    movz	w23,	#0
    csel	w0,	w25,	w23,	ne
    cmp	w0,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w24,	#0
    ldr	w23,	[sp, #580]

    movz	w25,	#1
    csel	w25,	w25,	w22,	ne
    cmp	w23,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w21,	ne
    cmp	w25,	#0
    cset	w27,	ne
    mov	w0,	w27
    cmp	w21,	#0
    movz	w19,	#1
    csel	w18,	w19,	w0,	ne
    cmp	w25,	#0
    cset	w20,	ne
    mov	w23,	w20
    cmp	w21,	#0
    movz	w28,	#0
    csel	w0,	w23,	w28,	ne
    cmp	w0,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w19,	ne
    mov	w22,	w19
    cmp	w18,	#0
    movz	w27,	#0
    csel	w24,	w22,	w27,	ne
    str	w24,	[sp, #1104]

    ldr	w20,	[sp, #580]

    cmp	w20,	#0
    cset	w27,	ne
    cmp	w25,	#0
    cset	w22,	ne
    mov	w25,	w22
    cmp	w21,	#0
    movz	w0,	#0
    csel	w23,	w25,	w0,	ne
    cmp	w23,	#0
    cset	w0,	ne
    cmp	w27,	#0
    movz	w18,	#1
    csel	w21,	w18,	w0,	ne
    str	w21,	[sp, #744]

    ldr	w28,	[sp, #704]

    cmp	w28,	#0
    cset	w22,	ne
    cmp	w22,	#0
    cset	w24,	eq
    cmp	w24,	#0
    cset	w27,	ne
    ldr	w24,	[sp, #744]

    cmp	w24,	#0
    cset	w19,	ne
    mov	w21,	w19
    cmp	w27,	#0
    movz	w23,	#1
    ldr	w25,	[sp, #744]

    csel	w21,	w23,	w21,	ne
    cmp	w25,	#0
    cset	w0,	ne
    cmp	w27,	#0
    movz	w20,	#0
    csel	w28,	w0,	w20,	ne
    cmp	w28,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w24,	ne
    mov	w0,	w24
    cmp	w21,	#0
    movz	w28,	#0
    csel	w26,	w0,	w28,	ne
    str	w26,	[sp, #1108]

    ldr	w25,	[sp, #704]

    cmp	w25,	#0
    ldr	w23,	[sp, #744]

    cset	w19,	ne
    cmp	w23,	#0
    cset	w23,	ne
    cmp	w27,	#0
    movz	w27,	#0
    csel	w0,	w23,	w27,	ne
    cmp	w0,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w19,	#0
    movz	w22,	#1
    ldr	w27,	[sp, #720]

    csel	w24,	w22,	w18,	ne
    cmp	w27,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w21,	ne
    cmp	w24,	#0
    cset	w20,	ne
    mov	w23,	w20
    cmp	w21,	#0
    movz	w25,	#1
    csel	w19,	w25,	w23,	ne
    cmp	w24,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w21,	#0
    movz	w20,	#0
    csel	w0,	w18,	w20,	ne
    cmp	w0,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w27,	ne
    mov	w0,	w27
    cmp	w19,	#0
    movz	w19,	#0
    csel	w22,	w0,	w19,	ne
    str	w22,	[sp, #1020]

    ldr	w26,	[sp, #720]

    cmp	w26,	#0
    cset	w20,	ne
    cmp	w24,	#0
    cset	w19,	ne
    mov	w23,	w19
    cmp	w21,	#0
    movz	w28,	#0
    csel	w28,	w23,	w28,	ne
    cmp	w28,	#0
    cset	w19,	ne
    mov	w22,	w19
    cmp	w20,	#0
    movz	w24,	#1
    csel	w0,	w24,	w22,	ne
    str	w0,	[sp, #724]

    ldr	w28,	[sp, #288]

    cmp	w28,	#0
    cset	w27,	ne
    cmp	w27,	#0
    cset	w18,	eq
    cmp	w18,	#0
    ldr	w19,	[sp, #724]

    cset	w27,	ne
    cmp	w19,	#0
    cset	w25,	ne
    mov	w18,	w25
    cmp	w27,	#0
    ldr	w20,	[sp, #724]

    movz	w0,	#1
    csel	w28,	w0,	w18,	ne
    cmp	w20,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w27,	#0
    movz	w24,	#0
    csel	w0,	w22,	w24,	ne
    cmp	w0,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w19,	ne
    mov	w21,	w19
    cmp	w28,	#0
    movz	w23,	#0
    csel	w20,	w21,	w23,	ne
    str	w20,	[sp, #716]

    ldr	w18,	[sp, #288]

    cmp	w18,	#0
    ldr	w28,	[sp, #724]

    cset	w0,	ne
    cmp	w28,	#0
    cset	w23,	ne
    mov	w28,	w23
    cmp	w27,	#0
    movz	w20,	#0
    csel	w21,	w28,	w20,	ne
    cmp	w21,	#0
    cset	w25,	ne
    mov	w18,	w25
    cmp	w0,	#0
    movz	w27,	#1
    csel	w26,	w27,	w18,	ne
    str	w26,	[sp, #1024]

    ldr	w24,	[sp, #496]

    cmp	w24,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w27,	eq
    cmp	w27,	#0
    ldr	w26,	[sp, #1024]

    cset	w21,	ne
    cmp	w26,	#0
    cset	w19,	ne
    mov	w22,	w19
    cmp	w21,	#0
    movz	w27,	#1
    csel	w24,	w27,	w22,	ne
    ldr	w27,	[sp, #1024]

    cmp	w27,	#0
    cset	w25,	ne
    mov	w18,	w25
    cmp	w21,	#0
    movz	w0,	#0
    csel	w27,	w18,	w0,	ne
    cmp	w27,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w20,	ne
    mov	w23,	w20
    cmp	w24,	#0
    movz	w25,	#0
    csel	w0,	w23,	w25,	ne
    str	w0,	[sp, #712]

    ldr	w28,	[sp, #496]

    cmp	w28,	#0
    cset	w28,	ne
    ldr	w19,	[sp, #1024]

    cmp	w19,	#0
    cset	w22,	ne
    mov	w25,	w22
    cmp	w21,	#0
    movz	w23,	#0
    csel	w24,	w25,	w23,	ne
    cmp	w24,	#0
    cset	w25,	ne
    mov	w0,	w25
    cmp	w28,	#0
    movz	w21,	#1
    csel	w19,	w21,	w0,	ne
    str	w19,	[sp, #1028]

    ldr	w18,	[sp, #524]

    cmp	w18,	#0
    cset	w22,	ne
    cmp	w22,	#0
    cset	w24,	eq
    cmp	w24,	#0
    ldr	w19,	[sp, #1028]

    cset	w27,	ne
    cmp	w19,	#0
    cset	w24,	ne
    mov	w0,	w24
    cmp	w27,	#0
    movz	w19,	#1
    ldr	w20,	[sp, #1028]

    csel	w24,	w19,	w0,	ne
    cmp	w20,	#0
    cset	w25,	ne
    mov	w0,	w25
    cmp	w27,	#0
    movz	w28,	#0
    csel	w19,	w0,	w28,	ne
    cmp	w19,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w0,	ne
    cmp	w24,	#0
    movz	w25,	#0
    csel	w18,	w0,	w25,	ne
    str	w18,	[sp, #1016]

    ldr	w24,	[sp, #524]

    cmp	w24,	#0
    cset	w20,	ne
    ldr	w25,	[sp, #1028]

    cmp	w25,	#0
    cset	w22,	ne
    mov	w24,	w22
    cmp	w27,	#0
    movz	w25,	#0
    csel	w27,	w24,	w25,	ne
    cmp	w27,	#0
    cset	w0,	ne
    mov	w21,	w0
    cmp	w20,	#0
    movz	w0,	#1
    ldr	w24,	[sp, #104]

    csel	w20,	w0,	w21,	ne
    cmp	w24,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w21,	ne
    cmp	w20,	#0
    cset	w25,	ne
    mov	w18,	w25
    cmp	w21,	#0
    movz	w0,	#1
    csel	w18,	w0,	w18,	ne
    str	w18,	[sp, #264]

    cmp	w20,	#0
    cset	w0,	ne
    cmp	w21,	#0
    movz	w24,	#0
    mov	w18,	w24
    csel	w0,	w0,	w18,	ne
    cmp	w0,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w28,	ne
    ldr	w27,	[sp, #264]

    mov	w18,	w28
    cmp	w27,	#0
    ldr	w0,	[sp, #104]

    movz	w27,	#0
    csel	w28,	w18,	w27,	ne
    cmp	w0,	#0
    cset	w27,	ne
    cmp	w20,	#0
    cset	w18,	ne
    mov	w22,	w18
    cmp	w21,	#0
    movz	w20,	#0
    csel	w21,	w22,	w20,	ne
    cmp	w21,	#0
    cset	w25,	ne
    cmp	w27,	#0
    ldr	w22,	[sp, #108]

    movz	w27,	#1
    csel	w0,	w27,	w25,	ne
    cmp	w22,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w21,	eq
    cmp	w21,	#0
    cset	w23,	ne
    cmp	w0,	#0
    cset	w19,	ne
    str	w19,	[sp, #268]

    cmp	w23,	#0
    movz	w19,	#1
    ldr	w18,	[sp, #268]

    csel	w19,	w19,	w18,	ne
    cmp	w0,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w23,	#0
    movz	w0,	#0
    csel	w18,	w18,	w0,	ne
    cmp	w18,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w24,	ne
    mov	w25,	w24
    cmp	w19,	#0
    ldr	w21,	[sp, #1016]

    movz	w27,	#0
    csel	w25,	w25,	w27,	ne
    lsl	w0,	w25,	#1
    add	w18,	w0,	w28
    lsl	w23,	w18,	#1
    add	w21,	w23,	w21
    lsl	w25,	w21,	#1
    ldr	w21,	[sp, #712]

    add	w23,	w25,	w21
    ldr	w24,	[sp, #716]

    lsl	w0,	w23,	#1
    add	w24,	w0,	w24
    lsl	w28,	w24,	#1
    ldr	w24,	[sp, #1020]

    add	w27,	w28,	w24
    ldr	w28,	[sp, #1108]

    ldr	w25,	[sp, #1104]

    lsl	w19,	w27,	#1
    add	w18,	w19,	w28
    ldr	w19,	[sp, #1112]

    lsl	w22,	w18,	#1
    add	w21,	w22,	w25
    ldr	w22,	[sp, #1116]

    ldr	w27,	[sp, #272]

    lsl	w25,	w21,	#1
    add	w23,	w25,	w19
    lsl	w0,	w23,	#1
    add	w24,	w0,	w22
    lsl	w25,	w24,	#1
    add	w27,	w25,	w27
    lsl	w0,	w27,	#1
    ldr	w27,	[sp, #484]

    add	w18,	w0,	w27
    ldr	w24,	[sp, #512]

    ldr	w19,	[sp, #100]

    lsl	w20,	w18,	#1
    add	w21,	w20,	w24
    ldr	w24,	[sp, #116]

    lsl	w22,	w21,	#1
    add	w23,	w22,	w19
    lsl	w0,	w23,	#1
    add	w18,	w0,	w24
    ldr	w0,	[sp, #124]

    lsl	w19,	w18,	#1
    add	w0,	w19,	w0
    bl	fib
    ldr	w14,	[sp, #140]

    movz	w4,	#0
    asr	w12,	w14,	#31
    ldr	w20,	[sp, #140]

    ldr	w21,	[sp, #140]

    lsr	w13,	w12,	#31
    add	w14,	w20,	w13
    asr	w5,	w14,	#1
    lsl	w6,	w5,	#1
    sub	w26,	w21,	w6
    sub	w27,	w4,	w26
    cmp	w26,	#0
    csel	w5,	w27,	w26,	lt
    movz	w28,	#0
    str	w5,	[sp, #200]

    ldr	w17,	[sp, #140]

    ldr	w23,	[sp, #140]

    asr	w15,	w17,	#31
    lsr	w16,	w15,	#31
    add	w17,	w23,	w16
    asr	w4,	w17,	#1
    asr	w25,	w4,	#31
    lsr	w26,	w25,	#31
    add	w27,	w4,	w26
    asr	w20,	w27,	#1
    lsl	w21,	w20,	#1
    sub	w2,	w4,	w21
    sub	w6,	w28,	w2
    cmp	w2,	#0
    csel	w3,	w6,	w2,	lt
    movz	w24,	#0
    asr	w28,	w4,	#31
    str	w3,	[sp, #176]

    lsr	w1,	w28,	#31
    add	w23,	w4,	w1
    asr	w6,	w23,	#1
    asr	w3,	w6,	#31
    lsr	w4,	w3,	#31
    add	w5,	w6,	w4
    asr	w17,	w5,	#1
    lsl	w18,	w17,	#1
    sub	w9,	w6,	w18
    sub	w12,	w24,	w9
    cmp	w9,	#0
    asr	w8,	w6,	#31
    movz	w20,	#0
    csel	w26,	w12,	w9,	lt
    lsr	w9,	w8,	#31
    str	w26,	[sp, #172]

    add	w1,	w6,	w9
    asr	w11,	w1,	#1
    asr	w9,	w11,	#31
    lsr	w10,	w9,	#31
    add	w13,	w11,	w10
    asr	w13,	w13,	#1
    lsl	w14,	w13,	#1
    sub	w14,	w11,	w14
    sub	w17,	w20,	w14
    cmp	w14,	#0
    csel	w13,	w17,	w14,	lt
    asr	w14,	w11,	#31
    str	w13,	[sp, #184]

    lsr	w15,	w14,	#31
    add	w7,	w11,	w15
    asr	w19,	w7,	#1
    asr	w15,	w19,	#31
    lsr	w16,	w15,	#31
    add	w18,	w19,	w16
    movz	w16,	#0
    asr	w7,	w18,	#1
    lsl	w8,	w7,	#1
    sub	w21,	w19,	w8
    sub	w22,	w16,	w21
    cmp	w21,	#0
    movz	w12,	#0
    asr	w20,	w19,	#31
    csel	w8,	w22,	w21,	lt
    str	w8,	[sp, #180]

    lsr	w21,	w20,	#31
    add	w13,	w19,	w21
    asr	w24,	w13,	#1
    asr	w21,	w24,	#31
    lsr	w23,	w21,	#31
    add	w25,	w24,	w23
    asr	w3,	w25,	#1
    lsl	w4,	w3,	#1
    sub	w26,	w24,	w4
    sub	w27,	w12,	w26
    cmp	w26,	#0
    movz	w8,	#0
    csel	w18,	w27,	w26,	lt
    asr	w26,	w24,	#31
    str	w18,	[sp, #188]

    lsr	w27,	w26,	#31
    add	w19,	w24,	w27
    asr	w1,	w19,	#1
    asr	w2,	w1,	#31
    lsr	w3,	w2,	#31
    add	w3,	w1,	w3
    asr	w27,	w3,	#1
    lsl	w2,	w27,	#1
    sub	w4,	w1,	w2
    sub	w3,	w8,	w4
    cmp	w4,	#0
    csel	w28,	w3,	w4,	lt
    str	w28,	[sp, #196]

    asr	w4,	w1,	#31
    lsr	w5,	w4,	#31
    movz	w4,	#0
    add	w25,	w1,	w5
    asr	w6,	w25,	#1
    asr	w8,	w6,	#31
    lsr	w9,	w8,	#31
    add	w10,	w6,	w9
    asr	w24,	w10,	#1
    lsl	w25,	w24,	#1
    sub	w10,	w6,	w25
    sub	w11,	w4,	w10
    cmp	w10,	#0
    movz	w28,	#0
    csel	w15,	w11,	w10,	lt
    str	w15,	[sp, #928]

    asr	w11,	w6,	#31
    lsr	w12,	w11,	#31
    add	w3,	w6,	w12
    asr	w9,	w3,	#1
    asr	w14,	w9,	#31
    lsr	w15,	w14,	#31
    add	w16,	w9,	w15
    asr	w20,	w16,	#1
    lsl	w21,	w20,	#1
    sub	w13,	w9,	w21
    sub	w16,	w28,	w13
    cmp	w13,	#0
    csel	w10,	w16,	w13,	lt
    asr	w17,	w9,	#31
    movz	w24,	#0
    str	w10,	[sp, #204]

    lsr	w18,	w17,	#31
    add	w9,	w9,	w18
    asr	w14,	w9,	#1
    asr	w20,	w14,	#31
    lsr	w21,	w20,	#31
    add	w22,	w14,	w21
    asr	w16,	w22,	#1
    lsl	w17,	w16,	#1
    sub	w18,	w14,	w17
    sub	w21,	w24,	w18
    cmp	w18,	#0
    movz	w20,	#0
    csel	w23,	w21,	w18,	lt
    str	w23,	[sp, #888]

    asr	w23,	w14,	#31
    lsr	w24,	w23,	#31
    add	w15,	w14,	w24
    asr	w21,	w15,	#1
    asr	w26,	w21,	#31
    lsr	w27,	w26,	#31
    add	w28,	w21,	w27
    asr	w10,	w28,	#1
    lsl	w11,	w10,	#1
    sub	w25,	w21,	w11
    sub	w26,	w20,	w25
    cmp	w25,	#0
    movz	w16,	#0
    csel	w9,	w26,	w25,	lt
    asr	w1,	w21,	#31
    str	w9,	[sp, #900]

    lsr	w2,	w1,	#31
    add	w21,	w21,	w2
    asr	w26,	w21,	#1
    asr	w3,	w26,	#31
    lsr	w4,	w3,	#31
    add	w5,	w26,	w4
    asr	w6,	w5,	#1
    lsl	w7,	w6,	#1
    sub	w2,	w26,	w7
    sub	w4,	w16,	w2
    cmp	w2,	#0
    asr	w6,	w26,	#31
    csel	w28,	w4,	w2,	lt
    str	w28,	[sp, #916]

    lsr	w7,	w6,	#31
    add	w27,	w26,	w7
    asr	w2,	w27,	#1
    asr	w11,	w2,	#31
    lsr	w12,	w11,	#31
    add	w13,	w2,	w12
    movz	w12,	#0
    asr	w4,	w13,	#1
    lsl	w5,	w4,	#1
    sub	w7,	w2,	w5
    sub	w10,	w12,	w7
    cmp	w7,	#0
    csel	w5,	w10,	w7,	lt
    asr	w14,	w2,	#31
    str	w5,	[sp, #920]

    lsr	w15,	w14,	#31
    add	w5,	w2,	w15
    asr	w12,	w5,	#1
    asr	w6,	w12,	#31
    lsr	w7,	w6,	#31
    add	w8,	w12,	w7
    asr	w9,	w8,	#1
    movz	w8,	#0
    lsl	w10,	w9,	#1
    sub	w10,	w12,	w10
    sub	w11,	w8,	w10
    cmp	w10,	#0
    movz	w4,	#0
    asr	w9,	w12,	#31
    csel	w19,	w11,	w10,	lt
    lsr	w10,	w9,	#31
    str	w19,	[sp, #908]

    add	w11,	w12,	w10
    asr	w7,	w11,	#1
    asr	w12,	w7,	#31
    lsr	w13,	w12,	#31
    add	w14,	w7,	w13
    asr	w5,	w14,	#1
    lsl	w6,	w5,	#1
    sub	w15,	w7,	w6
    sub	w16,	w4,	w15
    cmp	w15,	#0
    movz	w28,	#0
    csel	w14,	w16,	w15,	lt
    str	w14,	[sp, #904]

    asr	w15,	w7,	#31
    lsr	w16,	w15,	#31
    add	w17,	w7,	w16
    asr	w9,	w17,	#1
    asr	w1,	w9,	#31
    lsr	w2,	w1,	#31
    add	w2,	w9,	w2
    asr	w19,	w2,	#1
    lsl	w20,	w19,	#1
    sub	w18,	w9,	w20
    sub	w21,	w28,	w18
    cmp	w18,	#0
    csel	w28,	w21,	w18,	lt
    movz	w25,	#0
    asr	w21,	w0,	#31
    str	w28,	[sp, #892]

    lsr	w22,	w21,	#31
    add	w23,	w0,	w22
    asr	w26,	w23,	#1
    lsl	w27,	w26,	#1
    sub	w22,	w0,	w27
    sub	w25,	w25,	w22
    cmp	w22,	#0
    movz	w11,	#0
    csel	w23,	w25,	w22,	lt
    asr	w24,	w0,	#31
    str	w23,	[sp, #192]

    lsr	w25,	w24,	#31
    add	w24,	w0,	w25
    asr	w7,	w24,	#1
    asr	w25,	w7,	#31
    lsr	w26,	w25,	#31
    add	w27,	w7,	w26
    asr	w12,	w27,	#1
    lsl	w13,	w12,	#1
    sub	w19,	w7,	w13
    sub	w20,	w11,	w19
    cmp	w19,	#0
    csel	w14,	w20,	w19,	lt
    asr	w28,	w7,	#31
    str	w14,	[sp, #896]

    lsr	w0,	w28,	#31
    add	w1,	w7,	w0
    movz	w7,	#0
    asr	w20,	w1,	#1
    asr	w2,	w20,	#31
    lsr	w3,	w2,	#31
    add	w4,	w20,	w3
    asr	w8,	w4,	#1
    lsl	w9,	w8,	#1
    sub	w24,	w20,	w9
    sub	w25,	w7,	w24
    cmp	w24,	#0
    movz	w3,	#0
    asr	w5,	w20,	#31
    csel	w6,	w25,	w24,	lt
    str	w6,	[sp, #168]

    lsr	w6,	w5,	#31
    add	w7,	w20,	w6
    asr	w10,	w7,	#1
    asr	w11,	w10,	#31
    lsr	w12,	w11,	#31
    add	w13,	w10,	w12
    asr	w14,	w13,	#1
    lsl	w15,	w14,	#1
    sub	w0,	w10,	w15
    sub	w12,	w3,	w0
    cmp	w0,	#0
    asr	w14,	w10,	#31
    csel	w20,	w12,	w0,	lt
    movz	w28,	#0
    str	w20,	[sp, #1192]

    lsr	w15,	w14,	#31
    add	w13,	w10,	w15
    asr	w15,	w13,	#1
    asr	w17,	w15,	#31
    lsr	w18,	w17,	#31
    add	w19,	w15,	w18
    asr	w8,	w19,	#1
    lsl	w9,	w8,	#1
    sub	w4,	w15,	w9
    sub	w18,	w28,	w4
    cmp	w4,	#0
    asr	w20,	w15,	#31
    csel	w5,	w18,	w4,	lt
    str	w5,	[sp, #1180]

    lsr	w21,	w20,	#31
    add	w19,	w15,	w21
    asr	w20,	w19,	#1
    asr	w23,	w20,	#31
    lsr	w24,	w23,	#31
    add	w25,	w20,	w24
    movz	w24,	#0
    asr	w4,	w25,	#1
    lsl	w5,	w4,	#1
    sub	w9,	w20,	w5
    sub	w23,	w24,	w9
    cmp	w9,	#0
    asr	w26,	w20,	#31
    csel	w10,	w23,	w9,	lt
    str	w10,	[sp, #1184]

    lsr	w27,	w26,	#31
    add	w25,	w20,	w27
    movz	w20,	#0
    asr	w27,	w25,	#1
    asr	w0,	w27,	#31
    lsr	w0,	w0,	#31
    add	w1,	w27,	w0
    asr	w0,	w1,	#1
    lsl	w1,	w0,	#1
    sub	w14,	w27,	w1
    sub	w28,	w20,	w14
    cmp	w14,	#0
    csel	w19,	w28,	w14,	lt
    asr	w2,	w27,	#31
    movz	w16,	#0
    str	w19,	[sp, #924]

    lsr	w3,	w2,	#31
    add	w2,	w27,	w3
    asr	w11,	w2,	#1
    asr	w5,	w11,	#31
    lsr	w6,	w5,	#31
    add	w7,	w11,	w6
    asr	w26,	w7,	#1
    lsl	w27,	w26,	#1
    sub	w21,	w11,	w27
    sub	w22,	w16,	w21
    cmp	w21,	#0
    asr	w6,	w11,	#31
    csel	w1,	w22,	w21,	lt
    movz	w12,	#0
    str	w1,	[sp, #164]

    lsr	w7,	w6,	#31
    add	w8,	w11,	w7
    asr	w2,	w8,	#1
    asr	w9,	w2,	#31
    lsr	w10,	w9,	#31
    add	w11,	w2,	w10
    asr	w13,	w11,	#1
    lsl	w14,	w13,	#1
    sub	w26,	w2,	w14
    sub	w27,	w12,	w26
    cmp	w26,	#0
    csel	w15,	w27,	w26,	lt
    asr	w12,	w2,	#31
    movz	w8,	#0
    str	w15,	[sp, #1188]

    lsr	w13,	w12,	#31
    add	w14,	w2,	w13
    asr	w3,	w14,	#1
    asr	w15,	w3,	#31
    lsr	w16,	w15,	#31
    add	w17,	w3,	w16
    asr	w9,	w17,	#1
    lsl	w10,	w9,	#1
    sub	w1,	w3,	w10
    sub	w4,	w8,	w1
    cmp	w1,	#0
    asr	w18,	w3,	#31
    csel	w25,	w4,	w1,	lt
    str	w25,	[sp, #1196]

    movz	w4,	#0
    lsr	w19,	w18,	#31
    add	w20,	w3,	w19
    asr	w7,	w20,	#1
    asr	w25,	w7,	#31
    lsr	w26,	w25,	#31
    add	w27,	w7,	w26
    asr	w14,	w27,	#1
    lsl	w15,	w14,	#1
    sub	w20,	w7,	w15
    sub	w21,	w4,	w20
    cmp	w20,	#0
    asr	w28,	w7,	#31
    csel	w8,	w21,	w20,	lt
    str	w8,	[sp, #304]

    lsr	w0,	w28,	#31
    add	w26,	w7,	w0
    movz	w0,	#0
    asr	w12,	w26,	#1
    asr	w1,	w12,	#31
    lsr	w2,	w1,	#31
    add	w3,	w12,	w2
    asr	w8,	w3,	#1
    lsl	w9,	w8,	#1
    sub	w25,	w12,	w9
    sub	w26,	w0,	w25
    cmp	w25,	#0
    csel	w24,	w26,	w25,	lt
    asr	w4,	w12,	#31
    movz	w25,	#0
    str	w24,	[sp, #520]

    lsr	w5,	w4,	#31
    add	w3,	w12,	w5
    asr	w15,	w3,	#1
    asr	w7,	w15,	#31
    lsr	w8,	w7,	#31
    add	w9,	w15,	w8
    asr	w4,	w9,	#1
    lsl	w5,	w4,	#1
    sub	w1,	w15,	w5
    sub	w0,	w25,	w1
    cmp	w1,	#0
    movz	w21,	#0
    csel	w10,	w0,	w1,	lt
    str	w10,	[sp, #508]

    asr	w10,	w15,	#31
    lsr	w11,	w10,	#31
    add	w9,	w15,	w11
    asr	w20,	w9,	#1
    asr	w13,	w20,	#31
    lsr	w14,	w13,	#31
    add	w15,	w20,	w14
    asr	w0,	w15,	#1
    lsl	w1,	w0,	#1
    sub	w4,	w20,	w1
    sub	w7,	w21,	w4
    cmp	w4,	#0
    csel	w5,	w7,	w4,	lt
    asr	w16,	w20,	#31
    str	w5,	[sp, #504]

    lsr	w17,	w16,	#31
    add	w15,	w20,	w17
    movz	w17,	#0
    asr	w27,	w15,	#1
    asr	w19,	w27,	#31
    lsr	w20,	w19,	#31
    add	w21,	w27,	w20
    asr	w24,	w21,	#1
    lsl	w25,	w24,	#1
    sub	w9,	w27,	w25
    sub	w12,	w17,	w9
    cmp	w9,	#0
    csel	w17,	w12,	w9,	lt
    asr	w22,	w27,	#31
    movz	w13,	#0
    str	w17,	[sp, #488]

    lsr	w23,	w22,	#31
    add	w21,	w27,	w23
    asr	w3,	w21,	#1
    asr	w22,	w3,	#31
    lsr	w23,	w22,	#31
    add	w24,	w3,	w23
    asr	w14,	w24,	#1
    lsl	w15,	w14,	#1
    sub	w3,	w3,	w15
    sub	w6,	w13,	w3
    cmp	w3,	#0
    csel	w5,	w6,	w3,	lt
    str	w5,	[sp, #912]

    ldr	w8,	[sp, #192]

    cmp	w8,	#0
    ldr	w6,	[sp, #200]

    cset	w2,	ne
    cmp	w6,	#0
    movz	w20,	#1
    mov	w19,	w20
    csel	w8,	w19,	w2,	ne
    str	w8,	[sp, #292]

    ldr	w9,	[sp, #192]

    cmp	w9,	#0
    ldr	w6,	[sp, #200]

    cset	w13,	ne
    mov	w14,	w13
    cmp	w6,	#0
    movz	w11,	#0
    csel	w8,	w14,	w11,	ne
    cmp	w8,	#0
    cset	w10,	eq
    cmp	w10,	#0
    ldr	w28,	[sp, #292]

    cset	w12,	ne
    cmp	w28,	#0
    movz	w18,	#0
    mov	w17,	w18
    csel	w14,	w12,	w17,	ne
    cmp	w14,	#0
    cset	w16,	ne
    cmp	w16,	#0
    ldr	w26,	[sp, #192]

    cset	w18,	ne
    cmp	w26,	#0
    ldr	w8,	[sp, #200]

    cset	w28,	ne
    mov	w0,	w28
    cmp	w8,	#0
    movz	w2,	#0
    mov	w1,	w2
    csel	w0,	w0,	w1,	ne
    cmp	w0,	#0
    ldr	w6,	[sp, #896]

    cset	w15,	ne
    cmp	w6,	#0
    ldr	w3,	[sp, #176]

    cset	w19,	ne
    mov	w20,	w19
    cmp	w3,	#0
    movz	w10,	#1
    ldr	w7,	[sp, #896]

    csel	w12,	w10,	w20,	ne
    cmp	w7,	#0
    cset	w0,	ne
    str	w0,	[sp, #296]

    ldr	w3,	[sp, #176]

    cmp	w3,	#0
    movz	w1,	#0
    ldr	w3,	[sp, #296]

    csel	w2,	w3,	w1,	ne
    cmp	w2,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w1,	ne
    mov	w2,	w1
    cmp	w12,	#0
    movz	w9,	#0
    mov	w8,	w9
    csel	w12,	w2,	w8,	ne
    str	w12,	[sp, #248]

    cmp	w15,	#0
    ldr	w13,	[sp, #248]

    cset	w3,	ne
    cmp	w13,	#0
    movz	w9,	#1
    mov	w8,	w9
    csel	w9,	w8,	w3,	ne
    str	w9,	[sp, #244]

    cmp	w15,	#0
    ldr	w12,	[sp, #248]

    cset	w17,	ne
    mov	w19,	w17
    cmp	w12,	#0
    movz	w10,	#0
    csel	w9,	w19,	w10,	ne
    cmp	w9,	#0
    cset	w11,	eq
    cmp	w11,	#0
    cset	w13,	ne
    ldr	w8,	[sp, #244]

    mov	w14,	w13
    cmp	w8,	#0
    movz	w5,	#0
    csel	w19,	w14,	w5,	ne
    str	w19,	[sp, #880]

    ldr	w8,	[sp, #896]

    cmp	w8,	#0
    ldr	w5,	[sp, #176]

    cset	w21,	ne
    mov	w22,	w21
    cmp	w5,	#0
    movz	w4,	#0
    csel	w13,	w22,	w4,	ne
    cmp	w15,	#0
    ldr	w17,	[sp, #248]

    cset	w8,	ne
    cmp	w17,	#0
    movz	w24,	#0
    mov	w23,	w24
    csel	w27,	w8,	w23,	ne
    cmp	w27,	#0
    cset	w12,	ne
    cmp	w13,	#0
    ldr	w22,	[sp, #168]

    movz	w23,	#1
    csel	w7,	w23,	w12,	ne
    cmp	w22,	#0
    cset	w16,	ne
    ldr	w26,	[sp, #172]

    cmp	w26,	#0
    ldr	w23,	[sp, #168]

    movz	w22,	#1
    mov	w21,	w22
    csel	w5,	w21,	w16,	ne
    cmp	w23,	#0
    cset	w22,	ne
    ldr	w27,	[sp, #172]

    mov	w23,	w22
    cmp	w27,	#0
    movz	w17,	#0
    csel	w20,	w23,	w17,	ne
    cmp	w20,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w0,	w28
    cmp	w5,	#0
    movz	w17,	#0
    mov	w16,	w17
    csel	w5,	w0,	w16,	ne
    cmp	w7,	#0
    cset	w2,	ne
    cmp	w5,	#0
    movz	w17,	#1
    mov	w16,	w17
    csel	w21,	w16,	w2,	ne
    cmp	w7,	#0
    cset	w3,	ne
    str	w3,	[sp, #300]

    cmp	w5,	#0
    movz	w1,	#0
    ldr	w6,	[sp, #300]

    csel	w4,	w6,	w1,	ne
    cmp	w4,	#0
    cset	w10,	eq
    cmp	w10,	#0
    cset	w12,	ne
    cmp	w21,	#0
    movz	w15,	#0
    mov	w14,	w15
    csel	w20,	w12,	w14,	ne
    str	w20,	[sp, #884]

    ldr	w24,	[sp, #168]

    cmp	w24,	#0
    ldr	w28,	[sp, #172]

    cset	w16,	ne
    mov	w17,	w16
    cmp	w28,	#0
    movz	w12,	#0
    csel	w25,	w17,	w12,	ne
    cmp	w7,	#0
    cset	w22,	ne
    mov	w23,	w22
    cmp	w5,	#0
    movz	w11,	#0
    csel	w9,	w23,	w11,	ne
    cmp	w9,	#0
    cset	w26,	ne
    cmp	w25,	#0
    ldr	w6,	[sp, #1192]

    movz	w10,	#1
    csel	w12,	w10,	w26,	ne
    cmp	w6,	#0
    ldr	w13,	[sp, #184]

    cset	w0,	ne
    cmp	w13,	#0
    ldr	w7,	[sp, #1192]

    movz	w11,	#1
    mov	w10,	w11
    csel	w0,	w10,	w0,	ne
    cmp	w7,	#0
    ldr	w14,	[sp, #184]

    cset	w4,	ne
    cmp	w14,	#0
    movz	w10,	#0
    mov	w9,	w10
    csel	w6,	w4,	w9,	ne
    cmp	w6,	#0
    cset	w8,	eq
    cmp	w8,	#0
    cset	w10,	ne
    mov	w11,	w10
    cmp	w0,	#0
    movz	w7,	#0
    csel	w2,	w11,	w7,	ne
    cmp	w12,	#0
    cset	w14,	ne
    mov	w15,	w14
    cmp	w2,	#0
    movz	w6,	#1
    csel	w4,	w6,	w15,	ne
    cmp	w12,	#0
    cset	w6,	ne
    cmp	w2,	#0
    movz	w23,	#0
    mov	w22,	w23
    csel	w10,	w6,	w22,	ne
    cmp	w10,	#0
    cset	w24,	eq
    cmp	w24,	#0
    cset	w26,	ne
    mov	w27,	w26
    cmp	w4,	#0
    movz	w4,	#0
    csel	w13,	w27,	w4,	ne
    str	w13,	[sp, #876]

    ldr	w8,	[sp, #1192]

    cmp	w8,	#0
    ldr	w15,	[sp, #184]

    cset	w0,	ne
    cmp	w15,	#0
    movz	w5,	#0
    mov	w4,	w5
    csel	w14,	w0,	w4,	ne
    cmp	w12,	#0
    cset	w4,	ne
    cmp	w2,	#0
    movz	w2,	#0
    csel	w26,	w4,	w2,	ne
    cmp	w26,	#0
    cset	w8,	ne
    cmp	w14,	#0
    ldr	w20,	[sp, #1180]

    movz	w1,	#1
    csel	w14,	w1,	w8,	ne
    cmp	w20,	#0
    ldr	w7,	[sp, #180]

    cset	w12,	ne
    mov	w13,	w12
    cmp	w7,	#0
    movz	w0,	#1
    ldr	w21,	[sp, #1180]

    csel	w11,	w0,	w13,	ne
    cmp	w21,	#0
    ldr	w8,	[sp, #180]

    cset	w16,	ne
    mov	w17,	w16
    cmp	w8,	#0
    movz	w1,	#0
    mov	w0,	w1
    csel	w20,	w17,	w0,	ne
    cmp	w20,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w24,	ne
    cmp	w11,	#0
    movz	w0,	#0
    csel	w21,	w24,	w0,	ne
    cmp	w14,	#0
    cset	w28,	ne
    mov	w0,	w28
    cmp	w21,	#0
    movz	w27,	#1
    mov	w26,	w27
    csel	w2,	w26,	w0,	ne
    cmp	w14,	#0
    cset	w22,	ne
    mov	w23,	w22
    cmp	w21,	#0
    movz	w11,	#0
    csel	w24,	w23,	w11,	ne
    cmp	w24,	#0
    cset	w6,	eq
    cmp	w6,	#0
    cset	w8,	ne
    cmp	w2,	#0
    movz	w26,	#0
    mov	w25,	w26
    csel	w10,	w8,	w25,	ne
    str	w10,	[sp, #872]

    ldr	w22,	[sp, #1180]

    cmp	w22,	#0
    ldr	w9,	[sp, #180]

    cset	w12,	ne
    cmp	w9,	#0
    movz	w25,	#0
    mov	w24,	w25
    csel	w2,	w12,	w24,	ne
    cmp	w14,	#0
    cset	w16,	ne
    cmp	w21,	#0
    movz	w24,	#0
    csel	w9,	w16,	w24,	ne
    cmp	w9,	#0
    cset	w22,	ne
    cmp	w2,	#0
    ldr	w25,	[sp, #1184]

    movz	w21,	#1
    csel	w3,	w21,	w22,	ne
    cmp	w25,	#0
    cset	w26,	ne
    ldr	w17,	[sp, #188]

    cmp	w17,	#0
    movz	w20,	#1
    csel	w9,	w20,	w26,	ne
    ldr	w26,	[sp, #1184]

    cmp	w26,	#0
    ldr	w20,	[sp, #188]

    cset	w0,	ne
    cmp	w20,	#0
    movz	w21,	#0
    mov	w20,	w21
    csel	w2,	w0,	w20,	ne
    cmp	w2,	#0
    cset	w4,	eq
    cmp	w4,	#0
    cset	w6,	ne
    cmp	w9,	#0
    movz	w19,	#0
    csel	w11,	w6,	w19,	ne
    cmp	w3,	#0
    cset	w10,	ne
    cmp	w11,	#0
    movz	w17,	#1
    mov	w16,	w17
    csel	w0,	w16,	w10,	ne
    cmp	w3,	#0
    cset	w14,	ne
    cmp	w11,	#0
    movz	w16,	#0
    mov	w15,	w16
    csel	w16,	w14,	w15,	ne
    cmp	w16,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w22,	ne
    mov	w23,	w22
    cmp	w0,	#0
    movz	w13,	#0
    csel	w7,	w23,	w13,	ne
    str	w7,	[sp, #1200]

    ldr	w27,	[sp, #1184]

    cmp	w27,	#0
    ldr	w20,	[sp, #188]

    cset	w26,	ne
    cmp	w20,	#0
    movz	w12,	#0
    csel	w20,	w26,	w12,	ne
    cmp	w3,	#0
    cset	w0,	ne
    cmp	w11,	#0
    movz	w13,	#0
    csel	w25,	w0,	w13,	ne
    cmp	w25,	#0
    cset	w4,	ne
    cmp	w20,	#0
    ldr	w10,	[sp, #924]

    movz	w12,	#1
    csel	w26,	w12,	w4,	ne
    cmp	w10,	#0
    cset	w8,	ne
    ldr	w0,	[sp, #196]

    cmp	w0,	#0
    movz	w11,	#1
    csel	w25,	w11,	w8,	ne
    ldr	w11,	[sp, #924]

    cmp	w11,	#0
    cset	w12,	ne
    ldr	w1,	[sp, #196]

    mov	w13,	w12
    cmp	w1,	#0
    movz	w8,	#0
    csel	w6,	w13,	w8,	ne
    cmp	w6,	#0
    cset	w16,	eq
    cmp	w16,	#0
    cset	w20,	ne
    cmp	w25,	#0
    movz	w7,	#0
    csel	w1,	w20,	w7,	ne
    cmp	w26,	#0
    cset	w24,	ne
    mov	w25,	w24
    cmp	w1,	#0
    movz	w6,	#1
    csel	w12,	w6,	w25,	ne
    cmp	w26,	#0
    cset	w28,	ne
    mov	w0,	w28
    cmp	w1,	#0
    movz	w6,	#0
    mov	w5,	w6
    csel	w24,	w0,	w5,	ne
    cmp	w24,	#0
    cset	w2,	eq
    cmp	w2,	#0
    cset	w4,	ne
    cmp	w12,	#0
    movz	w6,	#0
    csel	w4,	w4,	w6,	ne
    str	w4,	[sp, #232]

    ldr	w12,	[sp, #924]

    cmp	w12,	#0
    cset	w8,	ne
    ldr	w2,	[sp, #196]

    cmp	w2,	#0
    movz	w3,	#0
    csel	w5,	w8,	w3,	ne
    cmp	w26,	#0
    cset	w12,	ne
    cmp	w1,	#0
    movz	w2,	#0
    csel	w9,	w12,	w2,	ne
    cmp	w9,	#0
    cset	w16,	ne
    cmp	w5,	#0
    movz	w1,	#1
    csel	w4,	w1,	w16,	ne
    ldr	w16,	[sp, #164]

    cmp	w16,	#0
    ldr	w19,	[sp, #928]

    cset	w22,	ne
    cmp	w19,	#0
    ldr	w17,	[sp, #164]

    movz	w0,	#1
    csel	w7,	w0,	w22,	ne
    cmp	w17,	#0
    cset	w26,	ne
    ldr	w20,	[sp, #928]

    mov	w27,	w26
    cmp	w20,	#0
    movz	w1,	#0
    mov	w0,	w1
    csel	w28,	w27,	w0,	ne
    cmp	w28,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w2,	ne
    cmp	w7,	#0
    movz	w0,	#0
    csel	w0,	w2,	w0,	ne
    cmp	w4,	#0
    cset	w6,	ne
    cmp	w0,	#0
    movz	w28,	#1
    csel	w17,	w28,	w6,	ne
    cmp	w4,	#0
    cset	w10,	ne
    cmp	w0,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w12,	w10,	w26,	ne
    cmp	w12,	#0
    cset	w14,	eq
    cmp	w14,	#0
    cset	w16,	ne
    cmp	w17,	#0
    movz	w26,	#0
    csel	w1,	w16,	w26,	ne
    str	w1,	[sp, #228]

    ldr	w19,	[sp, #164]

    cmp	w19,	#0
    ldr	w21,	[sp, #928]

    cset	w22,	ne
    cmp	w21,	#0
    movz	w25,	#0
    csel	w23,	w22,	w25,	ne
    cmp	w4,	#0
    cset	w26,	ne
    cmp	w0,	#0
    movz	w22,	#0
    csel	w24,	w26,	w22,	ne
    cmp	w24,	#0
    cset	w0,	ne
    cmp	w23,	#0
    ldr	w1,	[sp, #1188]

    movz	w23,	#1
    csel	w17,	w23,	w0,	ne
    cmp	w1,	#0
    cset	w4,	ne
    ldr	w11,	[sp, #204]

    cmp	w11,	#0
    movz	w22,	#1
    ldr	w2,	[sp, #1188]

    csel	w9,	w22,	w4,	ne
    cmp	w2,	#0
    ldr	w12,	[sp, #204]

    cset	w8,	ne
    cmp	w12,	#0
    movz	w21,	#0
    csel	w10,	w8,	w21,	ne
    cmp	w10,	#0
    cset	w12,	eq
    cmp	w12,	#0
    cset	w14,	ne
    cmp	w9,	#0
    movz	w19,	#0
    csel	w21,	w14,	w19,	ne
    cmp	w17,	#0
    cset	w20,	ne
    cmp	w21,	#0
    movz	w15,	#1
    csel	w5,	w15,	w20,	ne
    cmp	w17,	#0
    cset	w24,	ne
    mov	w25,	w24
    cmp	w21,	#0
    movz	w14,	#0
    csel	w26,	w25,	w14,	ne
    cmp	w26,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w0,	ne
    cmp	w5,	#0
    movz	w15,	#0
    csel	w27,	w0,	w15,	ne
    str	w27,	[sp, #224]

    ldr	w3,	[sp, #1188]

    cmp	w3,	#0
    cset	w4,	ne
    ldr	w13,	[sp, #204]

    cmp	w13,	#0
    movz	w14,	#0
    csel	w27,	w4,	w14,	ne
    cmp	w17,	#0
    cset	w8,	ne
    cmp	w21,	#0
    movz	w13,	#0
    csel	w6,	w8,	w13,	ne
    cmp	w6,	#0
    cset	w12,	ne
    cmp	w27,	#0
    movz	w10,	#1
    ldr	w11,	[sp, #1196]

    csel	w20,	w10,	w12,	ne
    cmp	w11,	#0
    cset	w16,	ne
    ldr	w26,	[sp, #888]

    cmp	w26,	#0
    ldr	w12,	[sp, #1196]

    movz	w9,	#1
    csel	w1,	w9,	w16,	ne
    cmp	w12,	#0
    cset	w22,	ne
    ldr	w27,	[sp, #888]

    cmp	w27,	#0
    movz	w8,	#0
    csel	w24,	w22,	w8,	ne
    cmp	w24,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    cmp	w1,	#0
    movz	w7,	#0
    csel	w0,	w28,	w7,	ne
    cmp	w20,	#0
    cset	w2,	ne
    cmp	w0,	#0
    movz	w8,	#1
    csel	w4,	w8,	w2,	ne
    cmp	w20,	#0
    cset	w6,	ne
    mov	w7,	w6
    cmp	w0,	#0
    movz	w5,	#0
    csel	w8,	w7,	w5,	ne
    cmp	w8,	#0
    cset	w10,	eq
    cmp	w10,	#0
    cset	w12,	ne
    cmp	w4,	#0
    movz	w4,	#0
    csel	w24,	w12,	w4,	ne
    str	w24,	[sp, #220]

    ldr	w13,	[sp, #1196]

    cmp	w13,	#0
    cset	w16,	ne
    ldr	w28,	[sp, #888]

    cmp	w28,	#0
    movz	w3,	#0
    csel	w3,	w16,	w3,	ne
    cmp	w20,	#0
    cset	w22,	ne
    cmp	w0,	#0
    movz	w2,	#0
    csel	w22,	w22,	w2,	ne
    cmp	w22,	#0
    cset	w26,	ne
    cmp	w3,	#0
    movz	w1,	#1
    ldr	w8,	[sp, #304]

    csel	w16,	w1,	w26,	ne
    cmp	w8,	#0
    ldr	w12,	[sp, #900]

    cset	w0,	ne
    cmp	w12,	#0
    ldr	w10,	[sp, #304]

    movz	w2,	#1
    csel	w11,	w2,	w0,	ne
    cmp	w10,	#0
    ldr	w13,	[sp, #900]

    cset	w4,	ne
    cmp	w13,	#0
    movz	w1,	#0
    csel	w1,	w4,	w1,	ne
    cmp	w1,	#0
    cset	w8,	eq
    cmp	w8,	#0
    cset	w10,	ne
    cmp	w11,	#0
    movz	w0,	#0
    csel	w19,	w10,	w0,	ne
    cmp	w16,	#0
    cset	w14,	ne
    cmp	w19,	#0
    movz	w28,	#1
    csel	w6,	w28,	w14,	ne
    cmp	w16,	#0
    cset	w20,	ne
    cmp	w19,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w22,	w20,	w26,	ne
    cmp	w22,	#0
    cset	w24,	eq
    cmp	w24,	#0
    cset	w26,	ne
    cmp	w6,	#0
    movz	w24,	#0
    csel	w21,	w26,	w24,	ne
    str	w21,	[sp, #216]

    ldr	w10,	[sp, #304]

    cmp	w10,	#0
    cset	w0,	ne
    ldr	w14,	[sp, #900]

    cmp	w14,	#0
    movz	w25,	#0
    csel	w17,	w0,	w25,	ne
    cmp	w16,	#0
    cset	w4,	ne
    cmp	w19,	#0
    movz	w24,	#0
    csel	w5,	w4,	w24,	ne
    cmp	w5,	#0
    cset	w8,	ne
    cmp	w17,	#0
    ldr	w28,	[sp, #520]

    movz	w23,	#1
    csel	w23,	w23,	w8,	ne
    cmp	w28,	#0
    cset	w12,	ne
    ldr	w3,	[sp, #916]

    cmp	w3,	#0
    ldr	w0,	[sp, #520]

    movz	w22,	#1
    csel	w14,	w22,	w12,	ne
    cmp	w0,	#0
    cset	w16,	ne
    ldr	w4,	[sp, #916]

    cmp	w4,	#0
    movz	w21,	#0
    csel	w15,	w16,	w21,	ne
    cmp	w15,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w24,	ne
    cmp	w14,	#0
    movz	w16,	#0
    csel	w11,	w24,	w16,	ne
    cmp	w23,	#0
    cset	w28,	ne
    cmp	w11,	#0
    movz	w15,	#1
    csel	w0,	w15,	w28,	ne
    cmp	w23,	#0
    cset	w2,	ne
    cmp	w11,	#0
    movz	w16,	#0
    csel	w24,	w2,	w16,	ne
    cmp	w24,	#0
    cset	w6,	eq
    cmp	w6,	#0
    cset	w8,	ne
    cmp	w0,	#0
    movz	w15,	#0
    csel	w17,	w8,	w15,	ne
    str	w17,	[sp, #212]

    ldr	w1,	[sp, #520]

    cmp	w1,	#0
    cset	w12,	ne
    ldr	w5,	[sp, #916]

    cmp	w5,	#0
    movz	w14,	#0
    csel	w27,	w12,	w14,	ne
    cmp	w23,	#0
    cset	w16,	ne
    cmp	w11,	#0
    movz	w11,	#0
    csel	w20,	w16,	w11,	ne
    cmp	w20,	#0
    cset	w22,	ne
    cmp	w27,	#0
    movz	w10,	#1
    ldr	w12,	[sp, #508]

    csel	w15,	w10,	w22,	ne
    cmp	w12,	#0
    cset	w26,	ne
    ldr	w8,	[sp, #920]

    cmp	w8,	#0
    movz	w9,	#1
    ldr	w17,	[sp, #508]

    csel	w14,	w9,	w26,	ne
    cmp	w17,	#0
    cset	w0,	ne
    ldr	w10,	[sp, #920]

    cmp	w10,	#0
    movz	w10,	#0
    csel	w0,	w0,	w10,	ne
    cmp	w0,	#0
    cset	w4,	eq
    cmp	w4,	#0
    cset	w6,	ne
    cmp	w14,	#0
    movz	w9,	#0
    csel	w19,	w6,	w9,	ne
    cmp	w15,	#0
    cset	w10,	ne
    cmp	w19,	#0
    movz	w6,	#1
    csel	w16,	w6,	w10,	ne
    cmp	w15,	#0
    cset	w14,	ne
    cmp	w19,	#0
    movz	w5,	#0
    csel	w8,	w14,	w5,	ne
    cmp	w8,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w22,	ne
    cmp	w16,	#0
    movz	w4,	#0
    csel	w14,	w22,	w4,	ne
    str	w14,	[sp, #208]

    ldr	w16,	[sp, #508]

    cmp	w16,	#0
    cset	w26,	ne
    ldr	w10,	[sp, #920]

    cmp	w10,	#0
    movz	w3,	#0
    csel	w17,	w26,	w3,	ne
    cmp	w15,	#0
    cset	w0,	ne
    cmp	w19,	#0
    movz	w4,	#0
    csel	w4,	w0,	w4,	ne
    cmp	w4,	#0
    cset	w4,	ne
    cmp	w17,	#0
    ldr	w7,	[sp, #504]

    movz	w1,	#1
    csel	w27,	w1,	w4,	ne
    cmp	w7,	#0
    cset	w8,	ne
    ldr	w23,	[sp, #908]

    cmp	w23,	#0
    ldr	w12,	[sp, #504]

    movz	w0,	#1
    csel	w0,	w0,	w8,	ne
    cmp	w12,	#0
    ldr	w24,	[sp, #908]

    cset	w12,	ne
    cmp	w24,	#0
    movz	w1,	#0
    csel	w17,	w12,	w1,	ne
    cmp	w17,	#0
    cset	w16,	eq
    cmp	w16,	#0
    cset	w20,	ne
    cmp	w0,	#0
    movz	w0,	#0
    csel	w3,	w20,	w0,	ne
    cmp	w27,	#0
    cset	w24,	ne
    cmp	w3,	#0
    movz	w28,	#1
    csel	w22,	w28,	w24,	ne
    cmp	w27,	#0
    cset	w0,	ne
    cmp	w3,	#0
    movz	w25,	#0
    csel	w2,	w0,	w25,	ne
    cmp	w2,	#0
    cset	w2,	eq
    cmp	w2,	#0
    cset	w4,	ne
    cmp	w22,	#0
    movz	w26,	#0
    ldr	w17,	[sp, #504]

    csel	w1,	w4,	w26,	ne
    cmp	w17,	#0
    ldr	w2,	[sp, #908]

    cset	w9,	ne
    cmp	w2,	#0
    movz	w26,	#0
    csel	w14,	w9,	w26,	ne
    cmp	w27,	#0
    cset	w13,	ne
    cmp	w3,	#0
    movz	w25,	#0
    csel	w22,	w13,	w25,	ne
    cmp	w22,	#0
    cset	w17,	ne
    cmp	w14,	#0
    ldr	w23,	[sp, #488]

    movz	w24,	#1
    csel	w27,	w24,	w17,	ne
    cmp	w23,	#0
    cset	w23,	ne
    ldr	w22,	[sp, #904]

    cmp	w22,	#0
    ldr	w26,	[sp, #488]

    movz	w21,	#1
    csel	w8,	w21,	w23,	ne
    cmp	w26,	#0
    ldr	w23,	[sp, #904]

    cset	w28,	ne
    cmp	w23,	#0
    movz	w19,	#0
    csel	w4,	w28,	w19,	ne
    cmp	w4,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w3,	ne
    cmp	w8,	#0
    movz	w20,	#0
    csel	w20,	w3,	w20,	ne
    cmp	w27,	#0
    cset	w7,	ne
    cmp	w20,	#0
    movz	w19,	#1
    csel	w9,	w19,	w7,	ne
    cmp	w27,	#0
    cset	w11,	ne
    cmp	w20,	#0
    movz	w16,	#0
    csel	w25,	w11,	w16,	ne
    cmp	w25,	#0
    cset	w15,	eq
    cmp	w15,	#0
    cset	w17,	ne
    cmp	w9,	#0
    movz	w14,	#0
    ldr	w12,	[sp, #488]

    csel	w11,	w17,	w14,	ne
    cmp	w12,	#0
    cset	w24,	ne
    ldr	w25,	[sp, #904]

    cmp	w25,	#0
    movz	w13,	#0
    csel	w5,	w24,	w13,	ne
    cmp	w27,	#0
    cset	w27,	ne
    cmp	w20,	#0
    movz	w12,	#0
    csel	w4,	w27,	w12,	ne
    cmp	w4,	#0
    cset	w0,	ne
    cmp	w5,	#0
    movz	w13,	#1
    ldr	w28,	[sp, #912]

    csel	w4,	w13,	w0,	ne
    cmp	w28,	#0
    cset	w5,	ne
    ldr	w8,	[sp, #892]

    cmp	w8,	#0
    movz	w12,	#1
    ldr	w0,	[sp, #912]

    csel	w25,	w12,	w5,	ne
    cmp	w0,	#0
    cset	w9,	ne
    ldr	w8,	[sp, #892]

    cmp	w8,	#0
    movz	w10,	#0
    csel	w28,	w9,	w10,	ne
    cmp	w28,	#0
    cset	w13,	eq
    cmp	w13,	#0
    cset	w15,	ne
    cmp	w25,	#0
    movz	w8,	#0
    csel	w0,	w15,	w8,	ne
    cmp	w4,	#0
    cset	w22,	ne
    cmp	w0,	#0
    movz	w7,	#1
    csel	w5,	w7,	w22,	ne
    cmp	w4,	#0
    cset	w25,	ne
    cmp	w0,	#0
    movz	w6,	#0
    csel	w7,	w25,	w6,	ne
    cmp	w7,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w0,	ne
    cmp	w5,	#0
    ldr	w15,	[sp, #208]

    movz	w7,	#0
    ldr	w19,	[sp, #212]

    csel	w13,	w0,	w7,	ne
    ldr	w22,	[sp, #216]

    lsl	w14,	w13,	#1
    ldr	w25,	[sp, #220]

    add	w12,	w14,	w11
    ldr	w28,	[sp, #224]

    ldr	w2,	[sp, #228]

    ldr	w5,	[sp, #232]

    lsl	w13,	w12,	#1
    add	w6,	w13,	w1
    lsl	w7,	w6,	#1
    add	w8,	w7,	w15
    lsl	w9,	w8,	#1
    ldr	w8,	[sp, #1200]

    add	w10,	w9,	w19
    lsl	w11,	w10,	#1
    add	w12,	w11,	w22
    ldr	w11,	[sp, #872]

    lsl	w13,	w12,	#1
    add	w14,	w13,	w25
    lsl	w15,	w14,	#1
    ldr	w14,	[sp, #876]

    add	w16,	w15,	w28
    ldr	w21,	[sp, #884]

    ldr	w17,	[sp, #880]

    lsl	w19,	w16,	#1
    add	w20,	w19,	w2
    lsl	w22,	w20,	#1
    add	w22,	w22,	w5
    lsl	w24,	w22,	#1
    add	w24,	w24,	w8
    lsl	w26,	w24,	#1
    add	w26,	w26,	w11
    lsl	w28,	w26,	#1
    add	w28,	w28,	w14
    lsl	w1,	w28,	#1
    add	w0,	w1,	w21
    lsl	w1,	w0,	#1
    add	w2,	w1,	w17
    lsl	w3,	w2,	#1
    add	w0,	w3,	w18

fib_1892:
    movz	w17,	#1
    ldr	x16,	[sp, #464]

    str	w17,	[x16]

    ldr	x12,	[sp, #456]

    ldr	w17,	[sp, #308]

    str	w17,	[x12]

    ldr	x11,	[sp, #472]

    add	x8,	x11,	#4
    str	w0,	[x8]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #1216
    ret


fib_21:
    ldr	x11,	[sp, #472]

    add	x8,	x11,	#4
    ldr	w0,	[x8]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #1216
    ret


.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    movz	w20,	#1

main_1:
    cmp	w20,	#16
    blt	main_4

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
    add	w26,	w20,	#1
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w26
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w26
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w28,	w26,	#1
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w28
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w28
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w20,	w28,	#1
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
    add	w22,	w20,	#1
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w22
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w22
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#102
    add	w24,	w22,	#1
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w24
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w24
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w26,	w24,	#1
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w26
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w26
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#102
    add	w28,	w26,	#1
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w28
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w28
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w20,	w28,	#1
    b	main_1

