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
    
    movz	x5,	#40763
    movz	x6,	#40763
    adrp	x12, :got:memo.lut.fib
    mov	w24,	w0
    movz	x27,	#65535
    movk	x5,	#1117,	lsl #16
    movk	x6,	#1117,	lsl #16
    lsr	w9,	w24,	#16
    eor	w1,	w24,	w9
    mul	w2,	w1,	w6
    lsr	w13,	w2,	#16
    eor	w4,	w2,	w13
    mul	w15,	w4,	w5
    lsr	w6,	w15,	#16
    eor	w13,	w15,	w6
    str	w13,	[sp, #280]

    ldr	w13,	[sp, #280]

    ldr	x12, [x12, #:got_lo12:memo.lut.fib]
    and	w17,	w13,	w27
    lsl	w18,	w17,	#3
    lsl	w21,	w18,	#0
    add	x7,	x12,	x21
    str	x7,	[sp, #272]

    ldr	x3,	[sp, #272]

    str	x3,	[sp, #264]

    ldr	x4,	[sp, #264]

    ldr	w10,	[x4]

    ldr	x9,	[sp, #272]

    add	x0,	x9,	#8
    cmp	w10,	#0
    beq	fib_25

fib_17:
    ldr	w13,	[x0]

    ldr	w17,	[sp, #280]

    cmp	w13,	w17
    bne	fib_27

fib_21:
    ldr	x10,	[sp, #272]

    add	x1,	x10,	#4
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
    str	x0,	[sp, #256]

    b	fib_28

fib_25:
    str	x0,	[sp, #256]


fib_28:
    cmp	w24,	#2
    ble	fib_1891

fib_31:
    asr	w23,	w24,	#31
    movz	w21,	#0
    lsr	w0,	w23,	#31
    add	w25,	w24,	w0
    asr	w22,	w25,	#1
    lsl	w23,	w22,	#1
    sub	w28,	w24,	w23
    str	w28,	[sp, #232]

    ldr	w0,	[sp, #232]

    sub	w18,	w21,	w0
    str	w18,	[sp, #500]

    ldr	w18,	[sp, #232]

    cmp	w18,	#0
    ldr	w21,	[sp, #500]

    asr	w26,	w24,	#31
    ldr	w20,	[sp, #232]

    lsr	w27,	w26,	#31
    csel	w28,	w21,	w20,	lt
    movz	w26,	#0
    str	w28,	[sp, #808]

    add	w28,	w24,	w27
    asr	w28,	w28,	#1
    asr	w0,	w28,	#31
    lsr	w19,	w0,	#31
    add	w20,	w28,	w19
    asr	w0,	w20,	#1
    lsl	w19,	w0,	#1
    sub	w20,	w28,	w19
    str	w20,	[sp, #240]

    ldr	w23,	[sp, #240]

    sub	w26,	w26,	w23
    str	w26,	[sp, #516]

    ldr	w22,	[sp, #240]

    cmp	w22,	#0
    ldr	w19,	[sp, #516]

    asr	w20,	w28,	#31
    ldr	w23,	[sp, #240]

    lsr	w21,	w20,	#31
    csel	w25,	w19,	w23,	lt
    str	w25,	[sp, #812]

    add	w0,	w28,	w21
    asr	w26,	w0,	#1
    movz	w0,	#0
    asr	w23,	w26,	#31
    lsr	w24,	w23,	#31
    add	w25,	w26,	w24
    asr	w23,	w25,	#1
    lsl	w24,	w23,	#1
    sub	w25,	w26,	w24
    str	w25,	[sp, #244]

    ldr	w18,	[sp, #244]

    sub	w25,	w0,	w18
    str	w25,	[sp, #188]

    ldr	w27,	[sp, #244]

    cmp	w27,	#0
    ldr	w20,	[sp, #188]

    ldr	w28,	[sp, #244]

    csel	w18,	w20,	w28,	lt
    str	w18,	[sp, #1016]

    asr	w28,	w26,	#31
    lsr	w0,	w28,	#31
    add	w19,	w26,	w0
    asr	w19,	w19,	#1
    asr	w20,	w19,	#31
    lsr	w21,	w20,	#31
    movz	w20,	#0
    add	w22,	w19,	w21
    asr	w22,	w22,	#1
    lsl	w23,	w22,	#1
    sub	w23,	w19,	w23
    str	w23,	[sp, #252]

    ldr	w0,	[sp, #252]

    sub	w24,	w20,	w0
    str	w24,	[sp, #200]

    ldr	w25,	[sp, #252]

    cmp	w25,	#0
    ldr	w20,	[sp, #200]

    ldr	w26,	[sp, #252]

    csel	w20,	w20,	w26,	lt
    str	w20,	[sp, #1028]

    asr	w26,	w19,	#31
    lsr	w27,	w26,	#31
    movz	w26,	#0
    add	w0,	w19,	w27
    asr	w24,	w0,	#1
    asr	w27,	w24,	#31
    lsr	w28,	w27,	#31
    add	w0,	w24,	w28
    asr	w19,	w0,	#1
    lsl	w20,	w19,	#1
    sub	w19,	w24,	w20
    str	w19,	[sp, #248]

    ldr	w20,	[sp, #248]

    sub	w0,	w26,	w20
    str	w0,	[sp, #212]

    ldr	w0,	[sp, #248]

    cmp	w0,	#0
    asr	w28,	w24,	#31
    ldr	w20,	[sp, #212]

    ldr	w19,	[sp, #248]

    csel	w0,	w20,	w19,	lt
    str	w0,	[sp, #816]

    lsr	w0,	w28,	#31
    add	w20,	w24,	w0
    asr	w26,	w20,	#1
    asr	w21,	w26,	#31
    lsr	w23,	w21,	#31
    add	w25,	w26,	w23
    asr	w21,	w25,	#1
    lsl	w23,	w21,	#1
    sub	w0,	w26,	w23
    str	w0,	[sp, #236]

    movz	w0,	#0
    ldr	w21,	[sp, #236]

    sub	w21,	w0,	w21
    str	w21,	[sp, #224]

    ldr	w19,	[sp, #236]

    cmp	w19,	#0
    ldr	w23,	[sp, #224]

    asr	w27,	w26,	#31
    movz	w0,	#0
    ldr	w20,	[sp, #236]

    csel	w28,	w23,	w20,	lt
    str	w28,	[sp, #904]

    lsr	w28,	w27,	#31
    add	w20,	w26,	w28
    asr	w27,	w20,	#1
    asr	w21,	w27,	#31
    lsr	w23,	w21,	#31
    add	w25,	w27,	w23
    asr	w25,	w25,	#1
    lsl	w26,	w25,	#1
    sub	w28,	w27,	w26
    str	w28,	[sp, #228]

    ldr	w20,	[sp, #228]

    sub	w21,	w0,	w20
    str	w21,	[sp, #216]

    ldr	w19,	[sp, #228]

    cmp	w19,	#0
    asr	w21,	w27,	#31
    ldr	w23,	[sp, #216]

    ldr	w0,	[sp, #228]

    csel	w20,	w23,	w0,	lt
    lsr	w23,	w21,	#31
    str	w20,	[sp, #896]

    add	w26,	w27,	w23
    asr	w26,	w26,	#1
    str	w26,	[sp, #852]

    ldr	w27,	[sp, #852]

    movz	w26,	#0
    asr	w27,	w27,	#31
    ldr	w28,	[sp, #852]

    mov	w21,	w26
    lsr	w0,	w27,	#31
    add	w27,	w28,	w0
    ldr	w0,	[sp, #852]

    asr	w23,	w27,	#1
    lsl	w19,	w23,	#1
    sub	w28,	w0,	w19
    str	w28,	[sp, #220]

    ldr	w0,	[sp, #220]

    sub	w23,	w21,	w0
    str	w23,	[sp, #204]

    ldr	w19,	[sp, #220]

    cmp	w19,	#0
    ldr	w24,	[sp, #204]

    ldr	w0,	[sp, #220]

    csel	w28,	w24,	w0,	lt
    str	w28,	[sp, #892]

    ldr	w18,	[sp, #852]

    asr	w28,	w18,	#31
    ldr	w19,	[sp, #852]

    lsr	w24,	w28,	#31
    add	w21,	w19,	w24
    asr	w21,	w21,	#1
    asr	w23,	w21,	#31
    lsr	w26,	w23,	#31
    add	w27,	w21,	w26
    asr	w27,	w27,	#1
    lsl	w28,	w27,	#1
    movz	w27,	#0
    sub	w23,	w21,	w28
    mov	w0,	w27
    str	w23,	[sp, #208]

    ldr	w23,	[sp, #208]

    sub	w27,	w0,	w23
    str	w27,	[sp, #192]

    ldr	w26,	[sp, #208]

    cmp	w26,	#0
    ldr	w28,	[sp, #192]

    asr	w0,	w21,	#31
    ldr	w23,	[sp, #208]

    lsr	w27,	w0,	#31
    csel	w24,	w28,	w23,	lt
    str	w24,	[sp, #900]

    add	w28,	w21,	w27
    asr	w19,	w28,	#1
    asr	w20,	w19,	#31
    lsr	w0,	w20,	#31
    add	w0,	w19,	w0
    asr	w0,	w0,	#1
    lsl	w20,	w0,	#1
    sub	w0,	w19,	w20
    str	w0,	[sp, #196]

    ldr	w27,	[sp, #196]

    movz	w0,	#0
    mov	w21,	w0
    sub	w21,	w21,	w27
    str	w21,	[sp, #524]

    ldr	w20,	[sp, #196]

    cmp	w20,	#0
    ldr	w23,	[sp, #524]

    asr	w20,	w19,	#31
    ldr	w21,	[sp, #196]

    lsr	w24,	w20,	#31
    csel	w0,	w23,	w21,	lt
    str	w0,	[sp, #552]

    add	w0,	w19,	w24
    asr	w26,	w0,	#1
    asr	w27,	w26,	#31
    lsr	w28,	w27,	#31
    add	w20,	w26,	w28
    asr	w27,	w20,	#1
    lsl	w28,	w27,	#1
    sub	w27,	w26,	w28
    str	w27,	[sp, #528]

    ldr	w28,	[sp, #528]

    movz	w27,	#0
    mov	w0,	w27
    sub	w19,	w0,	w28
    str	w19,	[sp, #512]

    ldr	w0,	[sp, #528]

    cmp	w0,	#0
    ldr	w27,	[sp, #512]

    movz	w28,	#0
    ldr	w0,	[sp, #528]

    mov	w21,	w28
    csel	w27,	w27,	w0,	lt
    str	w27,	[sp, #672]

    asr	w0,	w26,	#31
    lsr	w19,	w0,	#31
    add	w26,	w26,	w19
    asr	w25,	w26,	#1
    asr	w24,	w25,	#31
    lsr	w26,	w24,	#31
    add	w19,	w25,	w26
    asr	w24,	w19,	#1
    lsl	w26,	w24,	#1
    sub	w26,	w25,	w26
    str	w26,	[sp, #520]

    ldr	w28,	[sp, #520]

    sub	w19,	w21,	w28
    str	w19,	[sp, #504]

    ldr	w28,	[sp, #520]

    cmp	w28,	#0
    ldr	w0,	[sp, #504]

    ldr	w20,	[sp, #520]

    csel	w24,	w0,	w20,	lt
    str	w24,	[sp, #152]

    asr	w0,	w25,	#31
    lsr	w0,	w0,	#31
    add	w21,	w25,	w0
    asr	w26,	w21,	#1
    asr	w23,	w26,	#31
    lsr	w24,	w23,	#31
    add	w25,	w26,	w24
    asr	w0,	w25,	#1
    lsl	w0,	w0,	#1
    sub	w20,	w26,	w0
    str	w20,	[sp, #508]

    movz	w20,	#0
    ldr	w24,	[sp, #508]

    mov	w0,	w20
    sub	w24,	w0,	w24
    str	w24,	[sp, #492]

    ldr	w23,	[sp, #508]

    cmp	w23,	#0
    asr	w19,	w26,	#31
    movz	w21,	#0
    ldr	w25,	[sp, #492]

    ldr	w24,	[sp, #508]

    csel	w0,	w25,	w24,	lt
    str	w0,	[sp, #168]

    lsr	w0,	w19,	#31
    add	w28,	w26,	w0
    asr	w27,	w28,	#1
    asr	w19,	w27,	#31
    lsr	w24,	w19,	#31
    add	w25,	w27,	w24
    asr	w24,	w25,	#1
    lsl	w25,	w24,	#1
    sub	w19,	w27,	w25
    str	w19,	[sp, #496]

    ldr	w0,	[sp, #496]

    sub	w25,	w21,	w0
    str	w25,	[sp, #484]

    ldr	w0,	[sp, #496]

    cmp	w0,	#0
    ldr	w26,	[sp, #484]

    asr	w0,	w27,	#31
    ldr	w19,	[sp, #496]

    csel	w24,	w26,	w19,	lt
    str	w24,	[sp, #440]

    lsr	w19,	w0,	#31
    add	w0,	w27,	w19
    asr	w28,	w0,	#1
    asr	w0,	w28,	#31
    lsr	w19,	w0,	#31
    add	w23,	w28,	w19
    asr	w19,	w23,	#1
    movz	w23,	#0
    lsl	w0,	w19,	#1
    sub	w19,	w28,	w0
    mov	w0,	w23
    str	w19,	[sp, #488]

    ldr	w19,	[sp, #488]

    sub	w25,	w0,	w19
    str	w25,	[sp, #476]

    ldr	w0,	[sp, #488]

    cmp	w0,	#0
    ldr	w27,	[sp, #476]

    asr	w25,	w28,	#31
    ldr	w19,	[sp, #488]

    lsr	w0,	w25,	#31
    csel	w19,	w27,	w19,	lt
    str	w19,	[sp, #460]

    add	w26,	w28,	w0
    asr	w20,	w26,	#1
    asr	w27,	w20,	#31
    lsr	w0,	w27,	#31
    add	w27,	w20,	w0
    asr	w23,	w27,	#1
    lsl	w26,	w23,	#1
    sub	w28,	w20,	w26
    movz	w26,	#0
    mov	w21,	w26
    str	w28,	[sp, #480]

    ldr	w0,	[sp, #480]

    sub	w21,	w21,	w0
    str	w21,	[sp, #472]

    ldr	w19,	[sp, #480]

    cmp	w19,	#0
    ldr	w23,	[sp, #472]

    ldr	w19,	[sp, #480]

    csel	w27,	w23,	w19,	lt
    str	w27,	[sp, #456]

    ldr	w22,	[sp, #808]

    cmp	w22,	#0
    cset	w27,	ne
    cmp	w27,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w23,	#0
    cset	w26,	ne
    mov	w27,	w26
    cmp	w27,	#0
    cset	w27,	ne
    mov	w24,	w27
    str	w24,	[sp, #464]

    ldr	w23,	[sp, #808]

    cmp	w23,	#0
    cset	w20,	ne
    mov	w21,	w20
    cmp	w21,	#0
    cset	w23,	ne
    mov	w25,	w23
    str	w25,	[sp, #1036]

    ldr	w26,	[sp, #812]

    cmp	w26,	#0
    cset	w27,	ne
    cmp	w27,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    cset	w21,	ne
    mov	w28,	w21
    str	w28,	[sp, #96]

    ldr	w26,	[sp, #1036]

    cmp	w26,	#0
    cset	w26,	ne
    mov	w27,	w26
    ldr	w26,	[sp, #96]

    cmp	w26,	#0
    movz	w0,	#1
    mov	w19,	w0
    csel	w0,	w19,	w27,	ne
    ldr	w27,	[sp, #1036]

    cmp	w27,	#0
    cset	w20,	ne
    mov	w27,	w20
    str	w27,	[sp, #108]

    ldr	w19,	[sp, #96]

    cmp	w19,	#0
    movz	w27,	#0
    mov	w21,	w27
    ldr	w27,	[sp, #108]

    csel	w20,	w27,	w21,	ne
    cmp	w20,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w0,	#0
    movz	w19,	#0
    csel	w23,	w20,	w19,	ne
    str	w23,	[sp, #448]

    ldr	w27,	[sp, #812]

    cmp	w27,	#0
    cset	w26,	ne
    ldr	w21,	[sp, #1036]

    mov	w24,	w26
    cmp	w21,	#0
    ldr	w23,	[sp, #96]

    cset	w27,	ne
    mov	w20,	w27
    cmp	w23,	#0
    movz	w28,	#0
    mov	w23,	w28
    csel	w19,	w20,	w23,	ne
    cmp	w19,	#0
    cset	w23,	ne
    mov	w26,	w23
    cmp	w24,	#0
    movz	w24,	#1
    csel	w24,	w24,	w26,	ne
    str	w24,	[sp, #1008]

    ldr	w19,	[sp, #1016]

    cmp	w19,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w20,	#0
    cset	w21,	eq
    mov	w23,	w21
    cmp	w23,	#0
    ldr	w28,	[sp, #1008]

    cset	w26,	ne
    mov	w23,	w26
    cmp	w28,	#0
    cset	w0,	ne
    mov	w19,	w0
    cmp	w23,	#0
    ldr	w0,	[sp, #1008]

    movz	w24,	#1
    mov	w28,	w24
    csel	w20,	w28,	w19,	ne
    cmp	w0,	#0
    cset	w24,	ne
    mov	w21,	w24
    str	w21,	[sp, #668]

    cmp	w23,	#0
    movz	w19,	#0
    ldr	w27,	[sp, #668]

    csel	w19,	w27,	w19,	ne
    cmp	w19,	#0
    cset	w19,	eq
    mov	w24,	w19
    cmp	w24,	#0
    cset	w25,	ne
    cmp	w20,	#0
    movz	w0,	#0
    csel	w20,	w25,	w0,	ne
    str	w20,	[sp, #180]

    ldr	w24,	[sp, #1016]

    cmp	w24,	#0
    ldr	w0,	[sp, #1008]

    cset	w27,	ne
    mov	w26,	w27
    cmp	w0,	#0
    cset	w19,	ne
    mov	w20,	w19
    cmp	w23,	#0
    movz	w28,	#0
    mov	w27,	w28
    csel	w27,	w20,	w27,	ne
    cmp	w27,	#0
    cset	w24,	ne
    mov	w25,	w24
    cmp	w26,	#0
    movz	w20,	#1
    mov	w26,	w20
    csel	w22,	w26,	w25,	ne
    str	w22,	[sp, #1020]

    ldr	w21,	[sp, #1028]

    cmp	w21,	#0
    cset	w18,	ne
    mov	w19,	w18
    cmp	w19,	#0
    cset	w23,	eq
    mov	w24,	w23
    cmp	w24,	#0
    cset	w25,	ne
    mov	w27,	w25
    str	w27,	[sp, #1024]

    ldr	w23,	[sp, #1020]

    cmp	w23,	#0
    ldr	w20,	[sp, #1024]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w20,	#0
    movz	w28,	#1
    mov	w20,	w28
    csel	w28,	w20,	w24,	ne
    ldr	w24,	[sp, #1020]

    cmp	w24,	#0
    cset	w24,	ne
    ldr	w21,	[sp, #1024]

    mov	w25,	w24
    cmp	w21,	#0
    movz	w26,	#0
    mov	w21,	w26
    csel	w0,	w25,	w21,	ne
    cmp	w0,	#0
    cset	w18,	eq
    mov	w19,	w18
    cmp	w19,	#0
    cset	w23,	ne
    mov	w20,	w23
    cmp	w28,	#0
    movz	w18,	#0
    mov	w0,	w18
    csel	w23,	w20,	w0,	ne
    str	w23,	[sp, #144]

    ldr	w22,	[sp, #1028]

    cmp	w22,	#0
    cset	w27,	ne
    ldr	w0,	[sp, #1020]

    mov	w18,	w27
    cmp	w0,	#0
    ldr	w23,	[sp, #1024]

    cset	w0,	ne
    mov	w27,	w0
    cmp	w23,	#0
    movz	w0,	#0
    mov	w24,	w0
    csel	w24,	w27,	w24,	ne
    cmp	w24,	#0
    cset	w24,	ne
    mov	w27,	w24
    cmp	w18,	#0
    movz	w25,	#1
    mov	w23,	w25
    csel	w21,	w23,	w27,	ne
    str	w21,	[sp, #556]

    ldr	w18,	[sp, #816]

    cmp	w18,	#0
    cset	w20,	ne
    mov	w21,	w20
    cmp	w21,	#0
    cset	w23,	eq
    mov	w24,	w23
    cmp	w24,	#0
    cset	w27,	ne
    ldr	w23,	[sp, #556]

    mov	w28,	w27
    cmp	w23,	#0
    cset	w19,	ne
    mov	w22,	w19
    cmp	w28,	#0
    movz	w19,	#1
    mov	w21,	w19
    csel	w19,	w21,	w22,	ne
    str	w19,	[sp, #908]

    ldr	w24,	[sp, #556]

    cmp	w24,	#0
    cset	w25,	ne
    mov	w0,	w25
    cmp	w28,	#0
    movz	w26,	#0
    mov	w22,	w26
    csel	w23,	w0,	w22,	ne
    cmp	w23,	#0
    cset	w22,	eq
    mov	w23,	w22
    cmp	w23,	#0
    cset	w24,	ne
    ldr	w26,	[sp, #908]

    mov	w18,	w24
    cmp	w26,	#0
    movz	w25,	#0
    mov	w19,	w25
    csel	w23,	w18,	w19,	ne
    str	w23,	[sp, #132]

    ldr	w26,	[sp, #816]

    cmp	w26,	#0
    ldr	w23,	[sp, #556]

    cset	w19,	ne
    mov	w21,	w19
    cmp	w23,	#0
    cset	w23,	ne
    mov	w24,	w23
    cmp	w28,	#0
    movz	w23,	#0
    mov	w0,	w23
    csel	w24,	w24,	w0,	ne
    cmp	w24,	#0
    cset	w28,	ne
    mov	w0,	w28
    cmp	w21,	#0
    movz	w25,	#1
    csel	w23,	w25,	w0,	ne
    str	w23,	[sp, #912]

    ldr	w0,	[sp, #904]

    cmp	w0,	#0
    cset	w23,	ne
    mov	w24,	w23
    cmp	w24,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w0,	ne
    mov	w22,	w0
    str	w22,	[sp, #884]

    ldr	w24,	[sp, #912]

    cmp	w24,	#0
    ldr	w25,	[sp, #884]

    cset	w21,	ne
    mov	w23,	w21
    cmp	w25,	#0
    ldr	w25,	[sp, #912]

    movz	w0,	#1
    mov	w24,	w0
    csel	w19,	w24,	w23,	ne
    cmp	w25,	#0
    ldr	w26,	[sp, #884]

    cset	w28,	ne
    mov	w0,	w28
    cmp	w26,	#0
    movz	w18,	#0
    mov	w23,	w18
    csel	w23,	w0,	w23,	ne
    cmp	w23,	#0
    cset	w23,	eq
    mov	w24,	w23
    cmp	w24,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w19,	#0
    movz	w19,	#0
    csel	w28,	w28,	w19,	ne
    str	w28,	[sp, #652]

    ldr	w18,	[sp, #904]

    cmp	w18,	#0
    ldr	w26,	[sp, #912]

    cset	w21,	ne
    mov	w0,	w21
    cmp	w26,	#0
    ldr	w22,	[sp, #884]

    cset	w24,	ne
    mov	w27,	w24
    cmp	w22,	#0
    movz	w22,	#0
    mov	w18,	w22
    csel	w24,	w27,	w18,	ne
    cmp	w24,	#0
    cset	w20,	ne
    mov	w21,	w20
    cmp	w0,	#0
    movz	w23,	#1
    mov	w26,	w23
    csel	w26,	w26,	w21,	ne
    str	w26,	[sp, #560]

    ldr	w21,	[sp, #896]

    cmp	w21,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w28,	#0
    cset	w0,	eq
    mov	w20,	w0
    cmp	w20,	#0
    cset	w21,	ne
    mov	w24,	w21
    str	w24,	[sp, #876]

    ldr	w27,	[sp, #560]

    cmp	w27,	#0
    cset	w24,	ne
    ldr	w25,	[sp, #876]

    mov	w27,	w24
    cmp	w25,	#0
    movz	w24,	#1
    ldr	w28,	[sp, #560]

    csel	w24,	w24,	w27,	ne
    cmp	w28,	#0
    ldr	w27,	[sp, #876]

    cset	w20,	ne
    mov	w21,	w20
    cmp	w27,	#0
    movz	w26,	#0
    mov	w23,	w26
    csel	w23,	w21,	w23,	ne
    cmp	w23,	#0
    cset	w27,	eq
    mov	w28,	w27
    cmp	w28,	#0
    cset	w0,	ne
    mov	w20,	w0
    cmp	w24,	#0
    movz	w0,	#0
    mov	w19,	w0
    csel	w28,	w20,	w19,	ne
    str	w28,	[sp, #916]

    ldr	w22,	[sp, #896]

    cmp	w22,	#0
    cset	w24,	ne
    ldr	w19,	[sp, #560]

    mov	w27,	w24
    cmp	w19,	#0
    ldr	w22,	[sp, #876]

    cset	w28,	ne
    mov	w0,	w28
    cmp	w22,	#0
    movz	w19,	#0
    csel	w23,	w0,	w19,	ne
    cmp	w23,	#0
    cset	w23,	ne
    mov	w24,	w23
    cmp	w27,	#0
    movz	w22,	#1
    mov	w18,	w22
    csel	w19,	w18,	w24,	ne
    str	w19,	[sp, #564]

    ldr	w0,	[sp, #892]

    cmp	w0,	#0
    cset	w0,	ne
    mov	w20,	w0
    cmp	w20,	#0
    cset	w21,	eq
    mov	w23,	w21
    cmp	w23,	#0
    cset	w24,	ne
    mov	w0,	w24
    str	w0,	[sp, #880]

    ldr	w20,	[sp, #564]

    cmp	w20,	#0
    ldr	w20,	[sp, #880]

    cset	w28,	ne
    mov	w0,	w28
    cmp	w20,	#0
    movz	w24,	#1
    ldr	w21,	[sp, #564]

    mov	w26,	w24
    csel	w28,	w26,	w0,	ne
    cmp	w21,	#0
    cset	w23,	ne
    ldr	w20,	[sp, #880]

    mov	w24,	w23
    cmp	w20,	#0
    movz	w25,	#0
    csel	w23,	w24,	w25,	ne
    cmp	w23,	#0
    cset	w0,	eq
    mov	w20,	w0
    cmp	w20,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w28,	#0
    movz	w0,	#0
    mov	w24,	w0
    csel	w25,	w23,	w24,	ne
    str	w25,	[sp, #888]

    ldr	w18,	[sp, #892]

    cmp	w18,	#0
    ldr	w25,	[sp, #564]

    cset	w28,	ne
    mov	w22,	w28
    cmp	w25,	#0
    ldr	w28,	[sp, #880]

    cset	w20,	ne
    mov	w21,	w20
    cmp	w28,	#0
    movz	w0,	#0
    mov	w19,	w0
    csel	w24,	w21,	w19,	ne
    cmp	w24,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w22,	#0
    movz	w19,	#1
    csel	w19,	w19,	w28,	ne
    str	w19,	[sp, #544]

    ldr	w25,	[sp, #900]

    cmp	w25,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w23,	#0
    cset	w24,	eq
    mov	w27,	w24
    cmp	w27,	#0
    cset	w28,	ne
    mov	w27,	w28
    str	w27,	[sp, #716]

    ldr	w20,	[sp, #544]

    cmp	w20,	#0
    ldr	w18,	[sp, #716]

    cset	w20,	ne
    mov	w21,	w20
    cmp	w18,	#0
    movz	w19,	#1
    mov	w0,	w19
    csel	w20,	w0,	w21,	ne
    ldr	w21,	[sp, #544]

    cmp	w21,	#0
    ldr	w19,	[sp, #716]

    cset	w27,	ne
    mov	w28,	w27
    cmp	w19,	#0
    movz	w23,	#0
    mov	w25,	w23
    csel	w24,	w28,	w25,	ne
    cmp	w24,	#0
    cset	w21,	eq
    mov	w23,	w21
    cmp	w23,	#0
    cset	w24,	ne
    mov	w27,	w24
    cmp	w20,	#0
    movz	w24,	#0
    csel	w22,	w27,	w24,	ne
    str	w22,	[sp, #832]

    ldr	w26,	[sp, #900]

    cmp	w26,	#0
    cset	w20,	ne
    ldr	w22,	[sp, #544]

    mov	w28,	w20
    cmp	w22,	#0
    ldr	w27,	[sp, #716]

    cset	w23,	ne
    mov	w24,	w23
    cmp	w27,	#0
    movz	w0,	#0
    mov	w23,	w0
    csel	w23,	w24,	w23,	ne
    cmp	w23,	#0
    cset	w0,	ne
    mov	w20,	w0
    cmp	w28,	#0
    movz	w0,	#1
    mov	w19,	w0
    csel	w24,	w19,	w20,	ne
    str	w24,	[sp, #548]

    ldr	w18,	[sp, #552]

    cmp	w18,	#0
    cset	w24,	ne
    mov	w27,	w24
    cmp	w27,	#0
    cset	w28,	eq
    mov	w0,	w28
    cmp	w0,	#0
    cset	w20,	ne
    str	w20,	[sp, #720]

    ldr	w25,	[sp, #548]

    cmp	w25,	#0
    cset	w23,	ne
    mov	w24,	w23
    ldr	w23,	[sp, #720]

    cmp	w23,	#0
    ldr	w26,	[sp, #548]

    movz	w19,	#1
    csel	w21,	w19,	w24,	ne
    cmp	w26,	#0
    cset	w0,	ne
    ldr	w25,	[sp, #720]

    mov	w20,	w0
    cmp	w25,	#0
    movz	w19,	#0
    mov	w0,	w19
    csel	w23,	w20,	w0,	ne
    cmp	w23,	#0
    cset	w24,	eq
    mov	w27,	w24
    cmp	w27,	#0
    cset	w28,	ne
    mov	w0,	w28
    cmp	w21,	#0
    movz	w24,	#0
    mov	w26,	w24
    csel	w21,	w0,	w26,	ne
    str	w21,	[sp, #820]

    ldr	w19,	[sp, #552]

    cmp	w19,	#0
    ldr	w28,	[sp, #548]

    cset	w23,	ne
    mov	w20,	w23
    cmp	w28,	#0
    cset	w27,	ne
    ldr	w22,	[sp, #720]

    mov	w28,	w27
    cmp	w22,	#0
    movz	w24,	#0
    csel	w24,	w28,	w24,	ne
    cmp	w24,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w20,	#0
    movz	w0,	#1
    mov	w24,	w0
    csel	w24,	w24,	w23,	ne
    str	w24,	[sp, #824]

    ldr	w21,	[sp, #672]

    cmp	w21,	#0
    cset	w28,	ne
    mov	w0,	w28
    cmp	w0,	#0
    cset	w20,	eq
    mov	w21,	w20
    cmp	w21,	#0
    ldr	w21,	[sp, #824]

    cset	w23,	ne
    mov	w28,	w23
    cmp	w21,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w28,	#0
    movz	w20,	#1
    ldr	w22,	[sp, #824]

    mov	w25,	w20
    csel	w25,	w25,	w18,	ne
    cmp	w22,	#0
    cset	w23,	ne
    mov	w24,	w23
    cmp	w28,	#0
    movz	w21,	#0
    csel	w26,	w24,	w21,	ne
    cmp	w26,	#0
    cset	w18,	eq
    mov	w19,	w18
    cmp	w19,	#0
    cset	w22,	ne
    mov	w23,	w22
    cmp	w25,	#0
    movz	w21,	#0
    mov	w19,	w21
    csel	w25,	w23,	w19,	ne
    str	w25,	[sp, #948]

    ldr	w22,	[sp, #672]

    cmp	w22,	#0
    ldr	w25,	[sp, #824]

    cset	w0,	ne
    mov	w26,	w0
    cmp	w25,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w28,	#0
    movz	w19,	#0
    mov	w0,	w19
    csel	w23,	w25,	w0,	ne
    cmp	w23,	#0
    cset	w27,	ne
    mov	w0,	w27
    cmp	w26,	#0
    movz	w19,	#1
    mov	w28,	w19
    csel	w0,	w28,	w0,	ne
    str	w0,	[sp, #828]

    ldr	w28,	[sp, #152]

    cmp	w28,	#0
    cset	w20,	ne
    mov	w21,	w20
    cmp	w21,	#0
    cset	w23,	eq
    mov	w24,	w23
    cmp	w24,	#0
    cset	w27,	ne
    mov	w21,	w27
    ldr	w27,	[sp, #828]

    cmp	w27,	#0
    cset	w19,	ne
    mov	w23,	w19
    cmp	w21,	#0
    movz	w28,	#1
    mov	w27,	w28
    csel	w0,	w27,	w23,	ne
    str	w0,	[sp, #836]

    ldr	w28,	[sp, #828]

    cmp	w28,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w21,	#0
    movz	w27,	#0
    mov	w23,	w27
    csel	w24,	w0,	w23,	ne
    cmp	w24,	#0
    cset	w23,	eq
    mov	w24,	w23
    cmp	w24,	#0
    ldr	w0,	[sp, #836]

    cset	w25,	ne
    mov	w26,	w25
    cmp	w0,	#0
    movz	w22,	#0
    csel	w23,	w26,	w22,	ne
    str	w23,	[sp, #944]

    ldr	w22,	[sp, #152]

    cmp	w22,	#0
    cset	w19,	ne
    ldr	w20,	[sp, #828]

    mov	w27,	w19
    cmp	w20,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w21,	#0
    movz	w26,	#0
    mov	w24,	w26
    csel	w22,	w22,	w24,	ne
    cmp	w22,	#0
    cset	w23,	ne
    mov	w24,	w23
    cmp	w27,	#0
    movz	w23,	#1
    mov	w27,	w23
    csel	w27,	w27,	w24,	ne
    str	w27,	[sp, #840]

    ldr	w21,	[sp, #168]

    cmp	w21,	#0
    cset	w28,	ne
    mov	w0,	w28
    cmp	w0,	#0
    cset	w20,	eq
    mov	w21,	w20
    cmp	w21,	#0
    cset	w0,	ne
    mov	w22,	w0
    str	w22,	[sp, #400]

    ldr	w28,	[sp, #840]

    cmp	w28,	#0
    ldr	w28,	[sp, #400]

    cset	w24,	ne
    mov	w27,	w24
    cmp	w28,	#0
    movz	w24,	#1
    ldr	w0,	[sp, #840]

    csel	w19,	w24,	w27,	ne
    cmp	w0,	#0
    cset	w20,	ne
    ldr	w0,	[sp, #400]

    mov	w21,	w20
    cmp	w0,	#0
    movz	w26,	#0
    mov	w23,	w26
    csel	w21,	w21,	w23,	ne
    cmp	w21,	#0
    cset	w23,	eq
    mov	w24,	w23
    cmp	w24,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w19,	#0
    movz	w0,	#0
    mov	w20,	w0
    csel	w22,	w18,	w20,	ne
    str	w22,	[sp, #936]

    ldr	w0,	[sp, #168]

    cmp	w0,	#0
    ldr	w24,	[sp, #840]

    cset	w21,	ne
    mov	w23,	w21
    cmp	w24,	#0
    cset	w18,	ne
    ldr	w27,	[sp, #400]

    mov	w19,	w18
    cmp	w27,	#0
    movz	w20,	#0
    mov	w28,	w20
    csel	w24,	w19,	w28,	ne
    cmp	w24,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w23,	#0
    movz	w23,	#1
    mov	w19,	w23
    csel	w20,	w19,	w0,	ne
    str	w20,	[sp, #844]

    ldr	w23,	[sp, #440]

    cmp	w23,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w28,	#0
    cset	w0,	eq
    mov	w20,	w0
    cmp	w20,	#0
    cset	w21,	ne
    ldr	w27,	[sp, #844]

    mov	w23,	w21
    cmp	w27,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w23,	#0
    movz	w26,	#1
    ldr	w28,	[sp, #844]

    csel	w25,	w26,	w0,	ne
    cmp	w28,	#0
    cset	w22,	ne
    mov	w24,	w22
    cmp	w23,	#0
    movz	w26,	#0
    mov	w20,	w26
    csel	w24,	w24,	w20,	ne
    cmp	w24,	#0
    cset	w0,	eq
    mov	w18,	w0
    cmp	w18,	#0
    cset	w19,	ne
    mov	w22,	w19
    cmp	w25,	#0
    movz	w28,	#0
    mov	w27,	w28
    csel	w19,	w22,	w27,	ne
    str	w19,	[sp, #928]

    ldr	w20,	[sp, #440]

    cmp	w20,	#0
    cset	w26,	ne
    ldr	w18,	[sp, #844]

    mov	w0,	w26
    cmp	w18,	#0
    cset	w21,	ne
    mov	w22,	w21
    cmp	w23,	#0
    movz	w28,	#0
    mov	w27,	w28
    csel	w24,	w22,	w27,	ne
    cmp	w24,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w0,	#0
    movz	w19,	#1
    csel	w25,	w19,	w26,	ne
    str	w25,	[sp, #940]

    ldr	w27,	[sp, #460]

    cmp	w27,	#0
    cset	w0,	ne
    mov	w20,	w0
    cmp	w20,	#0
    cset	w21,	eq
    mov	w23,	w21
    cmp	w23,	#0
    cset	w24,	ne
    ldr	w18,	[sp, #940]

    cmp	w18,	#0
    cset	w18,	ne
    mov	w19,	w18
    cmp	w24,	#0
    movz	w26,	#1
    csel	w22,	w26,	w19,	ne
    ldr	w19,	[sp, #940]

    cmp	w19,	#0
    cset	w18,	ne
    mov	w19,	w18
    str	w19,	[sp, #644]

    cmp	w24,	#0
    movz	w23,	#0
    mov	w18,	w23
    ldr	w23,	[sp, #644]

    csel	w23,	w23,	w18,	ne
    cmp	w23,	#0
    cset	w25,	eq
    mov	w0,	w25
    cmp	w0,	#0
    cset	w18,	ne
    mov	w26,	w18
    cmp	w22,	#0
    movz	w0,	#0
    mov	w18,	w0
    csel	w22,	w26,	w18,	ne
    str	w22,	[sp, #932]

    ldr	w25,	[sp, #460]

    cmp	w25,	#0
    cset	w18,	ne
    mov	w19,	w18
    ldr	w18,	[sp, #940]

    cmp	w18,	#0
    cset	w20,	ne
    mov	w21,	w20
    cmp	w24,	#0
    movz	w28,	#0
    mov	w27,	w28
    csel	w24,	w21,	w27,	ne
    cmp	w24,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w19,	#0
    movz	w18,	#1
    mov	w22,	w18
    csel	w24,	w22,	w26,	ne
    str	w24,	[sp, #648]

    ldr	w24,	[sp, #456]

    cmp	w24,	#0
    cset	w20,	ne
    mov	w21,	w20
    cmp	w21,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    cset	w24,	ne
    ldr	w23,	[sp, #648]

    mov	w27,	w24
    cmp	w23,	#0
    cset	w22,	ne
    mov	w23,	w22
    cmp	w27,	#0
    movz	w20,	#1
    csel	w23,	w20,	w23,	ne
    ldr	w20,	[sp, #648]

    cmp	w20,	#0
    cset	w25,	ne
    mov	w18,	w25
    cmp	w27,	#0
    movz	w24,	#0
    csel	w22,	w18,	w24,	ne
    cmp	w22,	#0
    cset	w28,	eq
    mov	w0,	w28
    cmp	w0,	#0
    cset	w20,	ne
    mov	w21,	w20
    cmp	w23,	#0
    ldr	w20,	[sp, #932]

    movz	w0,	#0
    mov	w19,	w0
    ldr	w0,	[sp, #928]

    csel	w23,	w21,	w19,	ne
    lsl	w26,	w23,	#1
    ldr	w23,	[sp, #936]

    add	w27,	w26,	w20
    lsl	w19,	w27,	#1
    add	w0,	w19,	w0
    ldr	w19,	[sp, #944]

    lsl	w22,	w0,	#1
    add	w21,	w22,	w23
    ldr	w22,	[sp, #948]

    lsl	w0,	w21,	#1
    add	w23,	w0,	w19
    lsl	w26,	w23,	#1
    add	w27,	w26,	w22
    ldr	w22,	[sp, #820]

    ldr	w23,	[sp, #832]

    lsl	w18,	w27,	#1
    ldr	w26,	[sp, #888]

    add	w0,	w18,	w22
    lsl	w22,	w0,	#1
    add	w21,	w22,	w23
    lsl	w0,	w21,	#1
    add	w23,	w0,	w26
    ldr	w0,	[sp, #916]

    lsl	w26,	w23,	#1
    add	w27,	w26,	w0
    ldr	w26,	[sp, #652]

    lsl	w28,	w27,	#1
    add	w0,	w28,	w26
    lsl	w20,	w0,	#1
    ldr	w0,	[sp, #132]

    ldr	w25,	[sp, #144]

    add	w21,	w20,	w0
    lsl	w0,	w21,	#1
    add	w23,	w0,	w25
    ldr	w0,	[sp, #180]

    ldr	w25,	[sp, #448]

    lsl	w24,	w23,	#1
    add	w27,	w24,	w0
    lsl	w28,	w27,	#1
    add	w0,	w28,	w25
    ldr	w28,	[sp, #464]

    lsl	w20,	w0,	#1
    add	w0,	w20,	w28
    bl	fib
    str	w0,	[sp, #468]

    ldr	w0,	[sp, #232]

    cmp	w0,	#0
    ldr	w21,	[sp, #500]

    ldr	w23,	[sp, #232]

    csel	w22,	w21,	w23,	lt
    str	w22,	[sp, #1088]

    ldr	w0,	[sp, #240]

    cmp	w0,	#0
    ldr	w20,	[sp, #516]

    ldr	w23,	[sp, #240]

    csel	w25,	w20,	w23,	lt
    str	w25,	[sp, #996]

    ldr	w19,	[sp, #244]

    cmp	w19,	#0
    ldr	w27,	[sp, #188]

    ldr	w20,	[sp, #244]

    csel	w18,	w27,	w20,	lt
    str	w18,	[sp, #1096]

    ldr	w18,	[sp, #252]

    cmp	w18,	#0
    ldr	w27,	[sp, #200]

    ldr	w19,	[sp, #252]

    csel	w23,	w27,	w19,	lt
    str	w23,	[sp, #708]

    ldr	w20,	[sp, #248]

    cmp	w20,	#0
    ldr	w0,	[sp, #212]

    ldr	w21,	[sp, #248]

    csel	w27,	w0,	w21,	lt
    str	w27,	[sp, #712]

    ldr	w0,	[sp, #236]

    cmp	w0,	#0
    ldr	w24,	[sp, #224]

    ldr	w18,	[sp, #236]

    csel	w19,	w24,	w18,	lt
    str	w19,	[sp, #532]

    ldr	w21,	[sp, #228]

    cmp	w21,	#0
    ldr	w21,	[sp, #216]

    ldr	w0,	[sp, #228]

    csel	w23,	w21,	w0,	lt
    str	w23,	[sp, #536]

    ldr	w19,	[sp, #220]

    cmp	w19,	#0
    ldr	w21,	[sp, #204]

    ldr	w20,	[sp, #220]

    csel	w27,	w21,	w20,	lt
    str	w27,	[sp, #540]

    ldr	w0,	[sp, #208]

    cmp	w0,	#0
    ldr	w19,	[sp, #192]

    ldr	w20,	[sp, #208]

    csel	w19,	w19,	w20,	lt
    str	w19,	[sp, #284]

    ldr	w28,	[sp, #196]

    cmp	w28,	#0
    ldr	w0,	[sp, #524]

    ldr	w22,	[sp, #196]

    csel	w23,	w0,	w22,	lt
    str	w23,	[sp, #288]

    ldr	w19,	[sp, #528]

    cmp	w19,	#0
    ldr	w28,	[sp, #512]

    ldr	w22,	[sp, #528]

    csel	w28,	w28,	w22,	lt
    str	w28,	[sp, #408]

    ldr	w0,	[sp, #520]

    cmp	w0,	#0
    ldr	w25,	[sp, #504]

    ldr	w19,	[sp, #520]

    csel	w26,	w25,	w19,	lt
    str	w26,	[sp, #112]

    ldr	w20,	[sp, #508]

    cmp	w20,	#0
    ldr	w0,	[sp, #492]

    ldr	w21,	[sp, #508]

    csel	w20,	w0,	w21,	lt
    str	w20,	[sp, #148]

    ldr	w25,	[sp, #496]

    cmp	w25,	#0
    ldr	w26,	[sp, #484]

    ldr	w21,	[sp, #496]

    csel	w25,	w26,	w21,	lt
    str	w25,	[sp, #176]

    ldr	w21,	[sp, #488]

    cmp	w21,	#0
    ldr	w0,	[sp, #476]

    ldr	w19,	[sp, #488]

    csel	w26,	w0,	w19,	lt
    str	w26,	[sp, #432]

    ldr	w19,	[sp, #480]

    cmp	w19,	#0
    ldr	w18,	[sp, #472]

    ldr	w24,	[sp, #480]

    csel	w19,	w18,	w24,	lt
    str	w19,	[sp, #436]

    ldr	w23,	[sp, #1088]

    cmp	w23,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w19,	ne
    str	w19,	[sp, #452]

    ldr	w26,	[sp, #996]

    cmp	w26,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w27,	ne
    str	w27,	[sp, #444]

    ldr	w27,	[sp, #996]

    cmp	w27,	#0
    cset	w27,	ne
    cmp	w27,	#0
    cset	w0,	ne
    ldr	w27,	[sp, #1096]

    mov	w18,	w0
    cmp	w27,	#0
    cset	w22,	ne
    cmp	w22,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w0,	ne
    str	w0,	[sp, #632]

    cmp	w18,	#0
    cset	w19,	ne
    ldr	w25,	[sp, #632]

    mov	w21,	w19
    cmp	w25,	#0
    movz	w28,	#1
    csel	w26,	w28,	w21,	ne
    cmp	w18,	#0
    cset	w25,	ne
    str	w25,	[sp, #628]

    ldr	w20,	[sp, #632]

    cmp	w20,	#0
    movz	w25,	#0
    ldr	w19,	[sp, #628]

    mov	w0,	w25
    csel	w21,	w19,	w0,	ne
    cmp	w21,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w26,	#0
    movz	w25,	#0
    csel	w20,	w22,	w25,	ne
    str	w20,	[sp, #184]

    ldr	w28,	[sp, #1096]

    cmp	w28,	#0
    cset	w25,	ne
    cmp	w18,	#0
    cset	w20,	ne
    ldr	w27,	[sp, #632]

    mov	w23,	w20
    cmp	w27,	#0
    movz	w0,	#0
    csel	w0,	w23,	w0,	ne
    cmp	w0,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w25,	#0
    movz	w19,	#1
    ldr	w24,	[sp, #708]

    csel	w18,	w19,	w18,	ne
    cmp	w24,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w28,	ne
    cmp	w18,	#0
    cset	w0,	ne
    mov	w19,	w0
    cmp	w28,	#0
    movz	w20,	#1
    csel	w26,	w20,	w19,	ne
    cmp	w18,	#0
    cset	w25,	ne
    str	w25,	[sp, #676]

    cmp	w28,	#0
    movz	w19,	#0
    ldr	w24,	[sp, #676]

    csel	w22,	w24,	w19,	ne
    cmp	w22,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w26,	#0
    movz	w27,	#0
    csel	w22,	w22,	w27,	ne
    str	w22,	[sp, #164]

    ldr	w19,	[sp, #708]

    cmp	w19,	#0
    cset	w0,	ne
    cmp	w18,	#0
    cset	w22,	ne
    cmp	w28,	#0
    movz	w28,	#0
    csel	w21,	w22,	w28,	ne
    cmp	w21,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w0,	#0
    ldr	w28,	[sp, #712]

    movz	w18,	#1
    csel	w23,	w18,	w27,	ne
    cmp	w28,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w0,	ne
    cmp	w23,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w0,	#0
    movz	w25,	#1
    csel	w18,	w25,	w19,	ne
    cmp	w23,	#0
    cset	w21,	ne
    mov	w24,	w21
    cmp	w0,	#0
    movz	w22,	#0
    csel	w21,	w24,	w22,	ne
    cmp	w21,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w19,	ne
    mov	w22,	w19
    cmp	w18,	#0
    movz	w21,	#0
    csel	w27,	w22,	w21,	ne
    str	w27,	[sp, #136]

    ldr	w24,	[sp, #712]

    cmp	w24,	#0
    cset	w25,	ne
    cmp	w23,	#0
    cset	w23,	ne
    mov	w27,	w23
    cmp	w0,	#0
    movz	w18,	#0
    csel	w18,	w27,	w18,	ne
    cmp	w18,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w25,	#0
    movz	w28,	#1
    csel	w23,	w28,	w22,	ne
    str	w23,	[sp, #956]

    ldr	w20,	[sp, #532]

    cmp	w20,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w23,	eq
    cmp	w23,	#0
    ldr	w23,	[sp, #956]

    cset	w28,	ne
    cmp	w23,	#0
    cset	w0,	ne
    cmp	w28,	#0
    movz	w27,	#1
    ldr	w24,	[sp, #956]

    csel	w26,	w27,	w0,	ne
    cmp	w24,	#0
    cset	w0,	ne
    mov	w19,	w0
    cmp	w28,	#0
    movz	w24,	#0
    csel	w20,	w19,	w24,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w26,	#0
    movz	w0,	#0
    csel	w24,	w27,	w0,	ne
    str	w24,	[sp, #664]

    ldr	w27,	[sp, #532]

    cmp	w27,	#0
    ldr	w18,	[sp, #956]

    cset	w20,	ne
    cmp	w18,	#0
    cset	w0,	ne
    cmp	w28,	#0
    movz	w22,	#0
    csel	w26,	w0,	w22,	ne
    cmp	w26,	#0
    cset	w0,	ne
    mov	w21,	w0
    cmp	w20,	#0
    ldr	w24,	[sp, #536]

    movz	w0,	#1
    csel	w22,	w0,	w21,	ne
    cmp	w24,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w0,	ne
    cmp	w22,	#0
    cset	w21,	ne
    mov	w24,	w21
    cmp	w0,	#0
    movz	w19,	#1
    csel	w26,	w19,	w24,	ne
    cmp	w22,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w0,	#0
    movz	w19,	#0
    csel	w19,	w20,	w19,	ne
    cmp	w19,	#0
    cset	w21,	eq
    cmp	w21,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w26,	#0
    movz	w18,	#0
    csel	w25,	w27,	w18,	ne
    str	w25,	[sp, #312]

    ldr	w21,	[sp, #536]

    cmp	w21,	#0
    cset	w19,	ne
    cmp	w22,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w0,	#0
    movz	w25,	#0
    csel	w0,	w22,	w25,	ne
    cmp	w0,	#0
    cset	w26,	ne
    mov	w28,	w26
    cmp	w19,	#0
    movz	w27,	#1
    csel	w27,	w27,	w28,	ne
    ldr	w28,	[sp, #540]

    cmp	w28,	#0
    cset	w28,	ne
    cmp	w28,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w28,	ne
    cmp	w27,	#0
    cset	w0,	ne
    mov	w19,	w0
    cmp	w28,	#0
    movz	w21,	#1
    csel	w22,	w21,	w19,	ne
    cmp	w27,	#0
    cset	w0,	ne
    cmp	w28,	#0
    movz	w20,	#0
    csel	w26,	w0,	w20,	ne
    cmp	w26,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w20,	ne
    mov	w23,	w20
    cmp	w22,	#0
    movz	w0,	#0
    csel	w21,	w23,	w0,	ne
    str	w21,	[sp, #308]

    ldr	w24,	[sp, #540]

    cmp	w24,	#0
    cset	w25,	ne
    cmp	w27,	#0
    cset	w21,	ne
    mov	w24,	w21
    cmp	w28,	#0
    movz	w0,	#0
    csel	w20,	w24,	w0,	ne
    cmp	w20,	#0
    cset	w0,	ne
    cmp	w25,	#0
    ldr	w20,	[sp, #284]

    movz	w18,	#1
    csel	w24,	w18,	w0,	ne
    cmp	w20,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w0,	ne
    cmp	w24,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w0,	#0
    movz	w26,	#1
    csel	w20,	w26,	w19,	ne
    cmp	w24,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w0,	#0
    movz	w25,	#0
    csel	w22,	w23,	w25,	ne
    cmp	w22,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w19,	ne
    mov	w21,	w19
    cmp	w20,	#0
    movz	w22,	#0
    csel	w28,	w21,	w22,	ne
    str	w28,	[sp, #316]

    ldr	w18,	[sp, #284]

    cmp	w18,	#0
    cset	w25,	ne
    cmp	w24,	#0
    cset	w24,	ne
    mov	w28,	w24
    cmp	w0,	#0
    movz	w19,	#0
    csel	w18,	w28,	w19,	ne
    cmp	w18,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w25,	#0
    movz	w23,	#1
    ldr	w24,	[sp, #288]

    csel	w22,	w23,	w22,	ne
    cmp	w24,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w28,	ne
    cmp	w22,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w28,	#0
    movz	w0,	#1
    csel	w18,	w0,	w18,	ne
    cmp	w22,	#0
    cset	w0,	ne
    mov	w19,	w0
    cmp	w28,	#0
    movz	w25,	#0
    csel	w23,	w19,	w25,	ne
    cmp	w23,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w18,	#0
    movz	w24,	#0
    csel	w19,	w27,	w24,	ne
    str	w19,	[sp, #952]

    ldr	w21,	[sp, #288]

    cmp	w21,	#0
    cset	w20,	ne
    cmp	w22,	#0
    cset	w26,	ne
    mov	w18,	w26
    cmp	w28,	#0
    movz	w0,	#0
    csel	w26,	w18,	w0,	ne
    cmp	w26,	#0
    cset	w0,	ne
    mov	w19,	w0
    cmp	w20,	#0
    movz	w28,	#1
    ldr	w0,	[sp, #408]

    csel	w22,	w28,	w19,	ne
    cmp	w0,	#0
    cset	w28,	ne
    cmp	w28,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w0,	ne
    cmp	w22,	#0
    cset	w21,	ne
    mov	w24,	w21
    cmp	w0,	#0
    movz	w20,	#1
    csel	w26,	w20,	w24,	ne
    cmp	w22,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w0,	#0
    movz	w20,	#0
    csel	w27,	w19,	w20,	ne
    cmp	w27,	#0
    cset	w21,	eq
    cmp	w21,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w26,	#0
    movz	w19,	#0
    csel	w19,	w27,	w19,	ne
    str	w19,	[sp, #304]

    ldr	w27,	[sp, #408]

    cmp	w27,	#0
    cset	w19,	ne
    cmp	w22,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w0,	#0
    movz	w26,	#0
    csel	w0,	w23,	w26,	ne
    cmp	w0,	#0
    cset	w26,	ne
    cmp	w19,	#0
    movz	w19,	#1
    csel	w28,	w19,	w26,	ne
    str	w28,	[sp, #960]

    ldr	w28,	[sp, #112]

    cmp	w28,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w23,	eq
    cmp	w23,	#0
    ldr	w0,	[sp, #960]

    cset	w28,	ne
    cmp	w0,	#0
    cset	w27,	ne
    mov	w19,	w27
    cmp	w28,	#0
    movz	w0,	#1
    ldr	w18,	[sp, #960]

    csel	w22,	w0,	w19,	ne
    cmp	w18,	#0
    cset	w0,	ne
    cmp	w28,	#0
    movz	w21,	#0
    csel	w25,	w0,	w21,	ne
    cmp	w25,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w20,	ne
    mov	w23,	w20
    cmp	w22,	#0
    movz	w19,	#0
    csel	w25,	w23,	w19,	ne
    str	w25,	[sp, #428]

    ldr	w0,	[sp, #112]

    cmp	w0,	#0
    ldr	w23,	[sp, #960]

    cset	w25,	ne
    cmp	w23,	#0
    cset	w22,	ne
    mov	w26,	w22
    cmp	w28,	#0
    movz	w18,	#0
    csel	w20,	w26,	w18,	ne
    cmp	w20,	#0
    cset	w0,	ne
    cmp	w25,	#0
    ldr	w25,	[sp, #148]

    movz	w26,	#1
    csel	w20,	w26,	w0,	ne
    cmp	w25,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w0,	ne
    cmp	w20,	#0
    cset	w19,	ne
    mov	w21,	w19
    cmp	w0,	#0
    movz	w28,	#1
    csel	w18,	w28,	w21,	ne
    cmp	w20,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w0,	#0
    movz	w26,	#0
    csel	w23,	w23,	w26,	ne
    cmp	w23,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w19,	ne
    mov	w21,	w19
    cmp	w18,	#0
    movz	w25,	#0
    csel	w23,	w21,	w25,	ne
    str	w23,	[sp, #424]

    ldr	w18,	[sp, #148]

    cmp	w18,	#0
    cset	w25,	ne
    cmp	w20,	#0
    cset	w28,	ne
    mov	w19,	w28
    cmp	w0,	#0
    movz	w21,	#0
    csel	w18,	w19,	w21,	ne
    cmp	w18,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w25,	#0
    ldr	w0,	[sp, #176]

    movz	w28,	#1
    csel	w23,	w28,	w22,	ne
    cmp	w0,	#0
    cset	w28,	ne
    cmp	w28,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w28,	ne
    cmp	w23,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w28,	#0
    movz	w19,	#1
    csel	w22,	w19,	w27,	ne
    cmp	w23,	#0
    cset	w0,	ne
    mov	w19,	w0
    cmp	w28,	#0
    movz	w27,	#0
    csel	w20,	w19,	w27,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w22,	#0
    movz	w27,	#0
    csel	w19,	w26,	w27,	ne
    str	w19,	[sp, #420]

    ldr	w24,	[sp, #176]

    cmp	w24,	#0
    cset	w20,	ne
    cmp	w23,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w28,	#0
    movz	w25,	#0
    csel	w26,	w18,	w25,	ne
    cmp	w26,	#0
    cset	w0,	ne
    mov	w21,	w0
    cmp	w20,	#0
    ldr	w23,	[sp, #432]

    movz	w0,	#1
    csel	w24,	w0,	w21,	ne
    cmp	w23,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w27,	ne
    mov	w22,	w27
    cmp	w24,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w22,	#0
    movz	w19,	#1
    csel	w20,	w19,	w18,	ne
    cmp	w24,	#0
    cset	w0,	ne
    str	w0,	[sp, #656]

    cmp	w22,	#0
    ldr	w26,	[sp, #656]

    movz	w21,	#0
    mov	w0,	w21
    csel	w0,	w26,	w0,	ne
    cmp	w0,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w0,	ne
    mov	w19,	w0
    cmp	w20,	#0
    movz	w28,	#0
    ldr	w0,	[sp, #432]

    csel	w27,	w19,	w28,	ne
    cmp	w0,	#0
    cset	w19,	ne
    cmp	w24,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w22,	#0
    movz	w18,	#0
    csel	w0,	w20,	w18,	ne
    cmp	w0,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w19,	#0
    movz	w28,	#1
    csel	w21,	w28,	w23,	ne
    str	w21,	[sp, #660]

    ldr	w26,	[sp, #436]

    cmp	w26,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w20,	eq
    cmp	w20,	#0
    ldr	w18,	[sp, #660]

    cset	w23,	ne
    cmp	w18,	#0
    cset	w0,	ne
    mov	w20,	w0
    cmp	w23,	#0
    movz	w18,	#1
    ldr	w19,	[sp, #660]

    csel	w28,	w18,	w20,	ne
    cmp	w19,	#0
    cset	w21,	ne
    mov	w25,	w21
    cmp	w23,	#0
    movz	w20,	#0
    csel	w19,	w25,	w20,	ne
    cmp	w19,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w24,	ne
    mov	w26,	w24
    cmp	w28,	#0
    ldr	w23,	[sp, #420]

    movz	w19,	#0
    csel	w18,	w26,	w19,	ne
    lsl	w20,	w18,	#1
    ldr	w26,	[sp, #424]

    ldr	w0,	[sp, #428]

    add	w28,	w20,	w27
    lsl	w19,	w28,	#1
    add	w18,	w19,	w23
    lsl	w21,	w18,	#1
    add	w20,	w21,	w26
    ldr	w21,	[sp, #304]

    lsl	w18,	w20,	#1
    add	w23,	w18,	w0
    lsl	w26,	w23,	#1
    add	w25,	w26,	w21
    ldr	w21,	[sp, #952]

    ldr	w18,	[sp, #316]

    lsl	w28,	w25,	#1
    ldr	w24,	[sp, #308]

    add	w27,	w28,	w21
    lsl	w19,	w27,	#1
    ldr	w27,	[sp, #312]

    add	w0,	w19,	w18
    lsl	w20,	w0,	#1
    add	w19,	w20,	w24
    lsl	w22,	w19,	#1
    add	w0,	w22,	w27
    ldr	w27,	[sp, #664]

    ldr	w28,	[sp, #136]

    lsl	w23,	w0,	#1
    add	w24,	w23,	w27
    ldr	w23,	[sp, #164]

    ldr	w21,	[sp, #184]

    lsl	w25,	w24,	#1
    ldr	w24,	[sp, #444]

    add	w26,	w25,	w28
    lsl	w27,	w26,	#1
    add	w28,	w27,	w23
    lsl	w0,	w28,	#1
    add	w18,	w0,	w21
    lsl	w19,	w18,	#1
    add	w20,	w19,	w24
    ldr	w19,	[sp, #452]

    lsl	w0,	w20,	#1
    add	w0,	w0,	w19
    bl	fib
    ldr	w14,	[sp, #468]

    movz	w4,	#0
    ldr	w20,	[sp, #468]

    asr	w12,	w14,	#31
    ldr	w21,	[sp, #468]

    lsr	w13,	w12,	#31
    add	w14,	w20,	w13
    asr	w5,	w14,	#1
    lsl	w6,	w5,	#1
    sub	w1,	w21,	w6
    sub	w3,	w4,	w1
    cmp	w1,	#0
    ldr	w22,	[sp, #468]

    csel	w11,	w3,	w1,	lt
    asr	w23,	w22,	#31
    ldr	w28,	[sp, #468]

    movz	w1,	#0
    lsr	w24,	w23,	#31
    add	w25,	w28,	w24
    asr	w5,	w25,	#1
    asr	w2,	w5,	#31
    lsr	w3,	w2,	#31
    add	w6,	w5,	w3
    asr	w9,	w6,	#1
    lsl	w10,	w9,	#1
    sub	w3,	w5,	w10
    sub	w6,	w1,	w3
    cmp	w3,	#0
    movz	w25,	#0
    csel	w22,	w6,	w3,	lt
    asr	w7,	w5,	#31
    str	w22,	[sp, #568]

    lsr	w8,	w7,	#31
    add	w2,	w5,	w8
    asr	w10,	w2,	#1
    asr	w8,	w10,	#31
    lsr	w12,	w8,	#31
    add	w14,	w10,	w12
    asr	w3,	w14,	#1
    lsl	w4,	w3,	#1
    sub	w5,	w10,	w4
    sub	w8,	w25,	w5
    cmp	w5,	#0
    csel	w1,	w8,	w5,	lt
    movz	w21,	#0
    asr	w15,	w10,	#31
    str	w1,	[sp, #764]

    lsr	w16,	w15,	#31
    add	w8,	w10,	w16
    asr	w17,	w8,	#1
    asr	w18,	w17,	#31
    lsr	w19,	w18,	#31
    add	w20,	w17,	w19
    asr	w1,	w20,	#1
    lsl	w2,	w1,	#1
    sub	w10,	w17,	w2
    sub	w15,	w21,	w10
    cmp	w10,	#0
    asr	w21,	w17,	#31
    csel	w6,	w15,	w10,	lt
    str	w6,	[sp, #768]

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
    csel	w9,	w20,	w19,	lt
    movz	w13,	#0
    asr	w27,	w24,	#31
    str	w9,	[sp, #740]

    lsr	w28,	w27,	#31
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
    asr	w4,	w1,	#31
    csel	w12,	w26,	w25,	lt
    str	w12,	[sp, #772]

    lsr	w5,	w4,	#31
    add	w28,	w1,	w5
    asr	w3,	w28,	#1
    asr	w8,	w3,	#31
    lsr	w9,	w8,	#31
    movz	w8,	#0
    add	w10,	w3,	w9
    asr	w17,	w10,	#1
    lsl	w18,	w17,	#1
    sub	w4,	w3,	w18
    sub	w6,	w8,	w4
    cmp	w4,	#0
    csel	w17,	w6,	w4,	lt
    asr	w12,	w3,	#31
    str	w17,	[sp, #776]

    movz	w4,	#0
    lsr	w14,	w12,	#31
    add	w5,	w3,	w14
    asr	w10,	w5,	#1
    asr	w16,	w10,	#31
    lsr	w17,	w16,	#31
    add	w18,	w10,	w17
    asr	w12,	w18,	#1
    lsl	w14,	w12,	#1
    sub	w7,	w10,	w14
    sub	w8,	w4,	w7
    cmp	w7,	#0
    csel	w22,	w8,	w7,	lt
    movz	w1,	#0
    asr	w19,	w10,	#31
    str	w22,	[sp, #780]

    lsr	w20,	w19,	#31
    add	w13,	w10,	w20
    asr	w17,	w13,	#1
    asr	w22,	w17,	#31
    lsr	w23,	w22,	#31
    add	w24,	w17,	w23
    asr	w5,	w24,	#1
    lsl	w6,	w5,	#1
    sub	w12,	w17,	w6
    sub	w15,	w1,	w12
    cmp	w12,	#0
    csel	w4,	w15,	w12,	lt
    asr	w25,	w17,	#31
    str	w4,	[sp, #736]

    lsr	w26,	w25,	#31
    movz	w25,	#0
    add	w19,	w17,	w26
    asr	w21,	w19,	#1
    asr	w28,	w21,	#31
    lsr	w1,	w28,	#31
    add	w2,	w21,	w1
    asr	w3,	w2,	#1
    lsl	w2,	w3,	#1
    sub	w17,	w21,	w2
    sub	w20,	w25,	w17
    cmp	w17,	#0
    csel	w12,	w20,	w17,	lt
    asr	w3,	w21,	#31
    str	w12,	[sp, #800]

    lsr	w2,	w3,	#31
    add	w25,	w21,	w2
    movz	w21,	#0
    asr	w28,	w25,	#1
    asr	w4,	w28,	#31
    lsr	w5,	w4,	#31
    add	w6,	w28,	w5
    asr	w25,	w6,	#1
    lsl	w27,	w25,	#1
    sub	w24,	w28,	w27
    sub	w25,	w21,	w24
    cmp	w24,	#0
    asr	w7,	w28,	#31
    csel	w17,	w25,	w24,	lt
    str	w17,	[sp, #804]

    lsr	w8,	w7,	#31
    movz	w17,	#0
    add	w2,	w28,	w8
    asr	w2,	w2,	#1
    asr	w14,	w2,	#31
    lsr	w15,	w14,	#31
    add	w16,	w2,	w15
    asr	w23,	w16,	#1
    lsl	w24,	w23,	#1
    sub	w4,	w2,	w24
    sub	w6,	w17,	w4
    cmp	w4,	#0
    asr	w17,	w2,	#31
    csel	w20,	w6,	w4,	lt
    movz	w13,	#0
    str	w20,	[sp, #748]

    lsr	w18,	w17,	#31
    add	w8,	w2,	w18
    asr	w5,	w8,	#1
    asr	w20,	w5,	#31
    lsr	w21,	w20,	#31
    add	w22,	w5,	w21
    asr	w19,	w22,	#1
    lsl	w20,	w19,	#1
    sub	w7,	w5,	w20
    sub	w10,	w13,	w7
    cmp	w7,	#0
    csel	w18,	w10,	w7,	lt
    asr	w23,	w5,	#31
    movz	w8,	#0
    str	w18,	[sp, #624]

    lsr	w24,	w23,	#31
    add	w16,	w5,	w24
    asr	w14,	w16,	#1
    asr	w17,	w14,	#31
    lsr	w18,	w17,	#31
    add	w19,	w14,	w18
    asr	w27,	w19,	#1
    lsl	w28,	w27,	#1
    sub	w17,	w14,	w28
    sub	w18,	w8,	w17
    cmp	w17,	#0
    asr	w20,	w14,	#31
    movz	w4,	#0
    csel	w27,	w18,	w17,	lt
    lsr	w21,	w20,	#31
    str	w27,	[sp, #572]

    add	w22,	w14,	w21
    asr	w12,	w22,	#1
    asr	w23,	w12,	#31
    lsr	w24,	w23,	#31
    add	w25,	w12,	w24
    asr	w23,	w25,	#1
    lsl	w24,	w23,	#1
    sub	w22,	w12,	w24
    sub	w23,	w4,	w22
    cmp	w22,	#0
    csel	w13,	w23,	w22,	lt
    asr	w26,	w12,	#31
    movz	w1,	#0
    str	w13,	[sp, #620]

    lsr	w27,	w26,	#31
    add	w28,	w12,	w27
    asr	w22,	w28,	#1
    asr	w8,	w22,	#31
    lsr	w9,	w8,	#31
    add	w10,	w22,	w9
    asr	w3,	w10,	#1
    lsl	w4,	w3,	#1
    sub	w26,	w22,	w4
    sub	w28,	w1,	w26
    cmp	w26,	#0
    csel	w23,	w28,	w26,	lt
    asr	w3,	w0,	#31
    str	w23,	[sp, #728]

    movz	w26,	#0
    lsr	w4,	w3,	#31
    add	w5,	w0,	w4
    asr	w16,	w5,	#1
    lsl	w17,	w16,	#1
    sub	w3,	w0,	w17
    sub	w2,	w26,	w3
    cmp	w3,	#0
    csel	w2,	w2,	w3,	lt
    asr	w18,	w0,	#31
    lsr	w19,	w18,	#31
    add	w8,	w0,	w19
    asr	w4,	w8,	#1
    asr	w9,	w4,	#31
    lsr	w10,	w9,	#31
    add	w13,	w4,	w10
    asr	w10,	w13,	#1
    lsl	w13,	w10,	#1
    sub	w6,	w4,	w13
    movz	w13,	#0
    sub	w9,	w13,	w6
    cmp	w6,	#0
    asr	w22,	w4,	#31
    movz	w8,	#0
    csel	w26,	w9,	w6,	lt
    lsr	w23,	w22,	#31
    add	w24,	w4,	w23
    asr	w19,	w24,	#1
    asr	w27,	w19,	#31
    lsr	w28,	w27,	#31
    add	w0,	w19,	w28
    asr	w20,	w0,	#1
    lsl	w21,	w20,	#1
    sub	w12,	w19,	w21
    sub	w14,	w8,	w12
    cmp	w12,	#0
    csel	w7,	w14,	w12,	lt
    asr	w10,	w19,	#31
    lsr	w12,	w10,	#31
    add	w14,	w19,	w12
    asr	w13,	w14,	#1
    asr	w3,	w13,	#31
    lsr	w4,	w3,	#31
    add	w5,	w13,	w4
    movz	w4,	#0
    asr	w20,	w5,	#1
    lsl	w21,	w20,	#1
    sub	w22,	w13,	w21
    sub	w16,	w4,	w22
    cmp	w22,	#0
    csel	w4,	w16,	w22,	lt
    asr	w6,	w13,	#31
    str	w4,	[sp, #732]

    lsr	w8,	w6,	#31
    movz	w4,	#0
    add	w20,	w13,	w8
    asr	w18,	w20,	#1
    asr	w12,	w18,	#31
    lsr	w14,	w12,	#31
    add	w15,	w18,	w14
    asr	w14,	w15,	#1
    lsl	w15,	w14,	#1
    sub	w27,	w18,	w15
    sub	w21,	w4,	w27
    cmp	w27,	#0
    csel	w19,	w21,	w27,	lt
    asr	w16,	w18,	#31
    str	w19,	[sp, #592]

    lsr	w19,	w16,	#31
    add	w28,	w18,	w19
    asr	w25,	w28,	#1
    movz	w28,	#0
    asr	w19,	w25,	#31
    lsr	w20,	w19,	#31
    add	w21,	w25,	w20
    asr	w6,	w21,	#1
    lsl	w8,	w6,	#1
    sub	w0,	w25,	w8
    sub	w3,	w28,	w0
    cmp	w0,	#0
    movz	w23,	#0
    asr	w22,	w25,	#31
    csel	w9,	w3,	w0,	lt
    lsr	w24,	w22,	#31
    str	w9,	[sp, #1068]

    add	w3,	w25,	w24
    asr	w8,	w3,	#1
    asr	w0,	w8,	#31
    lsr	w1,	w0,	#31
    add	w3,	w8,	w1
    asr	w0,	w3,	#1
    lsl	w3,	w0,	#1
    sub	w6,	w8,	w3
    sub	w0,	w23,	w6
    cmp	w6,	#0
    asr	w4,	w8,	#31
    csel	w6,	w0,	w6,	lt
    movz	w19,	#0
    str	w6,	[sp, #612]

    lsr	w5,	w4,	#31
    add	w12,	w8,	w5
    asr	w0,	w12,	#1
    asr	w5,	w0,	#31
    lsr	w6,	w5,	#31
    add	w8,	w0,	w6
    asr	w3,	w8,	#1
    lsl	w4,	w3,	#1
    sub	w16,	w0,	w4
    sub	w19,	w19,	w16
    cmp	w16,	#0
    asr	w17,	w0,	#31
    csel	w15,	w19,	w16,	lt
    str	w15,	[sp, #1072]

    lsr	w18,	w17,	#31
    movz	w15,	#0
    add	w19,	w0,	w18
    asr	w9,	w19,	#1
    asr	w20,	w9,	#31
    lsr	w21,	w20,	#31
    add	w22,	w9,	w21
    asr	w3,	w22,	#1
    lsl	w4,	w3,	#1
    sub	w23,	w9,	w4
    sub	w24,	w15,	w23
    cmp	w23,	#0
    movz	w10,	#0
    csel	w21,	w24,	w23,	lt
    str	w21,	[sp, #744]

    asr	w23,	w9,	#31
    lsr	w24,	w23,	#31
    add	w25,	w9,	w24
    asr	w13,	w25,	#1
    asr	w28,	w13,	#31
    lsr	w0,	w28,	#31
    add	w1,	w13,	w0
    asr	w1,	w1,	#1
    lsl	w3,	w1,	#1
    sub	w1,	w13,	w3
    sub	w4,	w10,	w1
    cmp	w1,	#0
    asr	w3,	w13,	#31
    csel	w20,	w4,	w1,	lt
    movz	w5,	#0
    str	w20,	[sp, #760]

    lsr	w4,	w3,	#31
    add	w0,	w13,	w4
    asr	w0,	w0,	#1
    asr	w1,	w0,	#31
    lsr	w3,	w1,	#31
    add	w4,	w0,	w3
    asr	w16,	w4,	#1
    lsl	w17,	w16,	#1
    sub	w4,	w0,	w17
    sub	w6,	w5,	w4
    cmp	w4,	#0
    asr	w5,	w0,	#31
    csel	w27,	w6,	w4,	lt
    str	w27,	[sp, #128]

    lsr	w6,	w5,	#31
    add	w10,	w0,	w6
    movz	w0,	#0
    asr	w12,	w10,	#1
    asr	w3,	w12,	#31
    lsr	w4,	w3,	#31
    add	w5,	w12,	w4
    asr	w6,	w5,	#1
    lsl	w8,	w6,	#1
    sub	w5,	w12,	w8
    sub	w6,	w0,	w5
    cmp	w5,	#0
    csel	w22,	w6,	w5,	lt
    str	w22,	[sp, #172]

    asr	w6,	w12,	#31
    lsr	w8,	w6,	#31
    add	w18,	w12,	w8
    asr	w17,	w18,	#1
    asr	w12,	w17,	#31
    lsr	w14,	w12,	#31
    add	w15,	w17,	w14
    asr	w0,	w15,	#1
    lsl	w3,	w0,	#1
    movz	w0,	#0
    sub	w12,	w17,	w3
    sub	w15,	w0,	w12
    cmp	w12,	#0
    asr	w18,	w17,	#31
    csel	w4,	w15,	w12,	lt
    str	w4,	[sp, #160]

    lsr	w19,	w18,	#31
    add	w24,	w17,	w19
    asr	w21,	w24,	#1
    movz	w24,	#0
    asr	w19,	w21,	#31
    lsr	w20,	w19,	#31
    add	w23,	w21,	w20
    asr	w1,	w23,	#1
    lsl	w3,	w1,	#1
    sub	w17,	w21,	w3
    sub	w20,	w24,	w17
    cmp	w17,	#0
    asr	w24,	w21,	#31
    csel	w3,	w20,	w17,	lt
    str	w3,	[sp, #156]

    movz	w20,	#0
    lsr	w25,	w24,	#31
    add	w4,	w21,	w25
    asr	w1,	w4,	#1
    asr	w27,	w1,	#31
    lsr	w0,	w27,	#31
    add	w4,	w1,	w0
    asr	w23,	w4,	#1
    lsl	w24,	w23,	#1
    sub	w25,	w1,	w24
    sub	w27,	w20,	w25
    cmp	w25,	#0
    movz	w16,	#0
    asr	w5,	w1,	#31
    csel	w9,	w27,	w25,	lt
    lsr	w6,	w5,	#31
    str	w9,	[sp, #140]

    add	w8,	w1,	w6
    asr	w5,	w8,	#1
    asr	w10,	w5,	#31
    lsr	w12,	w10,	#31
    add	w14,	w5,	w12
    asr	w3,	w14,	#1
    lsl	w4,	w3,	#1
    sub	w4,	w5,	w4
    sub	w8,	w16,	w4
    cmp	w4,	#0
    csel	w13,	w8,	w4,	lt
    str	w13,	[sp, #616]

    cmp	w2,	#0
    cset	w6,	ne
    cmp	w11,	#0
    movz	w23,	#1
    mov	w22,	w23
    csel	w3,	w22,	w6,	ne
    str	w3,	[sp, #116]

    cmp	w2,	#0
    cset	w19,	ne
    mov	w20,	w19
    cmp	w11,	#0
    movz	w14,	#0
    csel	w14,	w20,	w14,	ne
    cmp	w14,	#0
    cset	w16,	eq
    cmp	w16,	#0
    ldr	w16,	[sp, #116]

    cset	w18,	ne
    cmp	w16,	#0
    movz	w21,	#0
    mov	w20,	w21
    csel	w20,	w18,	w20,	ne
    cmp	w20,	#0
    cset	w22,	ne
    cmp	w22,	#0
    cset	w24,	ne
    mov	w21,	w24
    cmp	w2,	#0
    cset	w1,	ne
    cmp	w11,	#0
    movz	w3,	#0
    mov	w2,	w3
    csel	w27,	w1,	w2,	ne
    cmp	w27,	#0
    cset	w19,	ne
    cmp	w26,	#0
    ldr	w10,	[sp, #568]

    cset	w23,	ne
    mov	w24,	w23
    cmp	w10,	#0
    movz	w11,	#1
    csel	w1,	w11,	w24,	ne
    str	w1,	[sp, #120]

    cmp	w26,	#0
    cset	w0,	ne
    ldr	w12,	[sp, #568]

    mov	w1,	w0
    cmp	w12,	#0
    movz	w11,	#0
    mov	w10,	w11
    csel	w9,	w1,	w10,	ne
    cmp	w9,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w2,	ne
    ldr	w17,	[sp, #120]

    cmp	w17,	#0
    movz	w11,	#0
    mov	w10,	w11
    csel	w11,	w2,	w10,	ne
    str	w11,	[sp, #640]

    cmp	w19,	#0
    cset	w6,	ne
    ldr	w0,	[sp, #640]

    cmp	w0,	#0
    movz	w10,	#1
    mov	w9,	w10
    csel	w6,	w9,	w6,	ne
    cmp	w19,	#0
    cset	w10,	ne
    str	w10,	[sp, #636]

    ldr	w0,	[sp, #640]

    cmp	w0,	#0
    ldr	w5,	[sp, #636]

    movz	w11,	#0
    csel	w3,	w5,	w11,	ne
    cmp	w3,	#0
    cset	w15,	eq
    cmp	w15,	#0
    cset	w17,	ne
    mov	w18,	w17
    cmp	w6,	#0
    movz	w5,	#0
    csel	w6,	w18,	w5,	ne
    str	w6,	[sp, #796]

    cmp	w26,	#0
    cset	w25,	ne
    mov	w26,	w25
    ldr	w25,	[sp, #568]

    cmp	w25,	#0
    movz	w4,	#0
    csel	w15,	w26,	w4,	ne
    cmp	w19,	#0
    cset	w12,	ne
    ldr	w18,	[sp, #640]

    cmp	w18,	#0
    movz	w25,	#0
    mov	w24,	w25
    csel	w9,	w12,	w24,	ne
    cmp	w9,	#0
    cset	w16,	ne
    cmp	w15,	#0
    movz	w23,	#1
    csel	w11,	w23,	w16,	ne
    cmp	w7,	#0
    ldr	w27,	[sp, #764]

    cset	w20,	ne
    mov	w22,	w20
    cmp	w27,	#0
    movz	w19,	#1
    csel	w12,	w19,	w22,	ne
    cmp	w7,	#0
    cset	w26,	ne
    ldr	w28,	[sp, #764]

    mov	w27,	w26
    cmp	w28,	#0
    movz	w18,	#0
    csel	w25,	w27,	w18,	ne
    cmp	w25,	#0
    cset	w1,	eq
    cmp	w1,	#0
    cset	w1,	ne
    cmp	w12,	#0
    movz	w19,	#0
    mov	w18,	w19
    csel	w28,	w1,	w18,	ne
    cmp	w11,	#0
    cset	w5,	ne
    cmp	w28,	#0
    movz	w18,	#1
    mov	w17,	w18
    csel	w18,	w17,	w5,	ne
    cmp	w11,	#0
    cset	w3,	ne
    str	w3,	[sp, #124]

    cmp	w28,	#0
    ldr	w8,	[sp, #124]

    movz	w1,	#0
    csel	w14,	w8,	w1,	ne
    cmp	w14,	#0
    cset	w14,	eq
    cmp	w14,	#0
    cset	w16,	ne
    mov	w17,	w16
    cmp	w18,	#0
    movz	w14,	#0
    csel	w22,	w17,	w14,	ne
    str	w22,	[sp, #596]

    cmp	w7,	#0
    ldr	w3,	[sp, #764]

    cset	w19,	ne
    mov	w20,	w19
    cmp	w3,	#0
    movz	w12,	#0
    csel	w6,	w20,	w12,	ne
    cmp	w11,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w28,	#0
    movz	w11,	#0
    csel	w14,	w26,	w11,	ne
    cmp	w14,	#0
    cset	w0,	ne
    cmp	w6,	#0
    movz	w11,	#1
    csel	w26,	w11,	w0,	ne
    ldr	w0,	[sp, #732]

    cmp	w0,	#0
    ldr	w7,	[sp, #768]

    cset	w3,	ne
    cmp	w7,	#0
    movz	w11,	#1
    ldr	w1,	[sp, #732]

    mov	w10,	w11
    csel	w3,	w10,	w3,	ne
    cmp	w1,	#0
    ldr	w8,	[sp, #768]

    cset	w7,	ne
    cmp	w8,	#0
    movz	w10,	#0
    mov	w9,	w10
    csel	w28,	w7,	w9,	ne
    cmp	w28,	#0
    cset	w11,	eq
    cmp	w11,	#0
    cset	w13,	ne
    mov	w14,	w13
    cmp	w3,	#0
    movz	w7,	#0
    csel	w14,	w14,	w7,	ne
    cmp	w26,	#0
    cset	w17,	ne
    mov	w18,	w17
    cmp	w14,	#0
    movz	w6,	#1
    csel	w6,	w6,	w18,	ne
    cmp	w26,	#0
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
    cmp	w6,	#0
    movz	w5,	#0
    mov	w4,	w5
    csel	w27,	w1,	w4,	ne
    str	w27,	[sp, #604]

    ldr	w2,	[sp, #732]

    cmp	w2,	#0
    ldr	w9,	[sp, #768]

    cset	w3,	ne
    cmp	w9,	#0
    movz	w5,	#0
    mov	w4,	w5
    csel	w17,	w3,	w4,	ne
    cmp	w26,	#0
    cset	w7,	ne
    cmp	w14,	#0
    movz	w2,	#0
    csel	w0,	w7,	w2,	ne
    cmp	w0,	#0
    cset	w11,	ne
    cmp	w17,	#0
    movz	w1,	#1
    ldr	w19,	[sp, #592]

    csel	w17,	w1,	w11,	ne
    cmp	w19,	#0
    ldr	w9,	[sp, #740]

    cset	w15,	ne
    mov	w16,	w15
    cmp	w9,	#0
    movz	w0,	#1
    ldr	w20,	[sp, #592]

    csel	w14,	w0,	w16,	ne
    cmp	w20,	#0
    ldr	w10,	[sp, #740]

    cset	w19,	ne
    mov	w20,	w19
    cmp	w10,	#0
    movz	w1,	#0
    mov	w0,	w1
    csel	w23,	w20,	w0,	ne
    cmp	w23,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w27,	ne
    cmp	w14,	#0
    movz	w0,	#0
    csel	w8,	w27,	w0,	ne
    cmp	w17,	#0
    cset	w1,	ne
    cmp	w8,	#0
    movz	w28,	#1
    mov	w27,	w28
    csel	w5,	w27,	w1,	ne
    cmp	w17,	#0
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
    csel	w1,	w11,	w25,	ne
    str	w1,	[sp, #608]

    ldr	w22,	[sp, #592]

    cmp	w22,	#0
    cset	w15,	ne
    ldr	w11,	[sp, #740]

    cmp	w11,	#0
    movz	w25,	#0
    mov	w24,	w25
    csel	w1,	w15,	w24,	ne
    cmp	w17,	#0
    cset	w19,	ne
    cmp	w8,	#0
    movz	w24,	#0
    csel	w13,	w19,	w24,	ne
    cmp	w13,	#0
    cset	w25,	ne
    cmp	w1,	#0
    movz	w19,	#1
    csel	w28,	w19,	w25,	ne
    ldr	w19,	[sp, #1068]

    cmp	w19,	#0
    ldr	w12,	[sp, #772]

    cset	w0,	ne
    cmp	w12,	#0
    ldr	w20,	[sp, #1068]

    movz	w19,	#1
    csel	w12,	w19,	w0,	ne
    cmp	w20,	#0
    cset	w3,	ne
    ldr	w13,	[sp, #772]

    cmp	w13,	#0
    movz	w19,	#0
    mov	w18,	w19
    csel	w5,	w3,	w18,	ne
    cmp	w5,	#0
    cset	w7,	eq
    cmp	w7,	#0
    cset	w9,	ne
    cmp	w12,	#0
    movz	w18,	#0
    csel	w8,	w9,	w18,	ne
    cmp	w28,	#0
    cset	w13,	ne
    cmp	w8,	#0
    movz	w17,	#1
    mov	w16,	w17
    csel	w4,	w16,	w13,	ne
    cmp	w28,	#0
    cset	w17,	ne
    mov	w18,	w17
    cmp	w8,	#0
    movz	w14,	#0
    csel	w19,	w18,	w14,	ne
    cmp	w19,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w4,	#0
    movz	w13,	#0
    csel	w6,	w26,	w13,	ne
    str	w6,	[sp, #576]

    ldr	w22,	[sp, #1068]

    cmp	w22,	#0
    ldr	w14,	[sp, #772]

    cset	w0,	ne
    cmp	w14,	#0
    movz	w13,	#0
    csel	w23,	w0,	w13,	ne
    cmp	w28,	#0
    cset	w3,	ne
    cmp	w8,	#0
    movz	w13,	#0
    csel	w28,	w3,	w13,	ne
    cmp	w28,	#0
    cset	w7,	ne
    cmp	w23,	#0
    ldr	w5,	[sp, #612]

    movz	w12,	#1
    csel	w13,	w12,	w7,	ne
    cmp	w5,	#0
    ldr	w17,	[sp, #776]

    cset	w11,	ne
    cmp	w17,	#0
    ldr	w6,	[sp, #612]

    movz	w9,	#1
    csel	w10,	w9,	w11,	ne
    cmp	w6,	#0
    ldr	w18,	[sp, #776]

    cset	w15,	ne
    mov	w16,	w15
    cmp	w18,	#0
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
    csel	w9,	w7,	w4,	ne
    str	w9,	[sp, #580]

    ldr	w7,	[sp, #612]

    cmp	w7,	#0
    cset	w11,	ne
    ldr	w19,	[sp, #776]

    cmp	w19,	#0
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
    ldr	w25,	[sp, #1072]

    movz	w1,	#1
    csel	w4,	w1,	w19,	ne
    cmp	w25,	#0
    cset	w25,	ne
    ldr	w22,	[sp, #780]

    cmp	w22,	#0
    movz	w0,	#1
    ldr	w26,	[sp, #1072]

    csel	w15,	w0,	w25,	ne
    cmp	w26,	#0
    ldr	w24,	[sp, #780]

    cset	w0,	ne
    mov	w1,	w0
    cmp	w24,	#0
    movz	w0,	#0
    mov	w28,	w0
    csel	w26,	w1,	w28,	ne
    cmp	w26,	#0
    cset	w3,	eq
    cmp	w3,	#0
    cset	w5,	ne
    cmp	w15,	#0
    movz	w0,	#0
    csel	w6,	w5,	w0,	ne
    cmp	w4,	#0
    cset	w9,	ne
    cmp	w6,	#0
    movz	w28,	#1
    csel	w7,	w28,	w9,	ne
    cmp	w4,	#0
    cset	w13,	ne
    cmp	w6,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w15,	w13,	w26,	ne
    cmp	w15,	#0
    cset	w17,	eq
    cmp	w17,	#0
    cset	w19,	ne
    cmp	w7,	#0
    movz	w26,	#0
    csel	w12,	w19,	w26,	ne
    str	w12,	[sp, #584]

    ldr	w27,	[sp, #1072]

    cmp	w27,	#0
    ldr	w24,	[sp, #780]

    cset	w25,	ne
    cmp	w24,	#0
    movz	w23,	#0
    csel	w28,	w25,	w23,	ne
    cmp	w4,	#0
    cset	w0,	ne
    cmp	w6,	#0
    movz	w22,	#0
    csel	w26,	w0,	w22,	ne
    cmp	w26,	#0
    cset	w3,	ne
    cmp	w28,	#0
    ldr	w15,	[sp, #744]

    movz	w22,	#1
    csel	w24,	w22,	w3,	ne
    cmp	w15,	#0
    cset	w7,	ne
    ldr	w4,	[sp, #736]

    cmp	w4,	#0
    ldr	w16,	[sp, #744]

    movz	w20,	#1
    csel	w12,	w20,	w7,	ne
    cmp	w16,	#0
    ldr	w5,	[sp, #736]

    cset	w11,	ne
    cmp	w5,	#0
    movz	w19,	#0
    csel	w13,	w11,	w19,	ne
    cmp	w13,	#0
    cset	w15,	eq
    cmp	w15,	#0
    cset	w17,	ne
    cmp	w12,	#0
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
    str	w15,	[sp, #588]

    ldr	w17,	[sp, #744]

    cmp	w17,	#0
    ldr	w6,	[sp, #736]

    cset	w7,	ne
    cmp	w6,	#0
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
    ldr	w1,	[sp, #760]

    movz	w10,	#1
    csel	w26,	w10,	w15,	ne
    cmp	w1,	#0
    cset	w19,	ne
    ldr	w11,	[sp, #800]

    cmp	w11,	#0
    ldr	w2,	[sp, #760]

    movz	w9,	#1
    csel	w22,	w9,	w19,	ne
    cmp	w2,	#0
    cset	w25,	ne
    ldr	w12,	[sp, #800]

    cmp	w12,	#0
    movz	w8,	#0
    csel	w27,	w25,	w8,	ne
    cmp	w27,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w1,	ne
    cmp	w22,	#0
    movz	w9,	#0
    csel	w17,	w1,	w9,	ne
    cmp	w26,	#0
    cset	w5,	ne
    cmp	w17,	#0
    movz	w8,	#1
    csel	w19,	w8,	w5,	ne
    cmp	w26,	#0
    cset	w9,	ne
    mov	w10,	w9
    cmp	w17,	#0
    movz	w5,	#0
    csel	w11,	w10,	w5,	ne
    cmp	w11,	#0
    cset	w13,	eq
    cmp	w13,	#0
    cset	w15,	ne
    cmp	w19,	#0
    movz	w4,	#0
    csel	w8,	w15,	w4,	ne
    str	w8,	[sp, #792]

    ldr	w3,	[sp, #760]

    cmp	w3,	#0
    ldr	w13,	[sp, #800]

    cset	w19,	ne
    cmp	w13,	#0
    movz	w3,	#0
    csel	w3,	w19,	w3,	ne
    cmp	w26,	#0
    cset	w25,	ne
    cmp	w17,	#0
    movz	w2,	#0
    csel	w26,	w25,	w2,	ne
    cmp	w26,	#0
    cset	w0,	ne
    cmp	w3,	#0
    movz	w2,	#1
    ldr	w7,	[sp, #128]

    csel	w12,	w2,	w0,	ne
    cmp	w7,	#0
    ldr	w17,	[sp, #804]

    cset	w3,	ne
    cmp	w17,	#0
    movz	w0,	#1
    ldr	w9,	[sp, #128]

    csel	w5,	w0,	w3,	ne
    cmp	w9,	#0
    cset	w7,	ne
    ldr	w18,	[sp, #804]

    cmp	w18,	#0
    movz	w1,	#0
    csel	w1,	w7,	w1,	ne
    cmp	w1,	#0
    cset	w11,	eq
    cmp	w11,	#0
    cset	w13,	ne
    cmp	w5,	#0
    movz	w0,	#0
    csel	w2,	w13,	w0,	ne
    cmp	w12,	#0
    cset	w17,	ne
    cmp	w2,	#0
    movz	w28,	#1
    csel	w7,	w28,	w17,	ne
    cmp	w12,	#0
    cset	w23,	ne
    cmp	w2,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w25,	w23,	w26,	ne
    cmp	w25,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w0,	ne
    cmp	w7,	#0
    movz	w25,	#0
    csel	w5,	w0,	w25,	ne
    str	w5,	[sp, #788]

    ldr	w10,	[sp, #128]

    cmp	w10,	#0
    cset	w3,	ne
    ldr	w19,	[sp, #804]

    cmp	w19,	#0
    movz	w25,	#0
    csel	w18,	w3,	w25,	ne
    cmp	w12,	#0
    cset	w7,	ne
    cmp	w2,	#0
    movz	w24,	#0
    csel	w8,	w7,	w24,	ne
    cmp	w8,	#0
    cset	w11,	ne
    cmp	w18,	#0
    ldr	w28,	[sp, #172]

    movz	w22,	#1
    csel	w13,	w22,	w11,	ne
    cmp	w28,	#0
    cset	w15,	ne
    ldr	w20,	[sp, #748]

    cmp	w20,	#0
    movz	w20,	#1
    ldr	w0,	[sp, #172]

    csel	w18,	w20,	w15,	ne
    cmp	w0,	#0
    ldr	w22,	[sp, #748]

    cset	w19,	ne
    cmp	w22,	#0
    movz	w17,	#0
    csel	w19,	w19,	w17,	ne
    cmp	w19,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w27,	ne
    cmp	w18,	#0
    movz	w16,	#0
    csel	w25,	w27,	w16,	ne
    cmp	w13,	#0
    cset	w1,	ne
    cmp	w25,	#0
    movz	w17,	#1
    csel	w3,	w17,	w1,	ne
    cmp	w13,	#0
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
    csel	w2,	w11,	w15,	ne
    str	w2,	[sp, #784]

    ldr	w1,	[sp, #172]

    cmp	w1,	#0
    cset	w15,	ne
    ldr	w23,	[sp, #748]

    cmp	w23,	#0
    movz	w12,	#0
    csel	w1,	w15,	w12,	ne
    cmp	w13,	#0
    cset	w19,	ne
    cmp	w25,	#0
    movz	w11,	#0
    csel	w24,	w19,	w11,	ne
    cmp	w24,	#0
    cset	w25,	ne
    cmp	w1,	#0
    ldr	w13,	[sp, #160]

    movz	w10,	#1
    csel	w27,	w10,	w25,	ne
    cmp	w13,	#0
    cset	w0,	ne
    ldr	w18,	[sp, #624]

    cmp	w18,	#0
    movz	w10,	#1
    ldr	w16,	[sp, #160]

    csel	w0,	w10,	w0,	ne
    cmp	w16,	#0
    ldr	w19,	[sp, #624]

    cset	w3,	ne
    cmp	w19,	#0
    movz	w10,	#0
    csel	w4,	w3,	w10,	ne
    cmp	w4,	#0
    cset	w7,	eq
    cmp	w7,	#0
    cset	w9,	ne
    cmp	w0,	#0
    movz	w7,	#0
    csel	w12,	w9,	w7,	ne
    cmp	w27,	#0
    cset	w13,	ne
    cmp	w12,	#0
    movz	w6,	#1
    csel	w24,	w6,	w13,	ne
    cmp	w27,	#0
    cset	w17,	ne
    cmp	w12,	#0
    movz	w5,	#0
    csel	w14,	w17,	w5,	ne
    cmp	w14,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w25,	ne
    cmp	w24,	#0
    ldr	w23,	[sp, #160]

    movz	w4,	#0
    csel	w4,	w25,	w4,	ne
    cmp	w23,	#0
    cset	w1,	ne
    ldr	w22,	[sp, #624]

    cmp	w22,	#0
    movz	w5,	#0
    csel	w7,	w1,	w5,	ne
    cmp	w27,	#0
    cset	w3,	ne
    cmp	w12,	#0
    movz	w2,	#0
    csel	w8,	w3,	w2,	ne
    cmp	w8,	#0
    cset	w8,	ne
    cmp	w7,	#0
    ldr	w10,	[sp, #156]

    movz	w1,	#1
    csel	w11,	w1,	w8,	ne
    cmp	w10,	#0
    ldr	w27,	[sp, #572]

    cset	w12,	ne
    cmp	w27,	#0
    ldr	w16,	[sp, #156]

    movz	w0,	#1
    csel	w5,	w0,	w12,	ne
    cmp	w16,	#0
    ldr	w28,	[sp, #572]

    cset	w16,	ne
    cmp	w28,	#0
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
    ldr	w0,	[sp, #156]

    movz	w27,	#0
    csel	w2,	w8,	w27,	ne
    cmp	w0,	#0
    ldr	w3,	[sp, #572]

    cset	w13,	ne
    cmp	w3,	#0
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
    ldr	w27,	[sp, #140]

    movz	w24,	#1
    csel	w8,	w24,	w22,	ne
    cmp	w27,	#0
    ldr	w17,	[sp, #620]

    cset	w27,	ne
    cmp	w17,	#0
    ldr	w14,	[sp, #140]

    movz	w20,	#1
    csel	w1,	w20,	w27,	ne
    cmp	w14,	#0
    ldr	w19,	[sp, #620]

    cset	w5,	ne
    cmp	w19,	#0
    movz	w19,	#0
    csel	w12,	w5,	w19,	ne
    cmp	w12,	#0
    cset	w5,	eq
    cmp	w5,	#0
    cset	w7,	ne
    cmp	w1,	#0
    movz	w20,	#0
    csel	w6,	w7,	w20,	ne
    cmp	w8,	#0
    cset	w11,	ne
    cmp	w6,	#0
    movz	w18,	#1
    csel	w14,	w18,	w11,	ne
    cmp	w8,	#0
    cset	w15,	ne
    cmp	w6,	#0
    movz	w17,	#0
    csel	w26,	w15,	w17,	ne
    cmp	w26,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w22,	ne
    cmp	w14,	#0
    ldr	w0,	[sp, #140]

    movz	w15,	#0
    csel	w16,	w22,	w15,	ne
    cmp	w0,	#0
    cset	w28,	ne
    ldr	w19,	[sp, #620]

    cmp	w19,	#0
    movz	w14,	#0
    csel	w1,	w28,	w14,	ne
    cmp	w8,	#0
    cset	w5,	ne
    cmp	w6,	#0
    movz	w13,	#0
    csel	w15,	w5,	w13,	ne
    cmp	w15,	#0
    cset	w5,	ne
    cmp	w1,	#0
    ldr	w10,	[sp, #616]

    movz	w14,	#1
    csel	w25,	w14,	w5,	ne
    cmp	w10,	#0
    cset	w9,	ne
    ldr	w0,	[sp, #728]

    cmp	w0,	#0
    movz	w12,	#1
    ldr	w11,	[sp, #616]

    csel	w28,	w12,	w9,	ne
    cmp	w11,	#0
    cset	w14,	ne
    ldr	w1,	[sp, #728]

    cmp	w1,	#0
    movz	w10,	#0
    csel	w1,	w14,	w10,	ne
    cmp	w1,	#0
    cset	w17,	eq
    cmp	w17,	#0
    cset	w19,	ne
    cmp	w28,	#0
    movz	w9,	#0
    csel	w7,	w19,	w9,	ne
    cmp	w25,	#0
    cset	w26,	ne
    cmp	w7,	#0
    movz	w8,	#1
    csel	w13,	w8,	w26,	ne
    cmp	w25,	#0
    cset	w1,	ne
    cmp	w7,	#0
    movz	w7,	#0
    csel	w18,	w1,	w7,	ne
    cmp	w18,	#0
    cset	w1,	eq
    cmp	w1,	#0
    cset	w5,	ne
    cmp	w13,	#0
    ldr	w3,	[sp, #784]

    movz	w8,	#0
    ldr	w6,	[sp, #788]

    csel	w17,	w5,	w8,	ne
    ldr	w9,	[sp, #792]

    lsl	w18,	w17,	#1
    add	w19,	w18,	w16
    ldr	w16,	[sp, #588]

    lsl	w20,	w19,	#1
    add	w17,	w20,	w2
    lsl	w18,	w17,	#1
    add	w11,	w18,	w4
    lsl	w13,	w11,	#1
    add	w13,	w13,	w3
    lsl	w15,	w13,	#1
    ldr	w13,	[sp, #584]

    add	w15,	w15,	w6
    ldr	w10,	[sp, #580]

    ldr	w7,	[sp, #576]

    ldr	w2,	[sp, #608]

    lsl	w17,	w15,	#1
    ldr	w28,	[sp, #604]

    add	w17,	w17,	w9
    lsl	w19,	w17,	#1
    add	w19,	w19,	w16
    lsl	w22,	w19,	#1
    add	w23,	w22,	w13
    lsl	w25,	w23,	#1
    add	w25,	w25,	w10
    lsl	w27,	w25,	#1
    ldr	w25,	[sp, #596]

    add	w27,	w27,	w7
    ldr	w12,	[sp, #796]

    lsl	w0,	w27,	#1
    add	w0,	w0,	w2
    lsl	w0,	w0,	#1
    add	w1,	w0,	w28
    lsl	w2,	w1,	#1
    add	w3,	w2,	w25
    lsl	w4,	w3,	#1
    add	w5,	w4,	w12
    lsl	w6,	w5,	#1
    add	w0,	w6,	w21
    b	fib_1892

fib_1891:
    movz	w0,	#1

fib_1892:
    movz	w17,	#1
    ldr	x16,	[sp, #264]

    str	w17,	[x16]

    ldr	x12,	[sp, #256]

    ldr	w17,	[sp, #280]

    str	w17,	[x12]

    ldr	x12,	[sp, #272]

    add	x11,	x12,	#4
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
    movz	w0,	#102
    add	w19,	w27,	#1
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
    add	w21,	w19,	#1
    movz	w0,	#102
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


