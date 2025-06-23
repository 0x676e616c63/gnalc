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
    sub	sp, sp, #1248
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	x5,	#40763
    movz	x7,	#40763
    adrp	x12, :got:memo.lut.fib
    movz	x27,	#65535
    mov	w22,	w0
    movk	x5,	#1117,	lsl #16
    movk	x7,	#1117,	lsl #16
    lsr	w9,	w22,	#16
    eor	w1,	w22,	w9
    mul	w2,	w1,	w7
    lsr	w13,	w2,	#16
    eor	w4,	w2,	w13
    mul	w5,	w4,	w5
    lsr	w16,	w5,	#16
    eor	w10,	w5,	w16
    str	w10,	[sp, #264]

    ldr	w10,	[sp, #264]

    ldr	x12, [x12, #:got_lo12:memo.lut.fib]
    and	w17,	w10,	w27
    lsl	w18,	w17,	#3
    lsl	w20,	w18,	#0
    add	x4,	x12,	x20
    str	x4,	[sp, #256]

    ldr	x5,	[sp, #256]

    mov	x0,	x5
    str	x0,	[sp, #248]

    ldr	x1,	[sp, #248]

    ldr	w16,	[x1]

    ldr	x5,	[sp, #256]

    add	x3,	x5,	#8
    cmp	w16,	#0
    beq	fib_25

fib_17:
    ldr	w20,	[x3]

    ldr	w26,	[sp, #264]

    cmp	w20,	w26
    bne	fib_27

fib_21:
    ldr	x7,	[sp, #256]

    add	x1,	x7,	#4
    ldr	w0,	[x1]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #1248
    ret


fib_27:
    mov	x26,	x3
    str	x26,	[sp, #240]

    b	fib_28

fib_25:
    mov	x27,	x3
    str	x27,	[sp, #240]


fib_28:
    cmp	w22,	#2
    ble	fib_1891

fib_31:
    asr	w24,	w22,	#31
    movz	w21,	#0
    lsr	w0,	w24,	#31
    add	w25,	w22,	w0
    asr	w23,	w25,	#1
    lsl	w24,	w23,	#1
    sub	w25,	w22,	w24
    str	w25,	[sp, #216]

    ldr	w0,	[sp, #216]

    sub	w27,	w21,	w0
    str	w27,	[sp, #552]

    ldr	w27,	[sp, #216]

    cmp	w27,	#0
    ldr	w0,	[sp, #552]

    asr	w26,	w22,	#31
    ldr	w28,	[sp, #216]

    lsr	w27,	w26,	#31
    csel	w20,	w0,	w28,	lt
    movz	w26,	#0
    str	w20,	[sp, #344]

    add	w28,	w22,	w27
    asr	w24,	w28,	#1
    asr	w0,	w24,	#31
    lsr	w19,	w0,	#31
    add	w20,	w24,	w19
    asr	w0,	w20,	#1
    lsl	w19,	w0,	#1
    sub	w28,	w24,	w19
    str	w28,	[sp, #224]

    ldr	w19,	[sp, #224]

    sub	w0,	w26,	w19
    str	w0,	[sp, #568]

    ldr	w19,	[sp, #224]

    cmp	w19,	#0
    ldr	w28,	[sp, #568]

    ldr	w20,	[sp, #224]

    csel	w20,	w28,	w20,	lt
    str	w20,	[sp, #1212]

    asr	w20,	w24,	#31
    lsr	w21,	w20,	#31
    add	w0,	w24,	w21
    asr	w21,	w0,	#1
    asr	w0,	w21,	#31
    lsr	w25,	w0,	#31
    add	w27,	w21,	w25
    asr	w25,	w27,	#1
    lsl	w27,	w25,	#1
    sub	w0,	w21,	w27
    str	w0,	[sp, #228]

    movz	w0,	#0
    ldr	w18,	[sp, #228]

    sub	w0,	w0,	w18
    str	w0,	[sp, #584]

    ldr	w27,	[sp, #228]

    cmp	w27,	#0
    ldr	w20,	[sp, #584]

    asr	w26,	w21,	#31
    ldr	w28,	[sp, #228]

    lsr	w27,	w26,	#31
    csel	w24,	w20,	w28,	lt
    str	w24,	[sp, #1216]

    add	w28,	w21,	w27
    asr	w25,	w28,	#1
    asr	w0,	w25,	#31
    lsr	w18,	w0,	#31
    movz	w0,	#0
    add	w19,	w25,	w18
    asr	w19,	w19,	#1
    lsl	w20,	w19,	#1
    sub	w27,	w25,	w20
    str	w27,	[sp, #236]

    ldr	w21,	[sp, #236]

    sub	w0,	w0,	w21
    str	w0,	[sp, #596]

    ldr	w18,	[sp, #236]

    cmp	w18,	#0
    ldr	w27,	[sp, #596]

    ldr	w19,	[sp, #236]

    csel	w28,	w27,	w19,	lt
    str	w28,	[sp, #340]

    asr	w19,	w25,	#31
    lsr	w21,	w19,	#31
    movz	w19,	#0
    add	w0,	w25,	w21
    asr	w0,	w0,	#1
    asr	w23,	w0,	#31
    lsr	w24,	w23,	#31
    add	w25,	w0,	w24
    asr	w26,	w25,	#1
    lsl	w27,	w26,	#1
    sub	w21,	w0,	w27
    str	w21,	[sp, #232]

    ldr	w26,	[sp, #232]

    sub	w22,	w19,	w26
    str	w22,	[sp, #196]

    ldr	w23,	[sp, #232]

    cmp	w23,	#0
    ldr	w20,	[sp, #196]

    ldr	w24,	[sp, #232]

    csel	w24,	w20,	w24,	lt
    str	w24,	[sp, #348]

    asr	w24,	w0,	#31
    lsr	w25,	w24,	#31
    add	w26,	w0,	w25
    movz	w0,	#0
    asr	w26,	w26,	#1
    asr	w27,	w26,	#31
    lsr	w28,	w27,	#31
    add	w18,	w26,	w28
    asr	w27,	w18,	#1
    lsl	w28,	w27,	#1
    sub	w21,	w26,	w28
    str	w21,	[sp, #220]

    ldr	w24,	[sp, #220]

    sub	w24,	w0,	w24
    str	w24,	[sp, #208]

    ldr	w23,	[sp, #220]

    cmp	w23,	#0
    ldr	w27,	[sp, #208]

    asr	w18,	w26,	#31
    ldr	w0,	[sp, #220]

    lsr	w19,	w18,	#31
    csel	w28,	w27,	w0,	lt
    str	w28,	[sp, #352]

    add	w0,	w26,	w19
    asr	w0,	w0,	#1
    asr	w23,	w0,	#31
    lsr	w25,	w23,	#31
    add	w26,	w0,	w25
    asr	w23,	w26,	#1
    lsl	w25,	w23,	#1
    sub	w19,	w0,	w25
    movz	w25,	#0
    str	w19,	[sp, #212]

    ldr	w20,	[sp, #212]

    sub	w26,	w25,	w20
    str	w26,	[sp, #200]

    ldr	w21,	[sp, #212]

    cmp	w21,	#0
    asr	w27,	w0,	#31
    movz	w23,	#0
    ldr	w26,	[sp, #200]

    lsr	w18,	w27,	#31
    ldr	w22,	[sp, #212]

    csel	w20,	w26,	w22,	lt
    add	w0,	w0,	w18
    str	w20,	[sp, #356]

    asr	w22,	w0,	#1
    asr	w27,	w22,	#31
    lsr	w28,	w27,	#31
    add	w0,	w22,	w28
    asr	w27,	w0,	#1
    lsl	w28,	w27,	#1
    sub	w0,	w22,	w28
    str	w0,	[sp, #204]

    ldr	w0,	[sp, #204]

    sub	w21,	w23,	w0
    str	w21,	[sp, #600]

    ldr	w19,	[sp, #204]

    cmp	w19,	#0
    asr	w28,	w22,	#31
    ldr	w23,	[sp, #600]

    ldr	w18,	[sp, #204]

    lsr	w0,	w28,	#31
    csel	w24,	w23,	w18,	lt
    str	w24,	[sp, #824]

    add	w26,	w22,	w0
    asr	w26,	w26,	#1
    asr	w28,	w26,	#31
    lsr	w0,	w28,	#31
    add	w20,	w26,	w0
    asr	w28,	w20,	#1
    lsl	w0,	w28,	#1
    sub	w25,	w26,	w0
    movz	w0,	#0
    str	w25,	[sp, #604]

    ldr	w24,	[sp, #604]

    sub	w0,	w0,	w24
    str	w0,	[sp, #588]

    ldr	w28,	[sp, #604]

    cmp	w28,	#0
    ldr	w18,	[sp, #588]

    asr	w0,	w26,	#31
    ldr	w27,	[sp, #604]

    csel	w28,	w18,	w27,	lt
    movz	w18,	#0
    str	w28,	[sp, #828]

    lsr	w28,	w0,	#31
    add	w27,	w26,	w28
    asr	w27,	w27,	#1
    asr	w20,	w27,	#31
    lsr	w0,	w20,	#31
    add	w28,	w27,	w0
    asr	w28,	w28,	#1
    lsl	w0,	w28,	#1
    sub	w21,	w27,	w0
    str	w21,	[sp, #592]

    ldr	w0,	[sp, #592]

    sub	w0,	w18,	w0
    str	w0,	[sp, #576]

    ldr	w23,	[sp, #592]

    cmp	w23,	#0
    ldr	w25,	[sp, #576]

    asr	w0,	w27,	#31
    movz	w26,	#0
    ldr	w20,	[sp, #592]

    csel	w21,	w25,	w20,	lt
    lsr	w20,	w0,	#31
    str	w21,	[sp, #836]

    add	w18,	w27,	w20
    asr	w0,	w18,	#1
    asr	w25,	w0,	#31
    lsr	w28,	w25,	#31
    add	w21,	w0,	w28
    asr	w25,	w21,	#1
    lsl	w28,	w25,	#1
    sub	w28,	w0,	w28
    str	w28,	[sp, #580]

    ldr	w24,	[sp, #580]

    sub	w21,	w26,	w24
    str	w21,	[sp, #564]

    ldr	w20,	[sp, #580]

    cmp	w20,	#0
    asr	w18,	w0,	#31
    ldr	w22,	[sp, #564]

    ldr	w27,	[sp, #580]

    lsr	w25,	w18,	#31
    csel	w28,	w22,	w27,	lt
    str	w28,	[sp, #144]

    add	w0,	w0,	w25
    asr	w22,	w0,	#1
    asr	w20,	w22,	#31
    lsr	w0,	w20,	#31
    add	w25,	w22,	w0
    asr	w25,	w25,	#1
    lsl	w0,	w25,	#1
    sub	w25,	w22,	w0
    movz	w0,	#0
    str	w25,	[sp, #572]

    ldr	w19,	[sp, #572]

    sub	w18,	w0,	w19
    str	w18,	[sp, #556]

    ldr	w27,	[sp, #572]

    cmp	w27,	#0
    ldr	w19,	[sp, #556]

    asr	w0,	w22,	#31
    movz	w18,	#0
    ldr	w20,	[sp, #572]

    csel	w24,	w19,	w20,	lt
    str	w24,	[sp, #192]

    lsr	w20,	w0,	#31
    add	w23,	w22,	w20
    asr	w20,	w23,	#1
    mov	w23,	w18
    asr	w25,	w20,	#31
    lsr	w0,	w25,	#31
    add	w21,	w20,	w0
    asr	w25,	w21,	#1
    lsl	w0,	w25,	#1
    sub	w0,	w20,	w0
    str	w0,	[sp, #560]

    ldr	w26,	[sp, #560]

    sub	w27,	w23,	w26
    str	w27,	[sp, #544]

    ldr	w24,	[sp, #560]

    cmp	w24,	#0
    ldr	w28,	[sp, #544]

    ldr	w26,	[sp, #560]

    csel	w0,	w28,	w26,	lt
    str	w0,	[sp, #464]

    asr	w0,	w20,	#31
    lsr	w25,	w0,	#31
    add	w26,	w20,	w25
    asr	w18,	w26,	#1
    movz	w26,	#0
    asr	w21,	w18,	#31
    lsr	w0,	w21,	#31
    add	w28,	w18,	w0
    asr	w28,	w28,	#1
    lsl	w0,	w28,	#1
    sub	w19,	w18,	w0
    str	w19,	[sp, #548]

    ldr	w21,	[sp, #548]

    sub	w28,	w26,	w21
    str	w28,	[sp, #536]

    ldr	w21,	[sp, #548]

    cmp	w21,	#0
    ldr	w0,	[sp, #536]

    ldr	w24,	[sp, #548]

    csel	w19,	w0,	w24,	lt
    asr	w0,	w18,	#31
    str	w19,	[sp, #492]

    lsr	w21,	w0,	#31
    add	w27,	w18,	w21
    asr	w26,	w27,	#1
    asr	w24,	w26,	#31
    lsr	w0,	w24,	#31
    add	w20,	w26,	w0
    asr	w24,	w20,	#1
    lsl	w0,	w24,	#1
    sub	w20,	w26,	w0
    movz	w0,	#0
    str	w20,	[sp, #540]

    ldr	w22,	[sp, #540]

    sub	w0,	w0,	w22
    str	w0,	[sp, #528]

    ldr	w0,	[sp, #540]

    cmp	w0,	#0
    ldr	w18,	[sp, #528]

    asr	w0,	w26,	#31
    ldr	w24,	[sp, #540]

    csel	w23,	w18,	w24,	lt
    str	w23,	[sp, #512]

    lsr	w24,	w0,	#31
    add	w18,	w26,	w24
    asr	w27,	w18,	#1
    movz	w18,	#0
    asr	w0,	w27,	#31
    lsr	w23,	w0,	#31
    add	w26,	w27,	w23
    asr	w0,	w26,	#1
    lsl	w23,	w0,	#1
    sub	w21,	w27,	w23
    str	w21,	[sp, #532]

    ldr	w22,	[sp, #532]

    sub	w25,	w18,	w22
    str	w25,	[sp, #524]

    ldr	w23,	[sp, #532]

    cmp	w23,	#0
    ldr	w26,	[sp, #524]

    ldr	w23,	[sp, #532]

    csel	w20,	w26,	w23,	lt
    str	w20,	[sp, #508]

    ldr	w21,	[sp, #344]

    cmp	w21,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w18,	#0
    cset	w0,	eq
    mov	w23,	w0
    cmp	w23,	#0
    cset	w26,	ne
    mov	w27,	w26
    cmp	w27,	#0
    cset	w18,	ne
    mov	w0,	w18
    cmp	w0,	#0
    cset	w23,	ne
    mov	w27,	w23
    str	w27,	[sp, #516]

    ldr	w22,	[sp, #344]

    cmp	w22,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	ne
    mov	w25,	w0
    str	w25,	[sp, #684]

    ldr	w21,	[sp, #1212]

    cmp	w21,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	ne
    mov	w24,	w28
    str	w24,	[sp, #96]

    ldr	w26,	[sp, #684]

    cmp	w26,	#0
    ldr	w21,	[sp, #96]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w21,	#0
    movz	w22,	#1
    mov	w18,	w22
    csel	w21,	w18,	w24,	ne
    str	w21,	[sp, #608]

    ldr	w27,	[sp, #684]

    cmp	w27,	#0
    cset	w0,	ne
    ldr	w28,	[sp, #96]

    mov	w20,	w0
    cmp	w28,	#0
    movz	w0,	#0
    csel	w20,	w20,	w0,	ne
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	ne
    ldr	w0,	[sp, #608]

    mov	w20,	w28
    cmp	w0,	#0
    movz	w26,	#0
    mov	w18,	w26
    csel	w26,	w20,	w18,	ne
    str	w26,	[sp, #500]

    ldr	w22,	[sp, #1212]

    cmp	w22,	#0
    ldr	w21,	[sp, #684]

    cset	w28,	ne
    mov	w19,	w28
    cmp	w21,	#0
    cset	w18,	ne
    ldr	w28,	[sp, #96]

    mov	w21,	w18
    cmp	w28,	#0
    movz	w28,	#0
    mov	w0,	w28
    csel	w18,	w21,	w0,	ne
    cmp	w18,	#0
    cset	w0,	ne
    mov	w26,	w0
    cmp	w19,	#0
    movz	w0,	#1
    csel	w24,	w0,	w26,	ne
    str	w24,	[sp, #140]

    ldr	w25,	[sp, #1216]

    cmp	w25,	#0
    cset	w0,	ne
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	ne
    mov	w18,	w0
    str	w18,	[sp, #688]

    ldr	w25,	[sp, #140]

    cmp	w25,	#0
    ldr	w24,	[sp, #688]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w24,	#0
    movz	w26,	#1
    mov	w18,	w26
    csel	w28,	w18,	w20,	ne
    str	w28,	[sp, #1132]

    ldr	w26,	[sp, #140]

    cmp	w26,	#0
    ldr	w25,	[sp, #688]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w25,	#0
    movz	w18,	#0
    mov	w26,	w18
    csel	w24,	w20,	w26,	ne
    cmp	w24,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	ne
    ldr	w18,	[sp, #1132]

    mov	w25,	w0
    cmp	w18,	#0
    movz	w28,	#0
    mov	w0,	w28
    csel	w18,	w25,	w0,	ne
    str	w18,	[sp, #476]

    ldr	w26,	[sp, #1216]

    cmp	w26,	#0
    cset	w0,	ne
    ldr	w27,	[sp, #140]

    mov	w24,	w0
    cmp	w27,	#0
    cset	w22,	ne
    mov	w0,	w22
    ldr	w22,	[sp, #688]

    cmp	w22,	#0
    movz	w26,	#0
    csel	w22,	w0,	w26,	ne
    cmp	w22,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w24,	#0
    movz	w23,	#1
    mov	w26,	w23
    csel	w28,	w26,	w18,	ne
    str	w28,	[sp, #844]

    ldr	w0,	[sp, #340]

    cmp	w0,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	ne
    mov	w26,	w28
    str	w26,	[sp, #884]

    ldr	w0,	[sp, #844]

    cmp	w0,	#0
    ldr	w20,	[sp, #884]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w20,	#0
    movz	w0,	#1
    csel	w25,	w0,	w24,	ne
    str	w25,	[sp, #840]

    ldr	w18,	[sp, #844]

    cmp	w18,	#0
    cset	w0,	ne
    ldr	w21,	[sp, #884]

    mov	w24,	w0
    cmp	w21,	#0
    movz	w18,	#0
    mov	w22,	w18
    csel	w20,	w24,	w22,	ne
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    ldr	w0,	[sp, #840]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w0,	#0
    movz	w18,	#0
    mov	w26,	w18
    csel	w0,	w20,	w26,	ne
    str	w0,	[sp, #184]

    ldr	w18,	[sp, #340]

    cmp	w18,	#0
    cset	w28,	ne
    ldr	w23,	[sp, #844]

    mov	w20,	w28
    cmp	w23,	#0
    cset	w0,	ne
    ldr	w19,	[sp, #884]

    mov	w26,	w0
    cmp	w19,	#0
    movz	w0,	#0
    csel	w18,	w26,	w0,	ne
    cmp	w18,	#0
    cset	w0,	ne
    mov	w26,	w0
    cmp	w20,	#0
    movz	w18,	#1
    mov	w22,	w18
    csel	w28,	w22,	w26,	ne
    str	w28,	[sp, #716]

    ldr	w25,	[sp, #348]

    cmp	w25,	#0
    cset	w0,	ne
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	ne
    mov	w22,	w0
    str	w22,	[sp, #820]

    ldr	w0,	[sp, #716]

    cmp	w0,	#0
    ldr	w21,	[sp, #820]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w21,	#0
    movz	w18,	#1
    mov	w26,	w18
    csel	w21,	w26,	w20,	ne
    str	w21,	[sp, #848]

    ldr	w18,	[sp, #716]

    cmp	w18,	#0
    cset	w28,	ne
    ldr	w22,	[sp, #820]

    mov	w20,	w28
    cmp	w22,	#0
    movz	w0,	#0
    csel	w24,	w20,	w0,	ne
    cmp	w24,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    ldr	w26,	[sp, #848]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w26,	#0
    movz	w18,	#0
    mov	w22,	w18
    csel	w18,	w24,	w22,	ne
    str	w18,	[sp, #172]

    ldr	w26,	[sp, #348]

    cmp	w26,	#0
    cset	w0,	ne
    ldr	w24,	[sp, #716]

    cmp	w24,	#0
    ldr	w25,	[sp, #820]

    cset	w19,	ne
    mov	w23,	w19
    cmp	w25,	#0
    movz	w21,	#0
    mov	w18,	w21
    csel	w23,	w23,	w18,	ne
    cmp	w23,	#0
    cset	w19,	ne
    mov	w23,	w19
    cmp	w0,	#0
    movz	w0,	#1
    csel	w24,	w0,	w23,	ne
    str	w24,	[sp, #724]

    ldr	w0,	[sp, #352]

    cmp	w0,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	ne
    mov	w27,	w28
    str	w27,	[sp, #1184]

    ldr	w25,	[sp, #724]

    cmp	w25,	#0
    ldr	w26,	[sp, #1184]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w26,	#0
    movz	w18,	#1
    mov	w22,	w18
    csel	w24,	w22,	w24,	ne
    str	w24,	[sp, #708]

    ldr	w26,	[sp, #724]

    cmp	w26,	#0
    ldr	w27,	[sp, #1184]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w27,	#0
    movz	w22,	#0
    mov	w18,	w22
    csel	w20,	w24,	w18,	ne
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	ne
    ldr	w0,	[sp, #708]

    mov	w20,	w28
    cmp	w0,	#0
    movz	w0,	#0
    csel	w27,	w20,	w0,	ne
    str	w27,	[sp, #128]

    ldr	w18,	[sp, #352]

    cmp	w18,	#0
    ldr	w21,	[sp, #724]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w21,	#0
    cset	w18,	ne
    ldr	w19,	[sp, #1184]

    mov	w0,	w18
    cmp	w19,	#0
    movz	w18,	#0
    csel	w18,	w0,	w18,	ne
    cmp	w18,	#0
    cset	w0,	ne
    mov	w26,	w0
    cmp	w20,	#0
    movz	w22,	#1
    mov	w18,	w22
    csel	w26,	w18,	w26,	ne
    str	w26,	[sp, #1104]

    ldr	w21,	[sp, #356]

    cmp	w21,	#0
    cset	w0,	ne
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	ne
    mov	w20,	w0
    str	w20,	[sp, #1188]

    ldr	w27,	[sp, #1104]

    cmp	w27,	#0
    ldr	w19,	[sp, #1188]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w19,	#0
    movz	w0,	#1
    csel	w21,	w0,	w20,	ne
    str	w21,	[sp, #720]

    ldr	w28,	[sp, #1104]

    cmp	w28,	#0
    ldr	w21,	[sp, #1188]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w21,	#0
    movz	w26,	#0
    mov	w18,	w26
    csel	w24,	w20,	w18,	ne
    cmp	w24,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    ldr	w27,	[sp, #720]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w27,	#0
    movz	w22,	#0
    mov	w18,	w22
    csel	w22,	w24,	w18,	ne
    str	w22,	[sp, #1124]

    ldr	w22,	[sp, #356]

    cmp	w22,	#0
    cset	w0,	ne
    ldr	w26,	[sp, #1104]

    mov	w24,	w0
    cmp	w26,	#0
    cset	w18,	ne
    ldr	w25,	[sp, #1188]

    mov	w22,	w18
    cmp	w25,	#0
    movz	w0,	#0
    csel	w22,	w22,	w0,	ne
    cmp	w22,	#0
    cset	w18,	ne
    mov	w22,	w18
    cmp	w24,	#0
    movz	w26,	#1
    mov	w18,	w26
    csel	w19,	w18,	w22,	ne
    str	w19,	[sp, #1136]

    ldr	w25,	[sp, #824]

    cmp	w25,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	ne
    mov	w26,	w28
    str	w26,	[sp, #700]

    ldr	w20,	[sp, #1136]

    cmp	w20,	#0
    cset	w0,	ne
    ldr	w22,	[sp, #700]

    mov	w24,	w0
    cmp	w22,	#0
    movz	w22,	#1
    mov	w18,	w22
    csel	w0,	w18,	w24,	ne
    str	w0,	[sp, #728]

    ldr	w21,	[sp, #1136]

    cmp	w21,	#0
    ldr	w23,	[sp, #700]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w23,	#0
    movz	w0,	#0
    csel	w20,	w24,	w0,	ne
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	ne
    ldr	w24,	[sp, #728]

    mov	w20,	w28
    cmp	w24,	#0
    movz	w26,	#0
    mov	w18,	w26
    csel	w19,	w20,	w18,	ne
    str	w19,	[sp, #1116]

    ldr	w26,	[sp, #824]

    cmp	w26,	#0
    cset	w28,	ne
    mov	w21,	w28
    str	w21,	[sp, #896]

    ldr	w22,	[sp, #1136]

    cmp	w22,	#0
    ldr	w25,	[sp, #700]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w25,	#0
    movz	w22,	#0
    mov	w18,	w22
    csel	w20,	w24,	w18,	ne
    cmp	w20,	#0
    ldr	w28,	[sp, #896]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w28,	#0
    movz	w0,	#1
    csel	w19,	w0,	w24,	ne
    str	w19,	[sp, #1040]

    ldr	w0,	[sp, #828]

    cmp	w0,	#0
    cset	w0,	ne
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	ne
    mov	w25,	w0
    str	w25,	[sp, #1192]

    ldr	w20,	[sp, #1040]

    cmp	w20,	#0
    ldr	w25,	[sp, #1192]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w25,	#0
    movz	w26,	#1
    mov	w18,	w26
    csel	w24,	w18,	w20,	ne
    str	w24,	[sp, #1088]

    ldr	w21,	[sp, #1040]

    cmp	w21,	#0
    ldr	w26,	[sp, #1192]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w26,	#0
    movz	w18,	#0
    mov	w26,	w18
    csel	w24,	w20,	w26,	ne
    cmp	w24,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    ldr	w20,	[sp, #1088]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w20,	#0
    movz	w0,	#0
    csel	w28,	w24,	w0,	ne
    str	w28,	[sp, #1112]

    ldr	w18,	[sp, #828]

    cmp	w18,	#0
    ldr	w19,	[sp, #1040]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w19,	#0
    ldr	w19,	[sp, #1192]

    cset	w22,	ne
    mov	w0,	w22
    cmp	w19,	#0
    movz	w26,	#0
    csel	w22,	w0,	w26,	ne
    cmp	w22,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w24,	#0
    movz	w23,	#1
    mov	w26,	w23
    csel	w24,	w26,	w18,	ne
    str	w24,	[sp, #1140]

    ldr	w22,	[sp, #836]

    cmp	w22,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	ne
    mov	w19,	w28
    str	w19,	[sp, #704]

    ldr	w25,	[sp, #1140]

    cmp	w25,	#0
    ldr	w28,	[sp, #704]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w28,	#0
    movz	w0,	#1
    csel	w24,	w0,	w24,	ne
    str	w24,	[sp, #1044]

    ldr	w26,	[sp, #1140]

    cmp	w26,	#0
    cset	w0,	ne
    mov	w24,	w0
    ldr	w0,	[sp, #704]

    cmp	w0,	#0
    movz	w18,	#0
    mov	w22,	w18
    csel	w20,	w24,	w22,	ne
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	ne
    ldr	w23,	[sp, #1044]

    mov	w20,	w28
    cmp	w23,	#0
    movz	w18,	#0
    mov	w26,	w18
    csel	w25,	w20,	w26,	ne
    str	w25,	[sp, #1128]

    ldr	w23,	[sp, #836]

    cmp	w23,	#0
    ldr	w0,	[sp, #1140]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w0,	#0
    cset	w0,	ne
    ldr	w18,	[sp, #704]

    mov	w26,	w0
    cmp	w18,	#0
    movz	w0,	#0
    csel	w18,	w26,	w0,	ne
    cmp	w18,	#0
    cset	w0,	ne
    mov	w26,	w0
    cmp	w20,	#0
    movz	w18,	#1
    mov	w22,	w18
    csel	w0,	w22,	w26,	ne
    str	w0,	[sp, #1144]

    ldr	w18,	[sp, #144]

    cmp	w18,	#0
    cset	w0,	ne
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	ne
    mov	w24,	w0
    str	w24,	[sp, #812]

    ldr	w18,	[sp, #1144]

    cmp	w18,	#0
    cset	w28,	ne
    ldr	w22,	[sp, #812]

    mov	w20,	w28
    cmp	w22,	#0
    movz	w18,	#1
    mov	w26,	w18
    csel	w27,	w26,	w20,	ne
    str	w27,	[sp, #1048]

    ldr	w19,	[sp, #1144]

    cmp	w19,	#0
    cset	w28,	ne
    ldr	w23,	[sp, #812]

    mov	w20,	w28
    cmp	w23,	#0
    movz	w0,	#0
    csel	w24,	w20,	w0,	ne
    cmp	w24,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    ldr	w26,	[sp, #1048]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w26,	#0
    movz	w18,	#0
    mov	w22,	w18
    csel	w18,	w24,	w22,	ne
    str	w18,	[sp, #1080]

    ldr	w19,	[sp, #144]

    cmp	w19,	#0
    cset	w0,	ne
    ldr	w23,	[sp, #1144]

    cmp	w23,	#0
    cset	w19,	ne
    ldr	w25,	[sp, #812]

    mov	w23,	w19
    cmp	w25,	#0
    movz	w21,	#0
    mov	w18,	w21
    csel	w23,	w23,	w18,	ne
    cmp	w23,	#0
    cset	w19,	ne
    mov	w23,	w19
    cmp	w0,	#0
    movz	w0,	#1
    csel	w22,	w0,	w23,	ne
    str	w22,	[sp, #268]

    ldr	w25,	[sp, #192]

    cmp	w25,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	ne
    mov	w0,	w28
    str	w0,	[sp, #816]

    ldr	w23,	[sp, #268]

    cmp	w23,	#0
    ldr	w27,	[sp, #816]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w27,	#0
    movz	w18,	#1
    mov	w22,	w18
    csel	w18,	w22,	w24,	ne
    str	w18,	[sp, #1052]

    ldr	w24,	[sp, #268]

    cmp	w24,	#0
    cset	w0,	ne
    ldr	w28,	[sp, #816]

    mov	w24,	w0
    cmp	w28,	#0
    movz	w22,	#0
    mov	w18,	w22
    csel	w20,	w24,	w18,	ne
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    ldr	w0,	[sp, #1052]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w0,	#0
    movz	w0,	#0
    csel	w27,	w20,	w0,	ne
    str	w27,	[sp, #1092]

    ldr	w26,	[sp, #192]

    cmp	w26,	#0
    cset	w28,	ne
    mov	w24,	w28
    str	w24,	[sp, #900]

    ldr	w25,	[sp, #268]

    cmp	w25,	#0
    cset	w0,	ne
    mov	w24,	w0
    ldr	w0,	[sp, #816]

    cmp	w0,	#0
    movz	w18,	#0
    mov	w22,	w18
    csel	w20,	w24,	w22,	ne
    cmp	w20,	#0
    cset	w0,	ne
    ldr	w19,	[sp, #900]

    mov	w24,	w0
    cmp	w19,	#0
    movz	w22,	#1
    mov	w18,	w22
    csel	w23,	w18,	w24,	ne
    str	w23,	[sp, #1108]

    ldr	w18,	[sp, #464]

    cmp	w18,	#0
    cset	w0,	ne
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	ne
    mov	w27,	w0
    str	w27,	[sp, #904]

    ldr	w24,	[sp, #1108]

    cmp	w24,	#0
    ldr	w23,	[sp, #904]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w23,	#0
    movz	w0,	#1
    csel	w21,	w0,	w20,	ne
    str	w21,	[sp, #1056]

    ldr	w25,	[sp, #1108]

    cmp	w25,	#0
    cset	w28,	ne
    ldr	w24,	[sp, #904]

    mov	w20,	w28
    cmp	w24,	#0
    movz	w26,	#0
    mov	w18,	w26
    csel	w24,	w20,	w18,	ne
    cmp	w24,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	ne
    ldr	w20,	[sp, #1056]

    mov	w24,	w0
    cmp	w20,	#0
    movz	w22,	#0
    mov	w18,	w22
    csel	w24,	w24,	w18,	ne
    str	w24,	[sp, #1060]

    ldr	w19,	[sp, #464]

    cmp	w19,	#0
    ldr	w26,	[sp, #1108]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w26,	#0
    cset	w22,	ne
    ldr	w23,	[sp, #904]

    mov	w0,	w22
    cmp	w23,	#0
    movz	w26,	#0
    csel	w22,	w0,	w26,	ne
    cmp	w22,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w24,	#0
    movz	w26,	#1
    mov	w23,	w26
    csel	w27,	w23,	w18,	ne
    str	w27,	[sp, #1064]

    ldr	w20,	[sp, #492]

    cmp	w20,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	ne
    mov	w21,	w28
    str	w21,	[sp, #696]

    ldr	w28,	[sp, #1064]

    cmp	w28,	#0
    cset	w0,	ne
    mov	w24,	w0
    ldr	w0,	[sp, #696]

    cmp	w0,	#0
    movz	w22,	#1
    mov	w18,	w22
    csel	w20,	w18,	w24,	ne
    str	w20,	[sp, #1068]

    ldr	w0,	[sp, #1064]

    cmp	w0,	#0
    ldr	w18,	[sp, #696]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w18,	#0
    movz	w0,	#0
    csel	w20,	w24,	w0,	ne
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    ldr	w21,	[sp, #1068]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w21,	#0
    movz	w26,	#0
    mov	w18,	w26
    csel	w27,	w20,	w18,	ne
    str	w27,	[sp, #1076]

    ldr	w21,	[sp, #492]

    cmp	w21,	#0
    cset	w28,	ne
    ldr	w0,	[sp, #1064]

    mov	w20,	w28
    cmp	w0,	#0
    ldr	w19,	[sp, #696]

    cset	w18,	ne
    mov	w0,	w18
    cmp	w19,	#0
    movz	w18,	#0
    csel	w18,	w0,	w18,	ne
    cmp	w18,	#0
    cset	w0,	ne
    mov	w26,	w0
    cmp	w20,	#0
    movz	w0,	#1
    csel	w18,	w0,	w26,	ne
    str	w18,	[sp, #1096]

    ldr	w24,	[sp, #512]

    cmp	w24,	#0
    cset	w0,	ne
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	ne
    mov	w28,	w0
    str	w28,	[sp, #280]

    ldr	w19,	[sp, #1096]

    cmp	w19,	#0
    cset	w28,	ne
    ldr	w21,	[sp, #280]

    mov	w20,	w28
    cmp	w21,	#0
    movz	w26,	#1
    mov	w18,	w26
    csel	w21,	w18,	w20,	ne
    str	w21,	[sp, #120]

    ldr	w20,	[sp, #1096]

    cmp	w20,	#0
    ldr	w22,	[sp, #280]

    cset	w28,	ne
    mov	w0,	w28
    cmp	w22,	#0
    movz	w26,	#0
    mov	w19,	w26
    csel	w24,	w0,	w19,	ne
    cmp	w24,	#0
    cset	w28,	eq
    mov	w20,	w28
    cmp	w20,	#0
    ldr	w20,	[sp, #120]

    cset	w0,	ne
    mov	w24,	w0
    cmp	w20,	#0
    movz	w0,	#0
    csel	w21,	w24,	w0,	ne
    str	w21,	[sp, #1084]

    ldr	w25,	[sp, #512]

    cmp	w25,	#0
    cset	w0,	ne
    mov	w24,	w0
    ldr	w0,	[sp, #1096]

    cmp	w0,	#0
    cset	w22,	ne
    mov	w20,	w22
    ldr	w22,	[sp, #280]

    cmp	w22,	#0
    movz	w22,	#0
    csel	w22,	w20,	w22,	ne
    cmp	w22,	#0
    cset	w18,	ne
    mov	w22,	w18
    cmp	w24,	#0
    movz	w18,	#1
    mov	w26,	w18
    csel	w22,	w26,	w22,	ne
    str	w22,	[sp, #740]

    ldr	w21,	[sp, #508]

    cmp	w21,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    ldr	w0,	[sp, #740]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w0,	#0
    cset	w26,	ne
    mov	w23,	w26
    str	w23,	[sp, #124]

    cmp	w20,	#0
    ldr	w19,	[sp, #124]

    movz	w0,	#1
    csel	w19,	w0,	w19,	ne
    str	w19,	[sp, #1100]

    ldr	w18,	[sp, #740]

    cmp	w18,	#0
    cset	w18,	ne
    mov	w0,	w18
    cmp	w20,	#0
    movz	w19,	#0
    mov	w23,	w19
    csel	w20,	w0,	w23,	ne
    cmp	w20,	#0
    cset	w0,	eq
    mov	w24,	w0
    cmp	w24,	#0
    cset	w28,	ne
    ldr	w21,	[sp, #1100]

    mov	w20,	w28
    cmp	w21,	#0
    ldr	w22,	[sp, #1084]

    movz	w18,	#0
    ldr	w28,	[sp, #1076]

    mov	w26,	w18
    ldr	w25,	[sp, #1060]

    csel	w24,	w20,	w26,	ne
    lsl	w18,	w24,	#1
    add	w20,	w18,	w22
    lsl	w0,	w20,	#1
    add	w24,	w0,	w28
    ldr	w28,	[sp, #1092]

    ldr	w19,	[sp, #1080]

    lsl	w18,	w24,	#1
    ldr	w26,	[sp, #1128]

    add	w20,	w18,	w25
    lsl	w0,	w20,	#1
    add	w24,	w0,	w28
    lsl	w18,	w24,	#1
    add	w20,	w18,	w19
    lsl	w0,	w20,	#1
    add	w24,	w0,	w26
    ldr	w0,	[sp, #1112]

    lsl	w19,	w24,	#1
    add	w20,	w19,	w0
    lsl	w0,	w20,	#1
    ldr	w20,	[sp, #1116]

    add	w24,	w0,	w20
    ldr	w23,	[sp, #1124]

    ldr	w27,	[sp, #128]

    ldr	w21,	[sp, #172]

    lsl	w18,	w24,	#1
    ldr	w22,	[sp, #184]

    add	w20,	w18,	w23
    lsl	w0,	w20,	#1
    add	w24,	w0,	w27
    lsl	w28,	w24,	#1
    add	w20,	w28,	w21
    lsl	w0,	w20,	#1
    add	w24,	w0,	w22
    lsl	w28,	w24,	#1
    ldr	w24,	[sp, #476]

    add	w20,	w28,	w24
    ldr	w24,	[sp, #500]

    lsl	w0,	w20,	#1
    add	w24,	w0,	w24
    lsl	w28,	w24,	#1
    ldr	w24,	[sp, #516]

    add	w0,	w28,	w24
    bl	fib
    str	w0,	[sp, #520]

    ldr	w19,	[sp, #216]

    cmp	w19,	#0
    ldr	w0,	[sp, #552]

    ldr	w20,	[sp, #216]

    csel	w20,	w0,	w20,	lt
    ldr	w22,	[sp, #224]

    cmp	w22,	#0
    ldr	w0,	[sp, #568]

    ldr	w23,	[sp, #224]

    ldr	w19,	[sp, #228]

    csel	w23,	w0,	w23,	lt
    cmp	w19,	#0
    ldr	w18,	[sp, #584]

    ldr	w21,	[sp, #228]

    csel	w18,	w18,	w21,	lt
    str	w18,	[sp, #328]

    ldr	w26,	[sp, #236]

    cmp	w26,	#0
    ldr	w24,	[sp, #596]

    ldr	w27,	[sp, #236]

    csel	w28,	w24,	w27,	lt
    str	w28,	[sp, #336]

    ldr	w28,	[sp, #232]

    cmp	w28,	#0
    ldr	w22,	[sp, #196]

    ldr	w0,	[sp, #232]

    csel	w24,	w22,	w0,	lt
    str	w24,	[sp, #332]

    ldr	w0,	[sp, #220]

    cmp	w0,	#0
    ldr	w18,	[sp, #208]

    ldr	w28,	[sp, #220]

    csel	w26,	w18,	w28,	lt
    str	w26,	[sp, #1152]

    ldr	w22,	[sp, #212]

    cmp	w22,	#0
    ldr	w26,	[sp, #200]

    ldr	w25,	[sp, #212]

    csel	w21,	w26,	w25,	lt
    str	w21,	[sp, #1148]

    ldr	w21,	[sp, #204]

    cmp	w21,	#0
    ldr	w0,	[sp, #600]

    ldr	w22,	[sp, #204]

    csel	w18,	w0,	w22,	lt
    str	w18,	[sp, #1156]

    ldr	w0,	[sp, #604]

    cmp	w0,	#0
    ldr	w27,	[sp, #588]

    ldr	w28,	[sp, #604]

    csel	w24,	w27,	w28,	lt
    str	w24,	[sp, #1160]

    ldr	w21,	[sp, #592]

    cmp	w21,	#0
    ldr	w19,	[sp, #576]

    ldr	w18,	[sp, #592]

    csel	w28,	w19,	w18,	lt
    str	w28,	[sp, #1164]

    ldr	w0,	[sp, #580]

    cmp	w0,	#0
    ldr	w27,	[sp, #564]

    ldr	w22,	[sp, #580]

    csel	w21,	w27,	w22,	lt
    str	w21,	[sp, #1168]

    ldr	w27,	[sp, #572]

    cmp	w27,	#0
    ldr	w26,	[sp, #556]

    ldr	w19,	[sp, #572]

    csel	w22,	w26,	w19,	lt
    str	w22,	[sp, #152]

    ldr	w19,	[sp, #560]

    cmp	w19,	#0
    ldr	w18,	[sp, #544]

    ldr	w26,	[sp, #560]

    csel	w26,	w18,	w26,	lt
    str	w26,	[sp, #188]

    ldr	w27,	[sp, #548]

    cmp	w27,	#0
    ldr	w0,	[sp, #536]

    ldr	w19,	[sp, #548]

    csel	w26,	w0,	w19,	lt
    str	w26,	[sp, #472]

    ldr	w26,	[sp, #540]

    cmp	w26,	#0
    ldr	w28,	[sp, #528]

    ldr	w27,	[sp, #540]

    csel	w26,	w28,	w27,	lt
    str	w26,	[sp, #484]

    ldr	w25,	[sp, #532]

    cmp	w25,	#0
    ldr	w25,	[sp, #524]

    ldr	w22,	[sp, #532]

    csel	w0,	w25,	w22,	lt
    str	w0,	[sp, #488]

    cmp	w20,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w22,	ne
    cmp	w22,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w18,	ne
    str	w18,	[sp, #504]

    cmp	w23,	#0
    cset	w28,	ne
    cmp	w28,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w22,	ne
    cmp	w22,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w24,	ne
    str	w24,	[sp, #496]

    cmp	w23,	#0
    cset	w26,	ne
    cmp	w26,	#0
    ldr	w18,	[sp, #328]

    cset	w28,	ne
    cmp	w18,	#0
    cset	w23,	ne
    cmp	w23,	#0
    cset	w24,	eq
    cmp	w24,	#0
    cset	w19,	ne
    mov	w27,	w19
    str	w27,	[sp, #108]

    cmp	w28,	#0
    ldr	w23,	[sp, #108]

    cset	w22,	ne
    mov	w25,	w22
    cmp	w23,	#0
    movz	w0,	#1
    csel	w23,	w0,	w25,	ne
    cmp	w28,	#0
    cset	w26,	ne
    mov	w24,	w26
    str	w24,	[sp, #104]

    ldr	w19,	[sp, #108]

    cmp	w19,	#0
    movz	w26,	#0
    ldr	w19,	[sp, #104]

    mov	w27,	w26
    csel	w18,	w19,	w27,	ne
    cmp	w18,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w0,	ne
    cmp	w23,	#0
    movz	w27,	#0
    csel	w26,	w0,	w27,	ne
    str	w26,	[sp, #480]

    ldr	w19,	[sp, #328]

    cmp	w19,	#0
    cset	w26,	ne
    cmp	w28,	#0
    ldr	w27,	[sp, #108]

    cset	w18,	ne
    mov	w21,	w18
    cmp	w27,	#0
    movz	w27,	#0
    csel	w19,	w21,	w27,	ne
    cmp	w19,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w26,	#0
    movz	w24,	#1
    ldr	w21,	[sp, #336]

    csel	w18,	w24,	w22,	ne
    cmp	w21,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w28,	ne
    cmp	w18,	#0
    cset	w23,	ne
    cmp	w28,	#0
    movz	w21,	#1
    mov	w22,	w21
    csel	w27,	w22,	w23,	ne
    cmp	w18,	#0
    cset	w19,	ne
    str	w19,	[sp, #148]

    cmp	w28,	#0
    ldr	w20,	[sp, #148]

    movz	w26,	#0
    mov	w0,	w26
    csel	w26,	w20,	w0,	ne
    cmp	w26,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w23,	ne
    mov	w22,	w23
    cmp	w27,	#0
    movz	w23,	#0
    csel	w20,	w22,	w23,	ne
    str	w20,	[sp, #460]

    ldr	w27,	[sp, #336]

    cmp	w27,	#0
    cset	w27,	ne
    cmp	w18,	#0
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
    csel	w24,	w18,	w26,	ne
    str	w24,	[sp, #1172]

    ldr	w0,	[sp, #332]

    cmp	w0,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w20,	#0
    cset	w21,	eq
    mov	w0,	w21
    cmp	w0,	#0
    cset	w23,	ne
    mov	w26,	w23
    str	w26,	[sp, #304]

    ldr	w25,	[sp, #1172]

    cmp	w25,	#0
    cset	w25,	ne
    ldr	w19,	[sp, #304]

    mov	w26,	w25
    cmp	w19,	#0
    movz	w22,	#1
    mov	w19,	w22
    csel	w19,	w19,	w26,	ne
    ldr	w26,	[sp, #1172]

    cmp	w26,	#0
    ldr	w21,	[sp, #304]

    cset	w18,	ne
    mov	w20,	w18
    cmp	w21,	#0
    movz	w24,	#0
    mov	w28,	w24
    csel	w0,	w20,	w28,	ne
    cmp	w0,	#0
    cset	w23,	eq
    mov	w24,	w23
    cmp	w24,	#0
    cset	w25,	ne
    mov	w21,	w25
    cmp	w19,	#0
    movz	w20,	#0
    mov	w25,	w20
    csel	w21,	w21,	w25,	ne
    str	w21,	[sp, #176]

    ldr	w18,	[sp, #332]

    cmp	w18,	#0
    cset	w18,	ne
    ldr	w24,	[sp, #1172]

    mov	w23,	w18
    cmp	w24,	#0
    ldr	w22,	[sp, #304]

    cset	w21,	ne
    mov	w0,	w21
    cmp	w22,	#0
    movz	w26,	#0
    mov	w27,	w26
    csel	w26,	w0,	w27,	ne
    cmp	w26,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w23,	#0
    movz	w25,	#1
    mov	w24,	w25
    csel	w18,	w24,	w26,	ne
    str	w18,	[sp, #1180]

    ldr	w0,	[sp, #1152]

    cmp	w0,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w20,	#0
    cset	w21,	eq
    mov	w0,	w21
    cmp	w0,	#0
    ldr	w27,	[sp, #1180]

    cset	w23,	ne
    mov	w28,	w23
    cmp	w27,	#0
    cset	w26,	ne
    mov	w27,	w26
    cmp	w28,	#0
    movz	w0,	#1
    csel	w19,	w0,	w27,	ne
    ldr	w0,	[sp, #1180]

    cmp	w0,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w28,	#0
    movz	w18,	#0
    mov	w26,	w18
    csel	w25,	w22,	w26,	ne
    cmp	w25,	#0
    cset	w24,	eq
    mov	w25,	w24
    cmp	w25,	#0
    cset	w26,	ne
    mov	w18,	w26
    cmp	w19,	#0
    movz	w26,	#0
    mov	w22,	w26
    csel	w20,	w18,	w22,	ne
    str	w20,	[sp, #136]

    ldr	w24,	[sp, #1152]

    cmp	w24,	#0
    ldr	w24,	[sp, #1180]

    cset	w20,	ne
    mov	w18,	w20
    cmp	w24,	#0
    cset	w23,	ne
    mov	w0,	w23
    cmp	w28,	#0
    movz	w21,	#0
    csel	w19,	w0,	w21,	ne
    cmp	w19,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w18,	#0
    movz	w22,	#1
    mov	w19,	w22
    csel	w24,	w19,	w26,	ne
    str	w24,	[sp, #804]

    ldr	w25,	[sp, #1148]

    cmp	w25,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w20,	#0
    cset	w21,	eq
    mov	w0,	w21
    cmp	w0,	#0
    ldr	w26,	[sp, #804]

    cset	w23,	ne
    mov	w0,	w23
    cmp	w26,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w0,	#0
    ldr	w27,	[sp, #804]

    movz	w26,	#1
    mov	w21,	w26
    csel	w24,	w21,	w28,	ne
    cmp	w27,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w0,	#0
    movz	w18,	#0
    csel	w19,	w23,	w18,	ne
    cmp	w19,	#0
    cset	w25,	eq
    mov	w26,	w25
    cmp	w26,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w24,	#0
    movz	w26,	#0
    mov	w27,	w26
    csel	w27,	w28,	w27,	ne
    str	w27,	[sp, #436]

    ldr	w21,	[sp, #1148]

    cmp	w21,	#0
    ldr	w27,	[sp, #804]

    cset	w21,	ne
    mov	w20,	w21
    cmp	w27,	#0
    cset	w24,	ne
    mov	w18,	w24
    cmp	w0,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w24,	w18,	w26,	ne
    cmp	w24,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w20,	#0
    movz	w27,	#1
    mov	w0,	w27
    csel	w0,	w0,	w26,	ne
    str	w0,	[sp, #972]

    ldr	w21,	[sp, #1156]

    cmp	w21,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w20,	#0
    cset	w21,	eq
    mov	w0,	w21
    cmp	w0,	#0
    cset	w23,	ne
    ldr	w20,	[sp, #972]

    mov	w0,	w23
    cmp	w20,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w0,	#0
    movz	w21,	#1
    mov	w26,	w21
    csel	w18,	w26,	w28,	ne
    ldr	w21,	[sp, #972]

    cmp	w21,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w0,	#0
    movz	w21,	#0
    mov	w24,	w21
    csel	w24,	w23,	w24,	ne
    cmp	w24,	#0
    cset	w25,	eq
    mov	w26,	w25
    cmp	w26,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w18,	#0
    movz	w23,	#0
    csel	w24,	w28,	w23,	ne
    str	w24,	[sp, #432]

    ldr	w18,	[sp, #1156]

    cmp	w18,	#0
    cset	w21,	ne
    mov	w27,	w21
    ldr	w21,	[sp, #972]

    cmp	w21,	#0
    cset	w24,	ne
    mov	w18,	w24
    cmp	w0,	#0
    movz	w23,	#0
    mov	w20,	w23
    csel	w25,	w18,	w20,	ne
    cmp	w25,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w27,	#0
    movz	w23,	#1
    mov	w18,	w23
    csel	w22,	w18,	w26,	ne
    str	w22,	[sp, #976]

    ldr	w25,	[sp, #1160]

    cmp	w25,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w20,	#0
    cset	w21,	eq
    mov	w0,	w21
    cmp	w0,	#0
    ldr	w25,	[sp, #976]

    cset	w23,	ne
    mov	w0,	w23
    cmp	w25,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w0,	#0
    ldr	w26,	[sp, #976]

    movz	w18,	#1
    csel	w18,	w18,	w28,	ne
    cmp	w26,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w0,	#0
    movz	w27,	#0
    mov	w19,	w27
    csel	w26,	w23,	w19,	ne
    cmp	w26,	#0
    cset	w25,	eq
    mov	w26,	w25
    cmp	w26,	#0
    cset	w27,	ne
    mov	w24,	w27
    cmp	w18,	#0
    movz	w23,	#0
    mov	w27,	w23
    csel	w26,	w24,	w27,	ne
    str	w26,	[sp, #420]

    ldr	w22,	[sp, #1160]

    cmp	w22,	#0
    cset	w21,	ne
    ldr	w27,	[sp, #976]

    mov	w20,	w21
    cmp	w27,	#0
    cset	w24,	ne
    mov	w18,	w24
    cmp	w0,	#0
    movz	w28,	#0
    mov	w25,	w28
    csel	w18,	w18,	w25,	ne
    cmp	w18,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w20,	#0
    movz	w18,	#1
    mov	w23,	w18
    csel	w27,	w23,	w26,	ne
    str	w27,	[sp, #980]

    ldr	w0,	[sp, #1164]

    cmp	w0,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w20,	#0
    cset	w21,	eq
    mov	w0,	w21
    cmp	w0,	#0
    cset	w23,	ne
    ldr	w19,	[sp, #980]

    mov	w0,	w23
    cmp	w19,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w0,	#0
    movz	w22,	#1
    mov	w25,	w22
    csel	w18,	w25,	w28,	ne
    str	w18,	[sp, #768]

    ldr	w20,	[sp, #980]

    cmp	w20,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w0,	#0
    movz	w21,	#0
    mov	w27,	w21
    csel	w20,	w23,	w27,	ne
    cmp	w20,	#0
    cset	w25,	eq
    mov	w26,	w25
    cmp	w26,	#0
    cset	w27,	ne
    ldr	w25,	[sp, #768]

    mov	w28,	w27
    cmp	w25,	#0
    movz	w25,	#0
    mov	w22,	w25
    csel	w18,	w28,	w22,	ne
    str	w18,	[sp, #424]

    ldr	w26,	[sp, #1164]

    cmp	w26,	#0
    cset	w21,	ne
    mov	w23,	w21
    ldr	w21,	[sp, #980]

    cmp	w21,	#0
    cset	w21,	ne
    mov	w22,	w21
    cmp	w0,	#0
    movz	w24,	#0
    mov	w20,	w24
    csel	w24,	w22,	w20,	ne
    cmp	w24,	#0
    cset	w0,	ne
    mov	w25,	w0
    cmp	w23,	#0
    movz	w0,	#1
    mov	w28,	w0
    csel	w21,	w28,	w25,	ne
    str	w21,	[sp, #792]

    ldr	w21,	[sp, #1168]

    cmp	w21,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w20,	#0
    cset	w21,	eq
    mov	w0,	w21
    cmp	w0,	#0
    cset	w23,	ne
    ldr	w21,	[sp, #792]

    mov	w28,	w23
    cmp	w21,	#0
    cset	w26,	ne
    mov	w27,	w26
    cmp	w28,	#0
    ldr	w22,	[sp, #792]

    movz	w25,	#1
    mov	w26,	w25
    csel	w23,	w26,	w27,	ne
    cmp	w22,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w28,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w18,	w22,	w26,	ne
    cmp	w18,	#0
    cset	w24,	eq
    mov	w25,	w24
    cmp	w25,	#0
    cset	w26,	ne
    mov	w27,	w26
    cmp	w23,	#0
    movz	w0,	#0
    csel	w20,	w27,	w0,	ne
    str	w20,	[sp, #428]

    ldr	w18,	[sp, #1168]

    cmp	w18,	#0
    cset	w20,	ne
    mov	w22,	w20
    ldr	w20,	[sp, #792]

    cmp	w20,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w28,	#0
    movz	w19,	#0
    mov	w27,	w19
    csel	w26,	w0,	w27,	ne
    cmp	w26,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w22,	#0
    movz	w19,	#1
    mov	w22,	w19
    csel	w26,	w22,	w28,	ne
    str	w26,	[sp, #796]

    ldr	w25,	[sp, #152]

    cmp	w25,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w20,	#0
    cset	w21,	eq
    mov	w0,	w21
    cmp	w0,	#0
    ldr	w27,	[sp, #796]

    cset	w23,	ne
    mov	w0,	w23
    cmp	w27,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w0,	#0
    movz	w23,	#1
    csel	w18,	w23,	w28,	ne
    ldr	w28,	[sp, #796]

    cmp	w28,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w0,	#0
    movz	w24,	#0
    mov	w21,	w24
    csel	w19,	w23,	w21,	ne
    cmp	w19,	#0
    cset	w25,	eq
    mov	w26,	w25
    cmp	w26,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w18,	#0
    movz	w26,	#0
    mov	w21,	w26
    csel	w26,	w28,	w21,	ne
    str	w26,	[sp, #776]

    ldr	w27,	[sp, #152]

    cmp	w27,	#0
    cset	w21,	ne
    ldr	w27,	[sp, #796]

    mov	w23,	w21
    cmp	w27,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w0,	#0
    movz	w0,	#0
    mov	w19,	w0
    csel	w18,	w18,	w19,	ne
    cmp	w18,	#0
    cset	w19,	ne
    mov	w20,	w19
    cmp	w23,	#0
    movz	w25,	#1
    mov	w26,	w25
    csel	w19,	w26,	w20,	ne
    str	w19,	[sp, #800]

    ldr	w21,	[sp, #188]

    cmp	w21,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w20,	#0
    cset	w21,	eq
    mov	w0,	w21
    cmp	w0,	#0
    cset	w23,	ne
    ldr	w21,	[sp, #800]

    mov	w0,	w23
    cmp	w21,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w0,	#0
    movz	w18,	#1
    ldr	w22,	[sp, #800]

    mov	w27,	w18
    csel	w24,	w27,	w28,	ne
    cmp	w22,	#0
    cset	w21,	ne
    mov	w23,	w21
    cmp	w0,	#0
    movz	w19,	#0
    mov	w27,	w19
    csel	w20,	w23,	w27,	ne
    cmp	w20,	#0
    cset	w25,	eq
    mov	w26,	w25
    cmp	w26,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w24,	#0
    movz	w21,	#0
    mov	w26,	w21
    csel	w23,	w28,	w26,	ne
    str	w23,	[sp, #752]

    ldr	w26,	[sp, #188]

    cmp	w26,	#0
    cset	w21,	ne
    mov	w23,	w21
    ldr	w21,	[sp, #800]

    cmp	w21,	#0
    cset	w21,	ne
    mov	w22,	w21
    cmp	w0,	#0
    movz	w20,	#0
    mov	w24,	w20
    csel	w24,	w22,	w24,	ne
    cmp	w24,	#0
    cset	w0,	ne
    mov	w25,	w0
    cmp	w23,	#0
    movz	w20,	#1
    csel	w22,	w20,	w25,	ne
    str	w22,	[sp, #772]

    ldr	w27,	[sp, #472]

    cmp	w27,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w20,	#0
    cset	w21,	eq
    mov	w0,	w21
    cmp	w0,	#0
    cset	w23,	ne
    ldr	w21,	[sp, #772]

    mov	w28,	w23
    cmp	w21,	#0
    cset	w26,	ne
    mov	w27,	w26
    cmp	w28,	#0
    ldr	w22,	[sp, #772]

    movz	w25,	#1
    mov	w21,	w25
    csel	w18,	w21,	w27,	ne
    cmp	w22,	#0
    cset	w20,	ne
    mov	w22,	w20
    cmp	w28,	#0
    movz	w0,	#0
    csel	w23,	w22,	w0,	ne
    cmp	w23,	#0
    cset	w24,	eq
    mov	w25,	w24
    cmp	w25,	#0
    cset	w26,	ne
    mov	w27,	w26
    cmp	w18,	#0
    movz	w0,	#0
    csel	w27,	w27,	w0,	ne
    str	w27,	[sp, #132]

    ldr	w22,	[sp, #472]

    cmp	w22,	#0
    ldr	w19,	[sp, #772]

    cset	w20,	ne
    mov	w22,	w20
    cmp	w19,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w28,	#0
    movz	w18,	#0
    mov	w28,	w18
    csel	w26,	w0,	w28,	ne
    cmp	w26,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w22,	#0
    movz	w25,	#1
    mov	w24,	w25
    csel	w25,	w24,	w28,	ne
    str	w25,	[sp, #924]

    ldr	w25,	[sp, #484]

    cmp	w25,	#0
    cset	w18,	ne
    mov	w20,	w18
    cmp	w20,	#0
    cset	w21,	eq
    mov	w0,	w21
    cmp	w0,	#0
    ldr	w20,	[sp, #924]

    cset	w23,	ne
    mov	w0,	w23
    cmp	w20,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w0,	#0
    ldr	w21,	[sp, #924]

    movz	w18,	#1
    csel	w20,	w18,	w28,	ne
    cmp	w21,	#0
    cset	w24,	ne
    mov	w18,	w24
    cmp	w0,	#0
    movz	w24,	#0
    mov	w26,	w24
    csel	w26,	w18,	w26,	ne
    cmp	w26,	#0
    cset	w25,	eq
    mov	w26,	w25
    cmp	w26,	#0
    cset	w27,	ne
    mov	w18,	w27
    cmp	w20,	#0
    movz	w23,	#0
    mov	w27,	w23
    csel	w18,	w18,	w27,	ne
    str	w18,	[sp, #788]

    ldr	w22,	[sp, #484]

    cmp	w22,	#0
    cset	w22,	ne
    ldr	w27,	[sp, #924]

    mov	w28,	w22
    cmp	w27,	#0
    cset	w24,	ne
    mov	w18,	w24
    cmp	w0,	#0
    movz	w24,	#0
    mov	w27,	w24
    csel	w25,	w18,	w27,	ne
    cmp	w25,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w28,	#0
    movz	w0,	#1
    mov	w24,	w0
    ldr	w0,	[sp, #488]

    csel	w18,	w24,	w26,	ne
    cmp	w0,	#0
    cset	w23,	ne
    mov	w24,	w23
    cmp	w24,	#0
    cset	w25,	eq
    mov	w26,	w25
    cmp	w26,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w18,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w28,	#0
    movz	w25,	#1
    mov	w0,	w25
    csel	w23,	w0,	w26,	ne
    cmp	w18,	#0
    cset	w19,	ne
    mov	w20,	w19
    cmp	w28,	#0
    movz	w19,	#0
    mov	w26,	w19
    csel	w22,	w20,	w26,	ne
    cmp	w22,	#0
    cset	w25,	eq
    mov	w26,	w25
    cmp	w26,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w23,	#0
    ldr	w19,	[sp, #788]

    movz	w21,	#0
    ldr	w0,	[sp, #132]

    mov	w24,	w21
    ldr	w26,	[sp, #752]

    csel	w18,	w28,	w24,	ne
    ldr	w28,	[sp, #776]

    lsl	w22,	w18,	#1
    add	w20,	w22,	w19
    lsl	w21,	w20,	#1
    ldr	w20,	[sp, #428]

    add	w0,	w21,	w0
    lsl	w24,	w0,	#1
    add	w24,	w24,	w26
    lsl	w26,	w24,	#1
    add	w26,	w26,	w28
    lsl	w0,	w26,	#1
    add	w28,	w0,	w20
    ldr	w0,	[sp, #424]

    ldr	w26,	[sp, #420]

    lsl	w20,	w28,	#1
    ldr	w23,	[sp, #432]

    add	w18,	w20,	w0
    lsl	w21,	w18,	#1
    add	w20,	w21,	w26
    ldr	w26,	[sp, #436]

    ldr	w21,	[sp, #136]

    lsl	w24,	w20,	#1
    add	w0,	w24,	w23
    lsl	w24,	w0,	#1
    ldr	w0,	[sp, #176]

    add	w24,	w24,	w26
    lsl	w25,	w24,	#1
    add	w26,	w25,	w21
    ldr	w21,	[sp, #460]

    lsl	w27,	w26,	#1
    add	w28,	w27,	w0
    lsl	w0,	w28,	#1
    ldr	w28,	[sp, #480]

    add	w18,	w0,	w21
    lsl	w19,	w18,	#1
    add	w20,	w19,	w28
    ldr	w19,	[sp, #496]

    ldr	w27,	[sp, #504]

    lsl	w21,	w20,	#1
    add	w0,	w21,	w19
    lsl	w23,	w0,	#1
    add	w0,	w23,	w27
    bl	fib
    ldr	w11,	[sp, #520]

    movz	w4,	#0
    ldr	w17,	[sp, #520]

    asr	w12,	w11,	#31
    ldr	w18,	[sp, #520]

    lsr	w13,	w12,	#31
    add	w14,	w17,	w13
    asr	w5,	w14,	#1
    lsl	w6,	w5,	#1
    sub	w1,	w18,	w6
    sub	w3,	w4,	w1
    cmp	w1,	#0
    csel	w4,	w3,	w1,	lt
    str	w4,	[sp, #360]

    ldr	w14,	[sp, #520]

    asr	w15,	w14,	#31
    ldr	w20,	[sp, #520]

    lsr	w16,	w15,	#31
    add	w17,	w20,	w16
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
    str	w19,	[sp, #412]

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
    csel	w2,	w15,	w12,	lt
    asr	w6,	w10,	#31
    str	w2,	[sp, #1012]

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
    csel	w7,	w20,	w17,	lt
    str	w7,	[sp, #1016]

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
    csel	w12,	w25,	w24,	lt
    asr	w18,	w22,	#31
    str	w12,	[sp, #1024]

    lsr	w19,	w18,	#31
    movz	w12,	#0
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
    csel	w17,	w3,	w1,	lt
    asr	w24,	w27,	#31
    movz	w8,	#0
    str	w17,	[sp, #1028]

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
    csel	w27,	w9,	w6,	lt
    asr	w5,	w2,	#31
    movz	w4,	#0
    str	w27,	[sp, #1036]

    lsr	w6,	w5,	#31
    add	w25,	w2,	w6
    asr	w9,	w25,	#1
    asr	w6,	w9,	#31
    lsr	w7,	w6,	#31
    add	w10,	w9,	w7
    asr	w24,	w10,	#1
    lsl	w25,	w24,	#1
    sub	w13,	w9,	w25
    sub	w14,	w4,	w13
    cmp	w13,	#0
    movz	w28,	#0
    asr	w11,	w9,	#31
    csel	w14,	w14,	w13,	lt
    lsr	w12,	w11,	#31
    str	w14,	[sp, #408]

    add	w3,	w9,	w12
    asr	w12,	w3,	#1
    asr	w14,	w12,	#31
    lsr	w15,	w14,	#31
    add	w16,	w12,	w15
    asr	w20,	w16,	#1
    lsl	w21,	w20,	#1
    sub	w16,	w12,	w21
    sub	w19,	w28,	w16
    cmp	w16,	#0
    csel	w21,	w19,	w16,	lt
    asr	w17,	w12,	#31
    movz	w24,	#0
    str	w21,	[sp, #444]

    lsr	w18,	w17,	#31
    add	w9,	w12,	w18
    asr	w17,	w9,	#1
    asr	w20,	w17,	#31
    lsr	w21,	w20,	#31
    add	w22,	w17,	w21
    asr	w14,	w22,	#1
    lsl	w15,	w14,	#1
    sub	w21,	w17,	w15
    sub	w24,	w24,	w21
    cmp	w21,	#0
    asr	w23,	w17,	#31
    csel	w24,	w24,	w21,	lt
    movz	w20,	#0
    str	w24,	[sp, #416]

    lsr	w24,	w23,	#31
    add	w15,	w17,	w24
    asr	w25,	w15,	#1
    asr	w26,	w25,	#31
    lsr	w27,	w26,	#31
    add	w28,	w25,	w27
    asr	w10,	w28,	#1
    lsl	w11,	w10,	#1
    sub	w28,	w25,	w11
    sub	w1,	w20,	w28
    cmp	w28,	#0
    csel	w16,	w1,	w28,	lt
    str	w16,	[sp, #440]

    asr	w1,	w25,	#31
    movz	w16,	#0
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
    csel	w3,	w7,	w4,	lt
    asr	w7,	w2,	#31
    str	w3,	[sp, #932]

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
    csel	w8,	w13,	w10,	lt
    str	w8,	[sp, #912]

    lsr	w15,	w14,	#31
    add	w5,	w5,	w15
    asr	w4,	w5,	#1
    asr	w6,	w4,	#31
    lsr	w7,	w6,	#31
    add	w8,	w4,	w7
    asr	w9,	w8,	#1
    movz	w8,	#0
    lsl	w10,	w9,	#1
    sub	w13,	w4,	w10
    sub	w14,	w8,	w13
    cmp	w13,	#0
    asr	w9,	w4,	#31
    csel	w3,	w14,	w13,	lt
    str	w3,	[sp, #908]

    lsr	w10,	w9,	#31
    add	w11,	w4,	w10
    movz	w4,	#0
    asr	w11,	w11,	#1
    asr	w12,	w11,	#31
    lsr	w13,	w12,	#31
    add	w14,	w11,	w13
    asr	w5,	w14,	#1
    lsl	w6,	w5,	#1
    sub	w18,	w11,	w6
    sub	w19,	w4,	w18
    cmp	w18,	#0
    csel	w26,	w19,	w18,	lt
    asr	w15,	w11,	#31
    movz	w28,	#0
    str	w26,	[sp, #448]

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
    movz	w25,	#0
    csel	w13,	w24,	w21,	lt
    str	w13,	[sp, #916]

    asr	w21,	w0,	#31
    lsr	w22,	w21,	#31
    add	w23,	w0,	w22
    asr	w26,	w23,	#1
    lsl	w27,	w26,	#1
    sub	w27,	w0,	w27
    sub	w28,	w25,	w27
    cmp	w27,	#0
    csel	w22,	w28,	w27,	lt
    movz	w11,	#0
    asr	w24,	w0,	#31
    str	w22,	[sp, #1032]

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
    movz	w7,	#0
    asr	w28,	w4,	#31
    csel	w10,	w23,	w22,	lt
    lsr	w0,	w28,	#31
    str	w10,	[sp, #1008]

    add	w1,	w4,	w0
    asr	w23,	w1,	#1
    asr	w2,	w23,	#31
    lsr	w3,	w2,	#31
    add	w4,	w23,	w3
    asr	w8,	w4,	#1
    lsl	w9,	w8,	#1
    sub	w27,	w23,	w9
    sub	w28,	w7,	w27
    cmp	w27,	#0
    movz	w3,	#0
    csel	w6,	w28,	w27,	lt
    asr	w5,	w23,	#31
    str	w6,	[sp, #928]

    lsr	w6,	w5,	#31
    add	w7,	w23,	w6
    asr	w18,	w7,	#1
    asr	w9,	w18,	#31
    lsr	w10,	w9,	#31
    add	w11,	w18,	w10
    asr	w12,	w11,	#1
    lsl	w13,	w12,	#1
    sub	w2,	w18,	w13
    sub	w14,	w3,	w2
    cmp	w2,	#0
    csel	w0,	w14,	w2,	lt
    asr	w25,	w18,	#31
    lsr	w26,	w25,	#31
    add	w15,	w18,	w26
    asr	w20,	w15,	#1
    asr	w28,	w20,	#31
    lsr	w2,	w28,	#31
    add	w1,	w20,	w2
    asr	w26,	w1,	#1
    movz	w1,	#0
    lsl	w27,	w26,	#1
    sub	w18,	w20,	w27
    sub	w25,	w1,	w18
    cmp	w18,	#0
    movz	w26,	#0
    csel	w24,	w25,	w18,	lt
    asr	w11,	w20,	#31
    lsr	w12,	w11,	#31
    add	w4,	w20,	w12
    asr	w23,	w4,	#1
    asr	w14,	w23,	#31
    lsr	w15,	w14,	#31
    add	w16,	w23,	w15
    asr	w5,	w16,	#1
    lsl	w6,	w5,	#1
    sub	w1,	w23,	w6
    sub	w2,	w26,	w1
    cmp	w1,	#0
    asr	w17,	w23,	#31
    csel	w26,	w2,	w1,	lt
    movz	w21,	#0
    str	w26,	[sp, #984]

    lsr	w18,	w17,	#31
    add	w10,	w23,	w18
    asr	w4,	w10,	#1
    asr	w22,	w4,	#31
    lsr	w23,	w22,	#31
    add	w25,	w4,	w23
    asr	w1,	w25,	#1
    lsl	w2,	w1,	#1
    sub	w5,	w4,	w2
    sub	w8,	w21,	w5
    cmp	w5,	#0
    csel	w3,	w8,	w5,	lt
    movz	w17,	#0
    asr	w27,	w4,	#31
    str	w3,	[sp, #988]

    lsr	w28,	w27,	#31
    add	w16,	w4,	w28
    asr	w2,	w16,	#1
    asr	w4,	w2,	#31
    lsr	w1,	w4,	#31
    add	w3,	w2,	w1
    asr	w27,	w3,	#1
    lsl	w28,	w27,	#1
    sub	w9,	w2,	w28
    sub	w12,	w17,	w9
    cmp	w9,	#0
    csel	w8,	w12,	w9,	lt
    asr	w20,	w2,	#31
    movz	w13,	#0
    str	w8,	[sp, #992]

    lsr	w21,	w20,	#31
    add	w22,	w2,	w21
    asr	w25,	w22,	#1
    asr	w23,	w25,	#31
    lsr	w26,	w23,	#31
    add	w27,	w25,	w26
    asr	w8,	w27,	#1
    lsl	w9,	w8,	#1
    sub	w16,	w25,	w9
    sub	w17,	w13,	w16
    cmp	w16,	#0
    asr	w28,	w25,	#31
    csel	w13,	w17,	w16,	lt
    movz	w9,	#0
    str	w13,	[sp, #996]

    lsr	w2,	w28,	#31
    add	w1,	w25,	w2
    asr	w17,	w1,	#1
    asr	w2,	w17,	#31
    lsr	w3,	w2,	#31
    add	w4,	w17,	w3
    asr	w4,	w4,	#1
    lsl	w5,	w4,	#1
    sub	w21,	w17,	w5
    sub	w22,	w9,	w21
    cmp	w21,	#0
    asr	w5,	w17,	#31
    csel	w18,	w22,	w21,	lt
    str	w18,	[sp, #1004]

    lsr	w6,	w5,	#31
    movz	w5,	#0
    add	w7,	w17,	w6
    asr	w27,	w7,	#1
    asr	w18,	w27,	#31
    lsr	w19,	w18,	#31
    add	w20,	w27,	w19
    asr	w11,	w20,	#1
    lsl	w12,	w11,	#1
    sub	w1,	w27,	w12
    sub	w3,	w5,	w1
    cmp	w1,	#0
    csel	w4,	w3,	w1,	lt
    asr	w21,	w27,	#31
    str	w4,	[sp, #168]

    lsr	w22,	w21,	#31
    add	w13,	w27,	w22
    asr	w4,	w13,	#1
    asr	w28,	w4,	#31
    lsr	w1,	w28,	#31
    add	w3,	w4,	w1
    movz	w1,	#0
    asr	w9,	w3,	#1
    lsl	w10,	w9,	#1
    sub	w7,	w4,	w10
    sub	w8,	w1,	w7
    cmp	w7,	#0
    movz	w27,	#0
    csel	w25,	w8,	w7,	lt
    asr	w1,	w4,	#31
    str	w25,	[sp, #468]

    lsr	w2,	w1,	#31
    add	w19,	w4,	w2
    asr	w7,	w19,	#1
    asr	w4,	w7,	#31
    lsr	w5,	w4,	#31
    add	w6,	w7,	w5
    asr	w3,	w6,	#1
    lsl	w4,	w3,	#1
    sub	w10,	w7,	w4
    sub	w13,	w27,	w10
    cmp	w10,	#0
    movz	w22,	#0
    csel	w12,	w13,	w10,	lt
    asr	w9,	w7,	#31
    str	w12,	[sp, #456]

    lsr	w10,	w9,	#31
    add	w27,	w7,	w10
    asr	w12,	w27,	#1
    asr	w10,	w12,	#31
    lsr	w11,	w10,	#31
    add	w14,	w12,	w11
    asr	w1,	w14,	#1
    lsl	w3,	w1,	#1
    sub	w15,	w12,	w3
    sub	w18,	w22,	w15
    cmp	w15,	#0
    csel	w5,	w18,	w15,	lt
    str	w5,	[sp, #452]

    movz	w18,	#0
    asr	w15,	w12,	#31
    lsr	w16,	w15,	#31
    add	w4,	w12,	w16
    asr	w17,	w4,	#1
    asr	w16,	w17,	#31
    lsr	w19,	w16,	#31
    add	w20,	w17,	w19
    asr	w23,	w20,	#1
    lsl	w25,	w23,	#1
    sub	w22,	w17,	w25
    sub	w23,	w18,	w22
    cmp	w22,	#0
    asr	w21,	w17,	#31
    movz	w14,	#0
    csel	w15,	w23,	w22,	lt
    str	w15,	[sp, #180]

    lsr	w22,	w21,	#31
    add	w10,	w17,	w22
    asr	w25,	w10,	#1
    asr	w11,	w25,	#31
    lsr	w12,	w11,	#31
    add	w13,	w25,	w12
    asr	w7,	w13,	#1
    lsl	w8,	w7,	#1
    sub	w27,	w25,	w8
    sub	w28,	w14,	w27
    cmp	w27,	#0
    csel	w20,	w28,	w27,	lt
    str	w20,	[sp, #920]

    ldr	w22,	[sp, #1032]

    cmp	w22,	#0
    cset	w6,	ne
    ldr	w8,	[sp, #360]

    cmp	w8,	#0
    movz	w21,	#1
    mov	w20,	w21
    csel	w22,	w20,	w6,	ne
    str	w22,	[sp, #156]

    ldr	w23,	[sp, #1032]

    cmp	w23,	#0
    ldr	w8,	[sp, #360]

    cset	w17,	ne
    mov	w18,	w17
    cmp	w8,	#0
    movz	w12,	#0
    csel	w2,	w18,	w12,	ne
    cmp	w2,	#0
    cset	w14,	eq
    cmp	w14,	#0
    ldr	w25,	[sp, #156]

    cset	w16,	ne
    cmp	w25,	#0
    movz	w19,	#0
    mov	w18,	w19
    csel	w8,	w16,	w18,	ne
    cmp	w8,	#0
    cset	w20,	ne
    cmp	w20,	#0
    ldr	w27,	[sp, #1032]

    cset	w22,	ne
    mov	w21,	w22
    cmp	w27,	#0
    ldr	w15,	[sp, #360]

    cset	w2,	ne
    cmp	w15,	#0
    movz	w4,	#0
    mov	w3,	w4
    csel	w25,	w2,	w3,	ne
    cmp	w25,	#0
    ldr	w2,	[sp, #1008]

    cset	w19,	ne
    cmp	w2,	#0
    ldr	w28,	[sp, #412]

    cset	w23,	ne
    mov	w25,	w23
    cmp	w28,	#0
    ldr	w3,	[sp, #1008]

    movz	w11,	#1
    csel	w17,	w11,	w25,	ne
    cmp	w3,	#0
    cset	w2,	ne
    str	w2,	[sp, #160]

    ldr	w6,	[sp, #412]

    cmp	w6,	#0
    ldr	w26,	[sp, #160]

    movz	w4,	#0
    csel	w15,	w26,	w4,	ne
    cmp	w15,	#0
    cset	w1,	eq
    cmp	w1,	#0
    cset	w3,	ne
    cmp	w17,	#0
    movz	w11,	#0
    mov	w10,	w11
    csel	w10,	w3,	w10,	ne
    str	w10,	[sp, #116]

    cmp	w19,	#0
    ldr	w27,	[sp, #116]

    cset	w7,	ne
    cmp	w27,	#0
    movz	w10,	#1
    mov	w9,	w10
    csel	w3,	w9,	w7,	ne
    cmp	w19,	#0
    cset	w10,	ne
    str	w10,	[sp, #112]

    ldr	w1,	[sp, #116]

    cmp	w1,	#0
    ldr	w7,	[sp, #112]

    movz	w11,	#0
    csel	w6,	w7,	w11,	ne
    cmp	w6,	#0
    cset	w15,	eq
    cmp	w15,	#0
    cset	w17,	ne
    mov	w18,	w17
    cmp	w3,	#0
    movz	w6,	#0
    csel	w18,	w18,	w6,	ne
    str	w18,	[sp, #400]

    ldr	w4,	[sp, #1008]

    cmp	w4,	#0
    ldr	w2,	[sp, #412]

    cset	w26,	ne
    mov	w27,	w26
    cmp	w2,	#0
    movz	w5,	#0
    csel	w8,	w27,	w5,	ne
    cmp	w19,	#0
    ldr	w2,	[sp, #116]

    cset	w12,	ne
    cmp	w2,	#0
    movz	w26,	#0
    mov	w25,	w26
    csel	w13,	w12,	w25,	ne
    cmp	w13,	#0
    cset	w16,	ne
    cmp	w8,	#0
    ldr	w9,	[sp, #928]

    movz	w23,	#1
    csel	w25,	w23,	w16,	ne
    cmp	w9,	#0
    ldr	w7,	[sp, #1012]

    cset	w20,	ne
    mov	w22,	w20
    cmp	w7,	#0
    movz	w19,	#1
    ldr	w10,	[sp, #928]

    csel	w23,	w19,	w22,	ne
    cmp	w10,	#0
    ldr	w8,	[sp, #1012]

    cset	w27,	ne
    mov	w28,	w27
    cmp	w8,	#0
    movz	w18,	#0
    csel	w1,	w28,	w18,	ne
    cmp	w1,	#0
    cset	w3,	eq
    cmp	w3,	#0
    cset	w2,	ne
    cmp	w23,	#0
    movz	w19,	#0
    mov	w18,	w19
    csel	w23,	w2,	w18,	ne
    cmp	w25,	#0
    cset	w6,	ne
    cmp	w23,	#0
    movz	w18,	#1
    mov	w17,	w18
    csel	w14,	w17,	w6,	ne
    str	w14,	[sp, #164]

    cmp	w25,	#0
    cset	w28,	ne
    mov	w1,	w28
    cmp	w23,	#0
    movz	w3,	#0
    mov	w2,	w3
    csel	w27,	w1,	w2,	ne
    cmp	w27,	#0
    cset	w14,	eq
    cmp	w14,	#0
    ldr	w4,	[sp, #164]

    cset	w16,	ne
    mov	w17,	w16
    cmp	w4,	#0
    movz	w14,	#0
    csel	w15,	w17,	w14,	ne
    str	w15,	[sp, #404]

    ldr	w11,	[sp, #928]

    cmp	w11,	#0
    cset	w20,	ne
    ldr	w9,	[sp, #1012]

    mov	w22,	w20
    cmp	w9,	#0
    movz	w13,	#0
    csel	w5,	w22,	w13,	ne
    cmp	w25,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w23,	#0
    movz	w12,	#0
    csel	w1,	w28,	w12,	ne
    cmp	w1,	#0
    cset	w3,	ne
    cmp	w5,	#0
    movz	w12,	#1
    csel	w2,	w12,	w3,	ne
    cmp	w0,	#0
    cset	w4,	ne
    ldr	w13,	[sp, #1016]

    cmp	w13,	#0
    movz	w12,	#1
    mov	w11,	w12
    csel	w28,	w11,	w4,	ne
    cmp	w0,	#0
    cset	w8,	ne
    ldr	w14,	[sp, #1016]

    cmp	w14,	#0
    movz	w11,	#0
    mov	w10,	w11
    csel	w8,	w8,	w10,	ne
    cmp	w8,	#0
    cset	w12,	eq
    cmp	w12,	#0
    cset	w14,	ne
    mov	w15,	w14
    cmp	w28,	#0
    movz	w8,	#0
    csel	w14,	w15,	w8,	ne
    cmp	w2,	#0
    cset	w18,	ne
    mov	w19,	w18
    cmp	w14,	#0
    movz	w7,	#1
    csel	w18,	w7,	w19,	ne
    cmp	w2,	#0
    cset	w10,	ne
    cmp	w14,	#0
    movz	w23,	#0
    mov	w22,	w23
    csel	w25,	w10,	w22,	ne
    cmp	w25,	#0
    cset	w1,	eq
    cmp	w1,	#0
    cset	w3,	ne
    mov	w4,	w3
    cmp	w18,	#0
    movz	w6,	#0
    mov	w5,	w6
    csel	w9,	w4,	w5,	ne
    str	w9,	[sp, #396]

    cmp	w0,	#0
    cset	w3,	ne
    ldr	w10,	[sp, #1016]

    cmp	w10,	#0
    movz	w5,	#0
    mov	w4,	w5
    csel	w3,	w3,	w4,	ne
    cmp	w2,	#0
    cset	w7,	ne
    cmp	w14,	#0
    movz	w2,	#0
    csel	w10,	w7,	w2,	ne
    cmp	w10,	#0
    cset	w11,	ne
    cmp	w3,	#0
    movz	w1,	#1
    csel	w6,	w1,	w11,	ne
    cmp	w24,	#0
    ldr	w12,	[sp, #1024]

    cset	w15,	ne
    mov	w16,	w15
    cmp	w12,	#0
    movz	w0,	#1
    csel	w16,	w0,	w16,	ne
    cmp	w24,	#0
    cset	w19,	ne
    ldr	w13,	[sp, #1024]

    mov	w20,	w19
    cmp	w13,	#0
    movz	w2,	#0
    mov	w1,	w2
    csel	w10,	w20,	w1,	ne
    cmp	w10,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    cmp	w16,	#0
    movz	w1,	#0
    csel	w14,	w28,	w1,	ne
    cmp	w6,	#0
    cset	w1,	ne
    cmp	w14,	#0
    movz	w0,	#1
    mov	w28,	w0
    csel	w2,	w28,	w1,	ne
    cmp	w6,	#0
    cset	w26,	ne
    mov	w27,	w26
    cmp	w14,	#0
    movz	w11,	#0
    csel	w28,	w27,	w11,	ne
    cmp	w28,	#0
    cset	w9,	eq
    cmp	w9,	#0
    cset	w11,	ne
    cmp	w2,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w2,	w11,	w26,	ne
    str	w2,	[sp, #392]

    cmp	w24,	#0
    ldr	w13,	[sp, #1024]

    cset	w15,	ne
    cmp	w13,	#0
    movz	w25,	#0
    mov	w24,	w25
    csel	w1,	w15,	w24,	ne
    cmp	w6,	#0
    cset	w19,	ne
    cmp	w14,	#0
    movz	w24,	#0
    csel	w13,	w19,	w24,	ne
    cmp	w13,	#0
    cset	w25,	ne
    cmp	w1,	#0
    ldr	w0,	[sp, #984]

    movz	w19,	#1
    csel	w12,	w19,	w25,	ne
    cmp	w0,	#0
    cset	w0,	ne
    ldr	w17,	[sp, #1028]

    cmp	w17,	#0
    ldr	w1,	[sp, #984]

    movz	w19,	#1
    csel	w13,	w19,	w0,	ne
    cmp	w1,	#0
    ldr	w18,	[sp, #1028]

    cset	w3,	ne
    cmp	w18,	#0
    movz	w19,	#0
    mov	w18,	w19
    csel	w5,	w3,	w18,	ne
    cmp	w5,	#0
    cset	w7,	eq
    cmp	w7,	#0
    cset	w9,	ne
    cmp	w13,	#0
    movz	w18,	#0
    csel	w22,	w9,	w18,	ne
    cmp	w12,	#0
    cset	w13,	ne
    cmp	w22,	#0
    movz	w17,	#1
    mov	w16,	w17
    csel	w4,	w16,	w13,	ne
    cmp	w12,	#0
    cset	w17,	ne
    mov	w18,	w17
    cmp	w22,	#0
    movz	w14,	#0
    csel	w19,	w18,	w14,	ne
    cmp	w19,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w4,	#0
    movz	w13,	#0
    csel	w27,	w26,	w13,	ne
    str	w27,	[sp, #388]

    ldr	w2,	[sp, #984]

    cmp	w2,	#0
    ldr	w19,	[sp, #1028]

    cset	w0,	ne
    cmp	w19,	#0
    movz	w13,	#0
    csel	w23,	w0,	w13,	ne
    cmp	w12,	#0
    cset	w3,	ne
    cmp	w22,	#0
    movz	w13,	#0
    csel	w28,	w3,	w13,	ne
    cmp	w28,	#0
    cset	w7,	ne
    cmp	w23,	#0
    movz	w12,	#1
    ldr	w5,	[sp, #988]

    csel	w12,	w12,	w7,	ne
    cmp	w5,	#0
    ldr	w28,	[sp, #1036]

    cset	w11,	ne
    cmp	w28,	#0
    movz	w9,	#1
    ldr	w6,	[sp, #988]

    csel	w11,	w9,	w11,	ne
    cmp	w6,	#0
    ldr	w0,	[sp, #1036]

    cset	w15,	ne
    mov	w16,	w15
    cmp	w0,	#0
    movz	w8,	#0
    csel	w17,	w16,	w8,	ne
    cmp	w17,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w23,	ne
    cmp	w11,	#0
    movz	w7,	#0
    csel	w25,	w23,	w7,	ne
    cmp	w12,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w25,	#0
    movz	w6,	#1
    csel	w15,	w6,	w28,	ne
    cmp	w12,	#0
    cset	w1,	ne
    cmp	w25,	#0
    movz	w7,	#0
    mov	w6,	w7
    csel	w27,	w1,	w6,	ne
    cmp	w27,	#0
    cset	w5,	eq
    cmp	w5,	#0
    cset	w7,	ne
    cmp	w15,	#0
    movz	w4,	#0
    csel	w24,	w7,	w4,	ne
    str	w24,	[sp, #384]

    ldr	w7,	[sp, #988]

    cmp	w7,	#0
    ldr	w1,	[sp, #1036]

    cset	w11,	ne
    cmp	w1,	#0
    movz	w3,	#0
    csel	w8,	w11,	w3,	ne
    cmp	w12,	#0
    cset	w15,	ne
    cmp	w25,	#0
    movz	w2,	#0
    csel	w12,	w15,	w2,	ne
    cmp	w12,	#0
    cset	w19,	ne
    cmp	w8,	#0
    ldr	w10,	[sp, #992]

    movz	w1,	#1
    csel	w14,	w1,	w19,	ne
    cmp	w10,	#0
    cset	w25,	ne
    ldr	w15,	[sp, #408]

    cmp	w15,	#0
    ldr	w11,	[sp, #992]

    movz	w0,	#1
    csel	w26,	w0,	w25,	ne
    cmp	w11,	#0
    ldr	w17,	[sp, #408]

    cset	w0,	ne
    mov	w1,	w0
    cmp	w17,	#0
    movz	w0,	#0
    mov	w28,	w0
    csel	w1,	w1,	w28,	ne
    cmp	w1,	#0
    cset	w3,	eq
    cmp	w3,	#0
    cset	w5,	ne
    cmp	w26,	#0
    movz	w0,	#0
    csel	w6,	w5,	w0,	ne
    cmp	w14,	#0
    cset	w9,	ne
    cmp	w6,	#0
    movz	w28,	#1
    csel	w7,	w28,	w9,	ne
    cmp	w14,	#0
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
    csel	w20,	w19,	w26,	ne
    str	w20,	[sp, #380]

    ldr	w12,	[sp, #992]

    cmp	w12,	#0
    ldr	w17,	[sp, #408]

    cset	w25,	ne
    cmp	w17,	#0
    movz	w23,	#0
    csel	w28,	w25,	w23,	ne
    cmp	w14,	#0
    cset	w0,	ne
    cmp	w6,	#0
    movz	w22,	#0
    csel	w26,	w0,	w22,	ne
    cmp	w26,	#0
    cset	w3,	ne
    cmp	w28,	#0
    ldr	w15,	[sp, #996]

    movz	w22,	#1
    csel	w18,	w22,	w3,	ne
    cmp	w15,	#0
    cset	w7,	ne
    ldr	w25,	[sp, #444]

    cmp	w25,	#0
    movz	w20,	#1
    ldr	w16,	[sp, #996]

    csel	w10,	w20,	w7,	ne
    cmp	w16,	#0
    cset	w11,	ne
    ldr	w26,	[sp, #444]

    cmp	w26,	#0
    movz	w19,	#0
    csel	w13,	w11,	w19,	ne
    cmp	w13,	#0
    cset	w15,	eq
    cmp	w15,	#0
    cset	w17,	ne
    cmp	w10,	#0
    movz	w16,	#0
    csel	w10,	w17,	w16,	ne
    cmp	w18,	#0
    cset	w23,	ne
    cmp	w10,	#0
    movz	w15,	#1
    csel	w5,	w15,	w23,	ne
    cmp	w18,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w10,	#0
    movz	w14,	#0
    csel	w0,	w28,	w14,	ne
    cmp	w0,	#0
    cset	w1,	eq
    cmp	w1,	#0
    cset	w3,	ne
    cmp	w5,	#0
    movz	w15,	#0
    csel	w17,	w3,	w15,	ne
    str	w17,	[sp, #376]

    ldr	w17,	[sp, #996]

    cmp	w17,	#0
    cset	w7,	ne
    ldr	w27,	[sp, #444]

    cmp	w27,	#0
    movz	w14,	#0
    csel	w16,	w7,	w14,	ne
    cmp	w18,	#0
    cset	w11,	ne
    cmp	w10,	#0
    movz	w13,	#0
    csel	w9,	w11,	w13,	ne
    cmp	w9,	#0
    cset	w15,	ne
    cmp	w16,	#0
    movz	w10,	#1
    ldr	w20,	[sp, #1004]

    csel	w7,	w10,	w15,	ne
    cmp	w20,	#0
    cset	w19,	ne
    ldr	w27,	[sp, #416]

    cmp	w27,	#0
    ldr	w22,	[sp, #1004]

    movz	w9,	#1
    csel	w24,	w9,	w19,	ne
    cmp	w22,	#0
    cset	w25,	ne
    ldr	w28,	[sp, #416]

    cmp	w28,	#0
    movz	w8,	#0
    csel	w25,	w25,	w8,	ne
    cmp	w25,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w1,	ne
    cmp	w24,	#0
    movz	w9,	#0
    csel	w22,	w1,	w9,	ne
    cmp	w7,	#0
    cset	w5,	ne
    cmp	w22,	#0
    movz	w8,	#1
    csel	w19,	w8,	w5,	ne
    cmp	w7,	#0
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
    csel	w14,	w15,	w4,	ne
    str	w14,	[sp, #372]

    ldr	w23,	[sp, #1004]

    cmp	w23,	#0
    cset	w19,	ne
    ldr	w0,	[sp, #416]

    cmp	w0,	#0
    movz	w3,	#0
    csel	w3,	w19,	w3,	ne
    cmp	w7,	#0
    cset	w25,	ne
    cmp	w22,	#0
    movz	w2,	#0
    csel	w26,	w25,	w2,	ne
    cmp	w26,	#0
    cset	w0,	ne
    cmp	w3,	#0
    movz	w2,	#1
    ldr	w5,	[sp, #168]

    csel	w4,	w2,	w0,	ne
    cmp	w5,	#0
    ldr	w19,	[sp, #440]

    cset	w3,	ne
    cmp	w19,	#0
    ldr	w6,	[sp, #168]

    movz	w0,	#1
    csel	w14,	w0,	w3,	ne
    cmp	w6,	#0
    cset	w7,	ne
    ldr	w20,	[sp, #440]

    cmp	w20,	#0
    movz	w1,	#0
    csel	w1,	w7,	w1,	ne
    cmp	w1,	#0
    cset	w11,	eq
    cmp	w11,	#0
    cset	w13,	ne
    cmp	w14,	#0
    movz	w0,	#0
    csel	w6,	w13,	w0,	ne
    cmp	w4,	#0
    cset	w17,	ne
    cmp	w6,	#0
    movz	w28,	#1
    csel	w9,	w28,	w17,	ne
    cmp	w4,	#0
    cset	w23,	ne
    cmp	w6,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w25,	w23,	w26,	ne
    cmp	w25,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w0,	ne
    cmp	w9,	#0
    movz	w25,	#0
    csel	w11,	w0,	w25,	ne
    str	w11,	[sp, #368]

    ldr	w9,	[sp, #168]

    cmp	w9,	#0
    cset	w3,	ne
    ldr	w22,	[sp, #440]

    cmp	w22,	#0
    movz	w25,	#0
    csel	w19,	w3,	w25,	ne
    cmp	w4,	#0
    cset	w7,	ne
    cmp	w6,	#0
    movz	w24,	#0
    csel	w8,	w7,	w24,	ne
    cmp	w8,	#0
    cset	w11,	ne
    cmp	w19,	#0
    movz	w22,	#1
    ldr	w25,	[sp, #468]

    csel	w14,	w22,	w11,	ne
    cmp	w25,	#0
    cset	w15,	ne
    ldr	w7,	[sp, #932]

    cmp	w7,	#0
    movz	w20,	#1
    ldr	w0,	[sp, #468]

    csel	w20,	w20,	w15,	ne
    cmp	w0,	#0
    ldr	w8,	[sp, #932]

    cset	w19,	ne
    cmp	w8,	#0
    movz	w17,	#0
    csel	w18,	w19,	w17,	ne
    cmp	w18,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w27,	ne
    cmp	w20,	#0
    movz	w16,	#0
    csel	w23,	w27,	w16,	ne
    cmp	w14,	#0
    cset	w1,	ne
    cmp	w23,	#0
    movz	w17,	#1
    csel	w3,	w17,	w1,	ne
    cmp	w14,	#0
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
    csel	w8,	w11,	w15,	ne
    str	w8,	[sp, #364]

    ldr	w0,	[sp, #468]

    cmp	w0,	#0
    cset	w15,	ne
    ldr	w9,	[sp, #932]

    cmp	w9,	#0
    movz	w12,	#0
    csel	w2,	w15,	w12,	ne
    cmp	w14,	#0
    cset	w19,	ne
    cmp	w23,	#0
    movz	w11,	#0
    csel	w24,	w19,	w11,	ne
    cmp	w24,	#0
    cset	w25,	ne
    cmp	w2,	#0
    movz	w10,	#1
    ldr	w9,	[sp, #456]

    csel	w26,	w10,	w25,	ne
    cmp	w9,	#0
    ldr	w12,	[sp, #912]

    cset	w0,	ne
    cmp	w12,	#0
    movz	w10,	#1
    ldr	w13,	[sp, #456]

    csel	w0,	w10,	w0,	ne
    cmp	w13,	#0
    cset	w3,	ne
    ldr	w13,	[sp, #912]

    cmp	w13,	#0
    movz	w10,	#0
    csel	w4,	w3,	w10,	ne
    cmp	w4,	#0
    cset	w7,	eq
    cmp	w7,	#0
    cset	w9,	ne
    cmp	w0,	#0
    movz	w7,	#0
    csel	w12,	w9,	w7,	ne
    cmp	w26,	#0
    cset	w13,	ne
    cmp	w12,	#0
    movz	w6,	#1
    csel	w24,	w6,	w13,	ne
    cmp	w26,	#0
    cset	w17,	ne
    cmp	w12,	#0
    movz	w5,	#0
    csel	w14,	w17,	w5,	ne
    cmp	w14,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w25,	ne
    cmp	w24,	#0
    ldr	w19,	[sp, #456]

    movz	w4,	#0
    csel	w4,	w25,	w4,	ne
    cmp	w19,	#0
    cset	w1,	ne
    ldr	w20,	[sp, #912]

    cmp	w20,	#0
    movz	w5,	#0
    csel	w7,	w1,	w5,	ne
    cmp	w26,	#0
    cset	w3,	ne
    cmp	w12,	#0
    movz	w2,	#0
    csel	w8,	w3,	w2,	ne
    cmp	w8,	#0
    cset	w8,	ne
    cmp	w7,	#0
    movz	w1,	#1
    ldr	w7,	[sp, #452]

    csel	w23,	w1,	w8,	ne
    cmp	w7,	#0
    ldr	w13,	[sp, #908]

    cset	w12,	ne
    cmp	w13,	#0
    movz	w0,	#1
    ldr	w13,	[sp, #452]

    csel	w5,	w0,	w12,	ne
    cmp	w13,	#0
    ldr	w13,	[sp, #908]

    cset	w16,	ne
    cmp	w13,	#0
    movz	w2,	#0
    csel	w17,	w16,	w2,	ne
    cmp	w17,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w24,	ne
    cmp	w5,	#0
    movz	w1,	#0
    csel	w14,	w24,	w1,	ne
    cmp	w23,	#0
    cset	w28,	ne
    cmp	w14,	#0
    movz	w27,	#1
    csel	w0,	w27,	w28,	ne
    cmp	w23,	#0
    cset	w1,	ne
    cmp	w14,	#0
    movz	w27,	#0
    csel	w2,	w1,	w27,	ne
    cmp	w2,	#0
    cset	w6,	eq
    cmp	w6,	#0
    cset	w8,	ne
    cmp	w0,	#0
    ldr	w3,	[sp, #452]

    movz	w27,	#0
    csel	w2,	w8,	w27,	ne
    cmp	w3,	#0
    ldr	w25,	[sp, #908]

    cset	w13,	ne
    cmp	w25,	#0
    movz	w26,	#0
    csel	w18,	w13,	w26,	ne
    cmp	w23,	#0
    cset	w17,	ne
    cmp	w14,	#0
    movz	w26,	#0
    csel	w22,	w17,	w26,	ne
    cmp	w22,	#0
    cset	w22,	ne
    cmp	w18,	#0
    ldr	w23,	[sp, #180]

    movz	w24,	#1
    csel	w9,	w24,	w22,	ne
    cmp	w23,	#0
    ldr	w16,	[sp, #448]

    cset	w27,	ne
    cmp	w16,	#0
    ldr	w11,	[sp, #180]

    movz	w20,	#1
    csel	w1,	w20,	w27,	ne
    cmp	w11,	#0
    cset	w5,	ne
    ldr	w18,	[sp, #448]

    cmp	w18,	#0
    movz	w19,	#0
    csel	w12,	w5,	w19,	ne
    cmp	w12,	#0
    cset	w5,	eq
    cmp	w5,	#0
    cset	w7,	ne
    cmp	w1,	#0
    movz	w20,	#0
    csel	w6,	w7,	w20,	ne
    cmp	w9,	#0
    cset	w11,	ne
    cmp	w6,	#0
    movz	w18,	#1
    csel	w14,	w18,	w11,	ne
    cmp	w9,	#0
    cset	w15,	ne
    cmp	w6,	#0
    movz	w17,	#0
    csel	w26,	w15,	w17,	ne
    cmp	w26,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w22,	ne
    cmp	w14,	#0
    movz	w15,	#0
    ldr	w23,	[sp, #180]

    csel	w15,	w22,	w15,	ne
    cmp	w23,	#0
    cset	w28,	ne
    ldr	w18,	[sp, #448]

    cmp	w18,	#0
    movz	w14,	#0
    csel	w1,	w28,	w14,	ne
    cmp	w9,	#0
    cset	w5,	ne
    cmp	w6,	#0
    movz	w13,	#0
    csel	w16,	w5,	w13,	ne
    cmp	w16,	#0
    cset	w5,	ne
    cmp	w1,	#0
    movz	w14,	#1
    ldr	w28,	[sp, #920]

    csel	w24,	w14,	w5,	ne
    cmp	w28,	#0
    cset	w9,	ne
    ldr	w6,	[sp, #916]

    cmp	w6,	#0
    ldr	w0,	[sp, #920]

    movz	w12,	#1
    csel	w28,	w12,	w9,	ne
    cmp	w0,	#0
    ldr	w7,	[sp, #916]

    cset	w14,	ne
    cmp	w7,	#0
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
    ldr	w9,	[sp, #364]

    movz	w8,	#0
    ldr	w12,	[sp, #368]

    csel	w17,	w5,	w8,	ne
    lsl	w18,	w17,	#1
    add	w19,	w18,	w15
    lsl	w20,	w19,	#1
    add	w17,	w20,	w2
    lsl	w18,	w17,	#1
    add	w11,	w18,	w4
    lsl	w13,	w11,	#1
    add	w13,	w13,	w9
    lsl	w15,	w13,	#1
    add	w15,	w15,	w12
    lsl	w17,	w15,	#1
    ldr	w15,	[sp, #372]

    ldr	w18,	[sp, #376]

    add	w17,	w17,	w15
    ldr	w22,	[sp, #380]

    ldr	w25,	[sp, #384]

    lsl	w19,	w17,	#1
    ldr	w28,	[sp, #388]

    ldr	w2,	[sp, #392]

    add	w19,	w19,	w18
    ldr	w5,	[sp, #396]

    ldr	w11,	[sp, #404]

    ldr	w8,	[sp, #400]

    lsl	w20,	w19,	#1
    add	w23,	w20,	w22
    lsl	w24,	w23,	#1
    add	w25,	w24,	w25
    lsl	w26,	w25,	#1
    add	w27,	w26,	w28
    lsl	w0,	w27,	#1
    add	w0,	w0,	w2
    lsl	w0,	w0,	#1
    add	w1,	w0,	w5
    lsl	w2,	w1,	#1
    add	w3,	w2,	w11
    lsl	w4,	w3,	#1
    add	w5,	w4,	w8
    lsl	w6,	w5,	#1
    add	w0,	w6,	w21
    b	fib_1892

fib_1891:
    movz	w0,	#1

fib_1892:
    movz	w17,	#1
    ldr	x13,	[sp, #248]

    str	w17,	[x13]

    ldr	x9,	[sp, #240]

    ldr	w14,	[sp, #264]

    str	w14,	[x9]

    ldr	x9,	[sp, #256]

    add	x11,	x9,	#4
    str	w0,	[x11]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #1248
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
    movz	w0,	#102
    add	w23,	w20,	#1
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


