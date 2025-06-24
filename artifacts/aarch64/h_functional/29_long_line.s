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
    sub	sp, sp, #1264
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	w1,	w0
    movz	x7,	#40763
    movz	x8,	#40763
    movz	x17,	#65535
    movz	fp,	#508
    lsr	w0,	w1,	#16
    movk	x7,	#1117,	lsl #16
    movk	x8,	#1117,	lsl #16
    eor	w25,	w1,	w0
    mul	w26,	w25,	w8
    lsr	w4,	w26,	#16
    eor	w0,	w26,	w4
    mul	w0,	w0,	w7
    lsr	w8,	w0,	#16
    eor	w14,	w0,	w8
    str	w14,	[sp, #516]

    ldr	w14,	[sp, #516]

    and	w9,	w14,	w17
    adrp	x14, :got:memo.lut.fib
    lsl	w10,	w9,	#3
    ldr	x14, [x14, #:got_lo12:memo.lut.fib]
    lsl	w6,	w10,	#0
    add	x8,	x14,	x6
    str	x8,	[sp, fp]

    movz	fp,	#508
    ldr	x4,	[sp, fp]

    movz	fp,	#500
    str	x4,	[sp, fp]

    movz	fp,	#500
    ldr	x5,	[sp, fp]

    movz	fp,	#508
    ldr	w12,	[x5]

    ldr	x9,	[sp, fp]

    add	x0,	x9,	#8
    cmp	w12,	#0
    beq	fib_25

fib_17:
    ldr	w15,	[x0]

    ldr	w17,	[sp, #516]

    cmp	w15,	w17
    bne	fib_27

fib_21:
    movz	fp,	#508
    ldr	x10,	[sp, fp]

    add	x1,	x10,	#4
    ldr	w0,	[x1]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #1264
    ret


fib_27:
    movz	fp,	#492
    str	x0,	[sp, fp]

    b	fib_28

fib_25:
    movz	fp,	#492
    str	x0,	[sp, fp]


fib_28:
    cmp	w1,	#2
    ble	fib_1891

fib_31:
    asr	w25,	w1,	#31
    movz	w23,	#0
    lsr	w0,	w25,	#31
    add	w28,	w1,	w0
    asr	w24,	w28,	#1
    lsl	w25,	w24,	#1
    sub	w18,	w1,	w25
    str	w18,	[sp, #468]

    ldr	w18,	[sp, #468]

    sub	w0,	w23,	w18
    str	w0,	[sp, #392]

    ldr	w20,	[sp, #468]

    cmp	w20,	#0
    ldr	w18,	[sp, #392]

    asr	w24,	w1,	#31
    ldr	w20,	[sp, #468]

    lsr	w25,	w24,	#31
    csel	w26,	w18,	w20,	lt
    str	w26,	[sp, #812]

    add	w19,	w1,	w25
    asr	w22,	w19,	#1
    movz	w19,	#0
    asr	w28,	w22,	#31
    lsr	w0,	w28,	#31
    add	w18,	w22,	w0
    asr	w28,	w18,	#1
    lsl	w0,	w28,	#1
    sub	w20,	w22,	w0
    str	w20,	[sp, #476]

    ldr	w21,	[sp, #476]

    sub	w24,	w19,	w21
    str	w24,	[sp, #408]

    ldr	w0,	[sp, #476]

    cmp	w0,	#0
    ldr	w25,	[sp, #408]

    movz	w21,	#0
    ldr	w23,	[sp, #476]

    csel	w27,	w25,	w23,	lt
    asr	w25,	w22,	#31
    str	w27,	[sp, #808]

    lsr	w26,	w25,	#31
    add	w23,	w22,	w26
    asr	w25,	w23,	#1
    asr	w0,	w25,	#31
    lsr	w18,	w0,	#31
    add	w0,	w25,	w18
    asr	w26,	w0,	#1
    lsl	w27,	w26,	#1
    sub	w27,	w25,	w27
    str	w27,	[sp, #480]

    ldr	w18,	[sp, #480]

    sub	w27,	w21,	w18
    str	w27,	[sp, #424]

    ldr	w0,	[sp, #480]

    cmp	w0,	#0
    ldr	w28,	[sp, #424]

    asr	w19,	w25,	#31
    ldr	w21,	[sp, #480]

    lsr	w20,	w19,	#31
    csel	w18,	w28,	w21,	lt
    str	w18,	[sp, #1000]

    add	w24,	w25,	w20
    asr	w27,	w24,	#1
    asr	w23,	w27,	#31
    lsr	w0,	w23,	#31
    add	w24,	w27,	w0
    movz	w0,	#0
    asr	w20,	w24,	#1
    lsl	w22,	w20,	#1
    sub	w20,	w27,	w22
    str	w20,	[sp, #488]

    ldr	w26,	[sp, #488]

    sub	w21,	w0,	w26
    str	w21,	[sp, #436]

    ldr	w22,	[sp, #488]

    cmp	w22,	#0
    asr	w25,	w27,	#31
    ldr	w22,	[sp, #436]

    ldr	w0,	[sp, #488]

    lsr	w26,	w25,	#31
    csel	w0,	w22,	w0,	lt
    str	w0,	[sp, #816]

    add	w26,	w27,	w26
    movz	w0,	#0
    asr	w21,	w26,	#1
    asr	w20,	w21,	#31
    lsr	w23,	w20,	#31
    add	w24,	w21,	w23
    asr	w20,	w24,	#1
    lsl	w23,	w20,	#1
    sub	w24,	w21,	w23
    str	w24,	[sp, #484]

    ldr	w28,	[sp, #484]

    sub	w0,	w0,	w28
    str	w0,	[sp, #448]

    ldr	w25,	[sp, #484]

    cmp	w25,	#0
    ldr	w25,	[sp, #448]

    movz	w22,	#0
    ldr	w19,	[sp, #484]

    csel	w26,	w25,	w19,	lt
    asr	w19,	w21,	#31
    str	w26,	[sp, #996]

    lsr	w0,	w19,	#31
    add	w0,	w21,	w0
    asr	w20,	w0,	#1
    asr	w21,	w20,	#31
    lsr	w26,	w21,	#31
    add	w0,	w20,	w26
    asr	w21,	w0,	#1
    lsl	w26,	w21,	#1
    sub	w26,	w20,	w26
    str	w26,	[sp, #472]

    ldr	w0,	[sp, #472]

    sub	w26,	w22,	w0
    str	w26,	[sp, #460]

    ldr	w26,	[sp, #472]

    cmp	w26,	#0
    asr	w19,	w20,	#31
    ldr	w28,	[sp, #460]

    ldr	w21,	[sp, #472]

    lsr	w0,	w19,	#31
    csel	w28,	w28,	w21,	lt
    str	w28,	[sp, #104]

    add	w26,	w20,	w0
    asr	w19,	w26,	#1
    asr	w25,	w19,	#31
    lsr	w26,	w25,	#31
    add	w28,	w19,	w26
    asr	w25,	w28,	#1
    lsl	w26,	w25,	#1
    sub	w22,	w19,	w26
    str	w22,	[sp, #464]

    movz	w22,	#0
    ldr	w23,	[sp, #464]

    sub	w28,	w22,	w23
    str	w28,	[sp, #452]

    ldr	w26,	[sp, #464]

    cmp	w26,	#0
    ldr	w0,	[sp, #452]

    ldr	w25,	[sp, #464]

    csel	w0,	w0,	w25,	lt
    asr	w25,	w19,	#31
    str	w0,	[sp, #164]

    lsr	w26,	w25,	#31
    add	w19,	w19,	w26
    asr	w0,	w19,	#1
    asr	w20,	w0,	#31
    lsr	w26,	w20,	#31
    add	w28,	w0,	w26
    movz	w26,	#0
    asr	w28,	w28,	#1
    lsl	w19,	w28,	#1
    sub	w21,	w0,	w19
    str	w21,	[sp, #456]

    ldr	w22,	[sp, #456]

    sub	w20,	w26,	w22
    str	w20,	[sp, #440]

    ldr	w25,	[sp, #456]

    cmp	w25,	#0
    ldr	w19,	[sp, #440]

    ldr	w26,	[sp, #456]

    csel	w22,	w19,	w26,	lt
    asr	w19,	w0,	#31
    str	w22,	[sp, #108]

    lsr	w20,	w19,	#31
    add	w0,	w0,	w20
    asr	w21,	w0,	#1
    asr	w19,	w21,	#31
    lsr	w0,	w19,	#31
    add	w26,	w21,	w0
    asr	w19,	w26,	#1
    lsl	w0,	w19,	#1
    sub	w26,	w21,	w0
    str	w26,	[sp, #444]

    ldr	w25,	[sp, #444]

    movz	w26,	#0
    sub	w0,	w26,	w25
    str	w0,	[sp, #428]

    ldr	w26,	[sp, #444]

    cmp	w26,	#0
    ldr	w25,	[sp, #428]

    ldr	w28,	[sp, #444]

    csel	w26,	w25,	w28,	lt
    str	w26,	[sp, #128]

    asr	w26,	w21,	#31
    lsr	w19,	w26,	#31
    add	w0,	w21,	w19
    asr	w26,	w0,	#1
    str	w26,	[sp, #792]

    movz	w26,	#0
    ldr	w27,	[sp, #792]

    ldr	w21,	[sp, #792]

    asr	w23,	w27,	#31
    ldr	w22,	[sp, #792]

    lsr	w0,	w23,	#31
    add	w23,	w21,	w0
    asr	w23,	w23,	#1
    lsl	w0,	w23,	#1
    sub	w19,	w22,	w0
    str	w19,	[sp, #432]

    ldr	w0,	[sp, #432]

    sub	w22,	w26,	w0
    str	w22,	[sp, #416]

    ldr	w23,	[sp, #432]

    cmp	w23,	#0
    ldr	w19,	[sp, #416]

    ldr	w24,	[sp, #432]

    csel	w0,	w19,	w24,	lt
    str	w0,	[sp, #168]

    ldr	w18,	[sp, #792]

    ldr	w24,	[sp, #792]

    asr	w0,	w18,	#31
    lsr	w0,	w0,	#31
    add	w0,	w24,	w0
    asr	w25,	w0,	#1
    movz	w0,	#0
    asr	w24,	w25,	#31
    lsr	w24,	w24,	#31
    add	w24,	w25,	w24
    asr	w24,	w24,	#1
    lsl	w24,	w24,	#1
    sub	w19,	w25,	w24
    str	w19,	[sp, #420]

    ldr	w24,	[sp, #420]

    sub	w0,	w0,	w24
    str	w0,	[sp, #404]

    ldr	w0,	[sp, #420]

    cmp	w0,	#0
    ldr	w23,	[sp, #404]

    asr	w24,	w25,	#31
    movz	w20,	#0
    ldr	w19,	[sp, #420]

    lsr	w24,	w24,	#31
    csel	w19,	w23,	w19,	lt
    str	w19,	[sp, #312]

    add	w0,	w25,	w24
    asr	w19,	w0,	#1
    asr	w21,	w19,	#31
    lsr	w21,	w21,	#31
    add	w21,	w19,	w21
    asr	w21,	w21,	#1
    lsl	w21,	w21,	#1
    sub	w0,	w19,	w21
    str	w0,	[sp, #412]

    ldr	w22,	[sp, #412]

    sub	w20,	w20,	w22
    str	w20,	[sp, #396]

    ldr	w0,	[sp, #412]

    cmp	w0,	#0
    asr	w21,	w19,	#31
    ldr	w20,	[sp, #396]

    ldr	w0,	[sp, #412]

    lsr	w21,	w21,	#31
    csel	w25,	w20,	w0,	lt
    str	w25,	[sp, #224]

    add	w0,	w19,	w21
    asr	w26,	w0,	#1
    movz	w0,	#0
    asr	w24,	w26,	#31
    lsr	w24,	w24,	#31
    add	w24,	w26,	w24
    asr	w24,	w24,	#1
    lsl	w24,	w24,	#1
    sub	w20,	w26,	w24
    str	w20,	[sp, #400]

    ldr	w19,	[sp, #400]

    sub	w21,	w0,	w19
    str	w21,	[sp, #384]

    ldr	w24,	[sp, #400]

    cmp	w24,	#0
    asr	w24,	w26,	#31
    ldr	w22,	[sp, #384]

    ldr	w25,	[sp, #400]

    lsr	w24,	w24,	#31
    csel	w19,	w22,	w25,	lt
    str	w19,	[sp, #240]

    add	w0,	w26,	w24
    movz	w19,	#0
    asr	w22,	w0,	#1
    asr	w20,	w22,	#31
    lsr	w20,	w20,	#31
    add	w20,	w22,	w20
    asr	w20,	w20,	#1
    lsl	w20,	w20,	#1
    sub	w0,	w22,	w20
    str	w0,	[sp, #388]

    ldr	w21,	[sp, #388]

    sub	w20,	w19,	w21
    str	w20,	[sp, #376]

    ldr	w0,	[sp, #388]

    cmp	w0,	#0
    asr	w20,	w22,	#31
    ldr	w23,	[sp, #376]

    movz	w19,	#0
    ldr	w0,	[sp, #388]

    lsr	w20,	w20,	#31
    csel	w0,	w23,	w0,	lt
    str	w0,	[sp, #332]

    add	w0,	w22,	w20
    asr	w23,	w0,	#1
    asr	w20,	w23,	#31
    lsr	w20,	w20,	#31
    add	w20,	w23,	w20
    asr	w20,	w20,	#1
    lsl	w20,	w20,	#1
    sub	w28,	w23,	w20
    str	w28,	[sp, #380]

    ldr	w0,	[sp, #380]

    sub	w19,	w19,	w0
    str	w19,	[sp, #368]

    ldr	w19,	[sp, #380]

    cmp	w19,	#0
    ldr	w24,	[sp, #368]

    asr	w20,	w23,	#31
    ldr	w0,	[sp, #380]

    lsr	w20,	w20,	#31
    csel	w21,	w24,	w0,	lt
    str	w21,	[sp, #352]

    add	w0,	w23,	w20
    asr	w26,	w0,	#1
    str	w26,	[sp, #172]

    ldr	w27,	[sp, #172]

    movz	w26,	#0
    asr	w0,	w27,	#31
    ldr	w18,	[sp, #172]

    ldr	w19,	[sp, #172]

    lsr	w0,	w0,	#31
    add	w0,	w18,	w0
    asr	w0,	w0,	#1
    lsl	w0,	w0,	#1
    sub	w23,	w19,	w0
    str	w23,	[sp, #372]

    ldr	w20,	[sp, #372]

    sub	w25,	w26,	w20
    str	w25,	[sp, #364]

    ldr	w25,	[sp, #372]

    cmp	w25,	#0
    ldr	w21,	[sp, #364]

    ldr	w26,	[sp, #372]

    csel	w26,	w21,	w26,	lt
    str	w26,	[sp, #348]

    ldr	w27,	[sp, #812]

    cmp	w27,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w26,	ne
    mov	w23,	w26
    str	w23,	[sp, #356]

    ldr	w28,	[sp, #812]

    cmp	w28,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w26,	ne
    mov	w25,	w26
    str	w25,	[sp, #184]

    ldr	w23,	[sp, #808]

    cmp	w23,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w25,	ne
    mov	w28,	w25
    str	w28,	[sp, #96]

    ldr	w26,	[sp, #184]

    cmp	w26,	#0
    ldr	w28,	[sp, #96]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w28,	#0
    movz	w26,	#1
    csel	w22,	w26,	w0,	ne
    str	w22,	[sp, #100]

    ldr	w27,	[sp, #184]

    cmp	w27,	#0
    ldr	w19,	[sp, #96]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w19,	#0
    movz	w26,	#0
    csel	w0,	w0,	w26,	ne
    cmp	w0,	#0
    cset	w26,	eq
    cmp	w26,	#0
    ldr	w22,	[sp, #100]

    cset	w26,	ne
    mov	w0,	w26
    cmp	w22,	#0
    movz	w25,	#0
    csel	w22,	w0,	w25,	ne
    str	w22,	[sp, #340]

    ldr	w24,	[sp, #808]

    cmp	w24,	#0
    cset	w25,	ne
    mov	w27,	w25
    str	w27,	[sp, #1068]

    ldr	w28,	[sp, #184]

    cmp	w28,	#0
    cset	w23,	ne
    ldr	w19,	[sp, #96]

    cmp	w19,	#0
    movz	w0,	#0
    csel	w22,	w23,	w0,	ne
    cmp	w22,	#0
    cset	w26,	ne
    ldr	w27,	[sp, #1068]

    mov	w0,	w26
    cmp	w27,	#0
    movz	w23,	#1
    csel	w21,	w23,	w0,	ne
    str	w21,	[sp, #964]

    ldr	w26,	[sp, #1000]

    cmp	w26,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w26,	ne
    str	w26,	[sp, #968]

    ldr	w0,	[sp, #964]

    cmp	w0,	#0
    ldr	w19,	[sp, #968]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w19,	#0
    movz	w25,	#1
    csel	w18,	w25,	w0,	ne
    str	w18,	[sp, #188]

    ldr	w23,	[sp, #964]

    cmp	w23,	#0
    cset	w25,	ne
    mov	w22,	w25
    str	w22,	[sp, #308]

    ldr	w28,	[sp, #968]

    cmp	w28,	#0
    movz	w25,	#0
    ldr	w19,	[sp, #308]

    csel	w28,	w19,	w25,	ne
    cmp	w28,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w25,	ne
    ldr	w22,	[sp, #188]

    mov	w0,	w25
    cmp	w22,	#0
    movz	w26,	#0
    csel	w22,	w0,	w26,	ne
    str	w22,	[sp, #252]

    ldr	w27,	[sp, #1000]

    cmp	w27,	#0
    ldr	w26,	[sp, #964]

    cset	w23,	ne
    cmp	w26,	#0
    cset	w0,	ne
    ldr	w21,	[sp, #968]

    cmp	w21,	#0
    movz	w28,	#0
    csel	w28,	w0,	w28,	ne
    cmp	w28,	#0
    cset	w20,	ne
    cmp	w23,	#0
    movz	w23,	#1
    csel	w0,	w23,	w20,	ne
    str	w0,	[sp, #976]

    ldr	w19,	[sp, #816]

    cmp	w19,	#0
    cset	w28,	ne
    cmp	w28,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w24,	ne
    mov	w27,	w24
    str	w27,	[sp, #980]

    ldr	w23,	[sp, #976]

    cmp	w23,	#0
    cset	w24,	ne
    ldr	w20,	[sp, #980]

    mov	w21,	w24
    cmp	w20,	#0
    movz	w20,	#1
    csel	w19,	w20,	w21,	ne
    str	w19,	[sp, #972]

    ldr	w24,	[sp, #976]

    cmp	w24,	#0
    cset	w20,	ne
    mov	w24,	w20
    ldr	w20,	[sp, #980]

    cmp	w20,	#0
    movz	w28,	#0
    csel	w19,	w24,	w28,	ne
    cmp	w19,	#0
    cset	w28,	eq
    cmp	w28,	#0
    ldr	w23,	[sp, #972]

    cset	w28,	ne
    cmp	w23,	#0
    movz	w0,	#0
    csel	w23,	w28,	w0,	ne
    str	w23,	[sp, #216]

    ldr	w20,	[sp, #816]

    cmp	w20,	#0
    cset	w28,	ne
    mov	w23,	w28
    str	w23,	[sp, #596]

    ldr	w25,	[sp, #976]

    cmp	w25,	#0
    cset	w20,	ne
    ldr	w23,	[sp, #980]

    cmp	w23,	#0
    movz	w26,	#0
    csel	w0,	w20,	w26,	ne
    cmp	w0,	#0
    cset	w24,	ne
    ldr	w21,	[sp, #596]

    mov	w0,	w24
    cmp	w21,	#0
    movz	w28,	#1
    csel	w28,	w28,	w0,	ne
    str	w28,	[sp, #992]

    ldr	w0,	[sp, #996]

    cmp	w0,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w20,	ne
    mov	w23,	w20
    str	w23,	[sp, #988]

    ldr	w0,	[sp, #992]

    cmp	w0,	#0
    cset	w24,	ne
    ldr	w28,	[sp, #988]

    mov	w22,	w24
    cmp	w28,	#0
    movz	w18,	#1
    csel	w20,	w18,	w22,	ne
    str	w20,	[sp, #984]

    ldr	w18,	[sp, #992]

    cmp	w18,	#0
    cset	w28,	ne
    ldr	w0,	[sp, #988]

    mov	w22,	w28
    cmp	w0,	#0
    movz	w28,	#0
    csel	w19,	w22,	w28,	ne
    cmp	w19,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w18,	ne
    ldr	w25,	[sp, #984]

    cmp	w25,	#0
    movz	w22,	#0
    csel	w23,	w18,	w22,	ne
    str	w23,	[sp, #204]

    ldr	w23,	[sp, #996]

    cmp	w23,	#0
    cset	w23,	ne
    mov	w27,	w23
    str	w27,	[sp, #588]

    ldr	w19,	[sp, #992]

    cmp	w19,	#0
    cset	w0,	ne
    ldr	w20,	[sp, #988]

    cmp	w20,	#0
    movz	w21,	#0
    csel	w26,	w0,	w21,	ne
    cmp	w26,	#0
    cset	w28,	ne
    ldr	w24,	[sp, #588]

    mov	w21,	w28
    cmp	w24,	#0
    movz	w0,	#1
    csel	w19,	w0,	w21,	ne
    str	w19,	[sp, #144]

    ldr	w23,	[sp, #104]

    cmp	w23,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w18,	ne
    mov	w26,	w18
    str	w26,	[sp, #600]

    ldr	w20,	[sp, #144]

    cmp	w20,	#0
    ldr	w24,	[sp, #600]

    cset	w21,	ne
    mov	w19,	w21
    cmp	w24,	#0
    movz	w21,	#1
    csel	w0,	w21,	w19,	ne
    str	w0,	[sp, #132]

    ldr	w21,	[sp, #144]

    cmp	w21,	#0
    cset	w0,	ne
    ldr	w25,	[sp, #600]

    cmp	w25,	#0
    movz	w18,	#0
    csel	w21,	w0,	w18,	ne
    cmp	w21,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w21,	ne
    ldr	w20,	[sp, #132]

    mov	w24,	w21
    cmp	w20,	#0
    movz	w28,	#0
    csel	w27,	w24,	w28,	ne
    str	w27,	[sp, #292]

    ldr	w24,	[sp, #104]

    cmp	w24,	#0
    cset	w28,	ne
    mov	w23,	w28
    str	w23,	[sp, #580]

    ldr	w0,	[sp, #144]

    cmp	w0,	#0
    cset	w20,	ne
    ldr	w26,	[sp, #600]

    mov	w0,	w20
    cmp	w26,	#0
    movz	w19,	#0
    csel	w21,	w0,	w19,	ne
    cmp	w21,	#0
    ldr	w20,	[sp, #580]

    cset	w26,	ne
    mov	w18,	w26
    cmp	w20,	#0
    movz	w20,	#1
    csel	w24,	w20,	w18,	ne
    str	w24,	[sp, #148]

    ldr	w19,	[sp, #164]

    cmp	w19,	#0
    cset	w19,	ne
    cmp	w19,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w26,	ne
    mov	w19,	w26
    str	w19,	[sp, #604]

    ldr	w25,	[sp, #148]

    cmp	w25,	#0
    ldr	w28,	[sp, #604]

    cset	w23,	ne
    mov	w19,	w23
    cmp	w28,	#0
    movz	w28,	#1
    csel	w25,	w28,	w19,	ne
    str	w25,	[sp, #136]

    ldr	w26,	[sp, #148]

    cmp	w26,	#0
    ldr	w18,	[sp, #604]

    cset	w20,	ne
    mov	w27,	w20
    cmp	w18,	#0
    movz	w26,	#0
    csel	w28,	w27,	w26,	ne
    cmp	w28,	#0
    cset	w20,	eq
    cmp	w20,	#0
    ldr	w24,	[sp, #136]

    cset	w26,	ne
    mov	w19,	w26
    cmp	w24,	#0
    movz	w18,	#0
    csel	w28,	w19,	w18,	ne
    str	w28,	[sp, #140]

    ldr	w20,	[sp, #164]

    cmp	w20,	#0
    ldr	w25,	[sp, #148]

    cset	w0,	ne
    cmp	w25,	#0
    ldr	w24,	[sp, #604]

    cset	w25,	ne
    mov	w20,	w25
    cmp	w24,	#0
    movz	w18,	#0
    csel	w19,	w20,	w18,	ne
    cmp	w19,	#0
    cset	w21,	ne
    mov	w25,	w21
    cmp	w0,	#0
    movz	w26,	#1
    csel	w0,	w26,	w25,	ne
    str	w0,	[sp, #152]

    ldr	w27,	[sp, #108]

    cmp	w27,	#0
    cset	w23,	ne
    cmp	w23,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w28,	ne
    mov	w24,	w28
    str	w24,	[sp, #1056]

    ldr	w18,	[sp, #152]

    cmp	w18,	#0
    cset	w23,	ne
    mov	w19,	w23
    ldr	w23,	[sp, #1056]

    cmp	w23,	#0
    movz	w28,	#1
    csel	w18,	w28,	w19,	ne
    str	w18,	[sp, #112]

    ldr	w19,	[sp, #152]

    cmp	w19,	#0
    cset	w20,	ne
    ldr	w23,	[sp, #1056]

    mov	w25,	w20
    cmp	w23,	#0
    movz	w0,	#0
    csel	w0,	w25,	w0,	ne
    cmp	w0,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w26,	ne
    mov	w19,	w26
    ldr	w26,	[sp, #112]

    cmp	w26,	#0
    movz	w28,	#0
    csel	w21,	w19,	w28,	ne
    str	w21,	[sp, #116]

    ldr	w28,	[sp, #108]

    cmp	w28,	#0
    cset	w0,	ne
    mov	w20,	w0
    str	w20,	[sp, #572]

    ldr	w20,	[sp, #152]

    cmp	w20,	#0
    cset	w0,	ne
    mov	w27,	w0
    ldr	w0,	[sp, #1056]

    cmp	w0,	#0
    movz	w23,	#0
    csel	w18,	w27,	w23,	ne
    cmp	w18,	#0
    ldr	w28,	[sp, #572]

    cset	w21,	ne
    mov	w25,	w21
    cmp	w28,	#0
    movz	w0,	#1
    csel	w19,	w0,	w25,	ne
    str	w19,	[sp, #176]

    ldr	w19,	[sp, #128]

    cmp	w19,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w20,	ne
    mov	w18,	w20
    str	w18,	[sp, #592]

    ldr	w20,	[sp, #176]

    cmp	w20,	#0
    ldr	w26,	[sp, #592]

    cset	w23,	ne
    mov	w19,	w23
    cmp	w26,	#0
    movz	w18,	#1
    csel	w0,	w18,	w19,	ne
    str	w0,	[sp, #156]

    ldr	w21,	[sp, #176]

    cmp	w21,	#0
    ldr	w27,	[sp, #592]

    cset	w21,	ne
    mov	w19,	w21
    cmp	w27,	#0
    movz	w0,	#0
    csel	w0,	w19,	w0,	ne
    cmp	w0,	#0
    cset	w21,	eq
    cmp	w21,	#0
    ldr	w22,	[sp, #156]

    cset	w26,	ne
    cmp	w22,	#0
    movz	w21,	#0
    csel	w24,	w26,	w21,	ne
    str	w24,	[sp, #120]

    ldr	w20,	[sp, #128]

    cmp	w20,	#0
    ldr	w24,	[sp, #176]

    cset	w0,	ne
    cmp	w24,	#0
    cset	w26,	ne
    ldr	w18,	[sp, #592]

    mov	w20,	w26
    cmp	w18,	#0
    movz	w18,	#0
    csel	w25,	w20,	w18,	ne
    cmp	w25,	#0
    cset	w27,	ne
    mov	w21,	w27
    cmp	w0,	#0
    movz	w20,	#1
    csel	w25,	w20,	w21,	ne
    str	w25,	[sp, #160]

    ldr	w23,	[sp, #168]

    cmp	w23,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w23,	ne
    mov	w0,	w23
    str	w0,	[sp, #1060]

    ldr	w26,	[sp, #160]

    cmp	w26,	#0
    ldr	w28,	[sp, #1060]

    cset	w0,	ne
    mov	w27,	w0
    cmp	w28,	#0
    movz	w21,	#1
    csel	w27,	w21,	w27,	ne
    str	w27,	[sp, #124]

    ldr	w27,	[sp, #160]

    cmp	w27,	#0
    cset	w21,	ne
    ldr	w0,	[sp, #1060]

    mov	w25,	w21
    cmp	w0,	#0
    movz	w18,	#0
    csel	w0,	w25,	w18,	ne
    cmp	w0,	#0
    cset	w21,	eq
    cmp	w21,	#0
    ldr	w0,	[sp, #124]

    cset	w23,	ne
    mov	w27,	w23
    cmp	w0,	#0
    movz	w0,	#0
    csel	w21,	w27,	w0,	ne
    str	w21,	[sp, #796]

    ldr	w24,	[sp, #168]

    cmp	w24,	#0
    ldr	w27,	[sp, #160]

    cset	w0,	ne
    cmp	w27,	#0
    ldr	w24,	[sp, #1060]

    cset	w25,	ne
    mov	w20,	w25
    cmp	w24,	#0
    movz	w18,	#0
    csel	w28,	w20,	w18,	ne
    cmp	w28,	#0
    cset	w18,	ne
    cmp	w0,	#0
    movz	w24,	#1
    csel	w24,	w24,	w18,	ne
    str	w24,	[sp, #800]

    ldr	w21,	[sp, #312]

    cmp	w21,	#0
    cset	w21,	ne
    cmp	w21,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w0,	ne
    str	w0,	[sp, #1064]

    ldr	w25,	[sp, #800]

    cmp	w25,	#0
    cset	w24,	ne
    ldr	w22,	[sp, #1064]

    mov	w18,	w24
    cmp	w22,	#0
    movz	w24,	#1
    csel	w0,	w24,	w18,	ne
    str	w0,	[sp, #784]

    ldr	w26,	[sp, #800]

    cmp	w26,	#0
    ldr	w23,	[sp, #1064]

    cset	w21,	ne
    mov	w0,	w21
    cmp	w23,	#0
    movz	w21,	#0
    csel	w0,	w0,	w21,	ne
    cmp	w0,	#0
    cset	w21,	eq
    cmp	w21,	#0
    ldr	w26,	[sp, #784]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w26,	#0
    movz	w18,	#0
    csel	w27,	w0,	w18,	ne
    str	w27,	[sp, #764]

    ldr	w0,	[sp, #312]

    cmp	w0,	#0
    ldr	w20,	[sp, #800]

    cset	w24,	ne
    mov	w19,	w24
    cmp	w20,	#0
    cset	w0,	ne
    ldr	w28,	[sp, #1064]

    cmp	w28,	#0
    movz	w22,	#0
    csel	w0,	w0,	w22,	ne
    cmp	w0,	#0
    cset	w0,	ne
    mov	w20,	w0
    cmp	w19,	#0
    movz	w0,	#1
    csel	w0,	w0,	w20,	ne
    str	w0,	[sp, #804]

    ldr	w28,	[sp, #224]

    cmp	w28,	#0
    cset	w25,	ne
    cmp	w25,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w20,	ne
    mov	w0,	w20
    str	w0,	[sp, #560]

    ldr	w18,	[sp, #804]

    cmp	w18,	#0
    cset	w24,	ne
    mov	w21,	w24
    ldr	w24,	[sp, #560]

    cmp	w24,	#0
    movz	w24,	#1
    csel	w18,	w24,	w21,	ne
    str	w18,	[sp, #768]

    ldr	w19,	[sp, #804]

    cmp	w19,	#0
    ldr	w25,	[sp, #560]

    cset	w0,	ne
    cmp	w25,	#0
    movz	w23,	#0
    csel	w24,	w0,	w23,	ne
    cmp	w24,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w24,	ne
    ldr	w22,	[sp, #768]

    mov	w0,	w24
    cmp	w22,	#0
    movz	w25,	#0
    csel	w27,	w0,	w25,	ne
    str	w27,	[sp, #748]

    ldr	w0,	[sp, #224]

    cmp	w0,	#0
    cset	w24,	ne
    mov	w26,	w24
    str	w26,	[sp, #740]

    ldr	w20,	[sp, #804]

    cmp	w20,	#0
    ldr	w25,	[sp, #560]

    cset	w0,	ne
    mov	w19,	w0
    cmp	w25,	#0
    movz	w25,	#0
    mov	w23,	w25
    csel	w20,	w19,	w23,	ne
    cmp	w20,	#0
    cset	w23,	ne
    ldr	w19,	[sp, #740]

    mov	w28,	w23
    cmp	w19,	#0
    movz	w25,	#1
    mov	w24,	w25
    csel	w21,	w24,	w28,	ne
    str	w21,	[sp, #772]

    ldr	w21,	[sp, #240]

    cmp	w21,	#0
    cset	w21,	ne
    cmp	w21,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w0,	ne
    str	w0,	[sp, #564]

    ldr	w0,	[sp, #772]

    cmp	w0,	#0
    ldr	w0,	[sp, #564]

    cset	w20,	ne
    mov	w26,	w20
    cmp	w0,	#0
    movz	w0,	#1
    csel	w26,	w0,	w26,	ne
    str	w26,	[sp, #776]

    ldr	w23,	[sp, #772]

    cmp	w23,	#0
    cset	w23,	ne
    ldr	w19,	[sp, #564]

    mov	w0,	w23
    cmp	w19,	#0
    movz	w25,	#0
    csel	w23,	w0,	w25,	ne
    cmp	w23,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w0,	ne
    ldr	w19,	[sp, #776]

    cmp	w19,	#0
    movz	w23,	#0
    mov	w20,	w23
    csel	w27,	w0,	w20,	ne
    str	w27,	[sp, #1092]

    ldr	w0,	[sp, #240]

    cmp	w0,	#0
    cset	w0,	ne
    ldr	w25,	[sp, #772]

    mov	w28,	w0
    cmp	w25,	#0
    cset	w0,	ne
    ldr	w19,	[sp, #564]

    cmp	w19,	#0
    movz	w26,	#0
    csel	w24,	w0,	w26,	ne
    cmp	w24,	#0
    cset	w25,	ne
    mov	w20,	w25
    cmp	w28,	#0
    movz	w0,	#1
    csel	w0,	w0,	w20,	ne
    str	w0,	[sp, #780]

    ldr	w23,	[sp, #332]

    cmp	w23,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w21,	eq
    cmp	w21,	#0
    cset	w23,	ne
    mov	w27,	w23
    str	w27,	[sp, #568]

    ldr	w18,	[sp, #780]

    cmp	w18,	#0
    ldr	w22,	[sp, #568]

    cset	w21,	ne
    mov	w25,	w21
    cmp	w22,	#0
    movz	w23,	#1
    csel	w18,	w23,	w25,	ne
    str	w18,	[sp, #752]

    ldr	w19,	[sp, #780]

    cmp	w19,	#0
    ldr	w23,	[sp, #568]

    cset	w0,	ne
    mov	w27,	w0
    cmp	w23,	#0
    movz	w0,	#0
    csel	w23,	w27,	w0,	ne
    cmp	w23,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w23,	ne
    ldr	w20,	[sp, #752]

    mov	w25,	w23
    cmp	w20,	#0
    movz	w23,	#0
    csel	w21,	w25,	w23,	ne
    str	w21,	[sp, #1084]

    ldr	w24,	[sp, #332]

    cmp	w24,	#0
    ldr	w24,	[sp, #780]

    cset	w23,	ne
    mov	w20,	w23
    cmp	w24,	#0
    ldr	w24,	[sp, #568]

    cset	w19,	ne
    mov	w22,	w19
    cmp	w24,	#0
    movz	w0,	#0
    csel	w28,	w22,	w0,	ne
    cmp	w28,	#0
    cset	w19,	ne
    mov	w25,	w19
    cmp	w20,	#0
    movz	w0,	#1
    csel	w0,	w0,	w25,	ne
    str	w0,	[sp, #1100]

    ldr	w27,	[sp, #352]

    cmp	w27,	#0
    cset	w23,	ne
    cmp	w23,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w23,	ne
    mov	w24,	w23
    str	w24,	[sp, #556]

    ldr	w23,	[sp, #1100]

    cmp	w23,	#0
    ldr	w18,	[sp, #556]

    cset	w0,	ne
    mov	w25,	w0
    cmp	w18,	#0
    movz	w19,	#1
    csel	w21,	w19,	w25,	ne
    str	w21,	[sp, #756]

    ldr	w24,	[sp, #1100]

    cmp	w24,	#0
    cset	w0,	ne
    mov	w21,	w0
    str	w21,	[sp, #280]

    ldr	w26,	[sp, #556]

    cmp	w26,	#0
    ldr	w21,	[sp, #280]

    movz	w0,	#0
    csel	w0,	w21,	w0,	ne
    cmp	w0,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w0,	ne
    ldr	w24,	[sp, #756]

    mov	w19,	w0
    cmp	w24,	#0
    movz	w25,	#0
    csel	w24,	w19,	w25,	ne
    str	w24,	[sp, #1088]

    ldr	w28,	[sp, #352]

    cmp	w28,	#0
    ldr	w24,	[sp, #1100]

    cset	w0,	ne
    mov	w25,	w0
    cmp	w24,	#0
    cset	w26,	ne
    ldr	w19,	[sp, #556]

    mov	w0,	w26
    cmp	w19,	#0
    movz	w18,	#0
    csel	w0,	w0,	w18,	ne
    cmp	w0,	#0
    cset	w26,	ne
    mov	w20,	w26
    cmp	w25,	#0
    movz	w0,	#1
    csel	w18,	w0,	w20,	ne
    str	w18,	[sp, #1096]

    ldr	w24,	[sp, #348]

    cmp	w24,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w0,	eq
    cmp	w0,	#0
    ldr	w19,	[sp, #1096]

    cset	w0,	ne
    mov	w25,	w0
    cmp	w19,	#0
    cset	w0,	ne
    mov	w26,	w0
    str	w26,	[sp, #284]

    cmp	w25,	#0
    ldr	w20,	[sp, #284]

    movz	w0,	#1
    csel	w24,	w0,	w20,	ne
    str	w24,	[sp, #760]

    ldr	w20,	[sp, #1096]

    cmp	w20,	#0
    cset	w26,	ne
    mov	w19,	w26
    cmp	w25,	#0
    movz	w0,	#0
    csel	w24,	w19,	w0,	ne
    cmp	w24,	#0
    cset	w24,	eq
    cmp	w24,	#0
    ldr	w25,	[sp, #760]

    cset	w24,	ne
    mov	w28,	w24
    cmp	w25,	#0
    movz	w0,	#0
    ldr	w25,	[sp, #1088]

    csel	w24,	w28,	w0,	ne
    ldr	w22,	[sp, #1084]

    lsl	w0,	w24,	#1
    ldr	w27,	[sp, #1092]

    ldr	w18,	[sp, #748]

    add	w24,	w0,	w25
    lsl	w0,	w24,	#1
    add	w0,	w0,	w22
    lsl	w0,	w0,	#1
    add	w24,	w0,	w27
    lsl	w0,	w24,	#1
    add	w24,	w0,	w18
    ldr	w18,	[sp, #764]

    ldr	w26,	[sp, #796]

    lsl	w25,	w24,	#1
    add	w20,	w25,	w18
    lsl	w21,	w20,	#1
    add	w0,	w21,	w26
    ldr	w21,	[sp, #120]

    ldr	w18,	[sp, #116]

    lsl	w23,	w0,	#1
    add	w0,	w23,	w21
    lsl	w23,	w0,	#1
    add	w25,	w23,	w18
    lsl	w26,	w25,	#1
    ldr	w25,	[sp, #140]

    ldr	w28,	[sp, #292]

    add	w26,	w26,	w25
    lsl	w0,	w26,	#1
    add	w28,	w0,	w28
    ldr	w0,	[sp, #204]

    ldr	w21,	[sp, #216]

    lsl	w22,	w28,	#1
    add	w18,	w22,	w0
    ldr	w0,	[sp, #252]

    lsl	w23,	w18,	#1
    ldr	w18,	[sp, #340]

    add	w20,	w23,	w21
    ldr	w19,	[sp, #356]

    lsl	w26,	w20,	#1
    add	w0,	w26,	w0
    lsl	w27,	w0,	#1
    add	w24,	w27,	w18
    lsl	w0,	w24,	#1
    add	w0,	w0,	w19
    bl	fib
    str	w0,	[sp, #360]

    ldr	w0,	[sp, #468]

    cmp	w0,	#0
    ldr	w19,	[sp, #392]

    ldr	w23,	[sp, #468]

    csel	w0,	w19,	w23,	lt
    str	w0,	[sp, #1136]

    ldr	w24,	[sp, #476]

    cmp	w24,	#0
    ldr	w26,	[sp, #408]

    ldr	w24,	[sp, #476]

    csel	w18,	w26,	w24,	lt
    str	w18,	[sp, #880]

    ldr	w19,	[sp, #480]

    cmp	w19,	#0
    ldr	w24,	[sp, #424]

    ldr	w21,	[sp, #480]

    csel	w25,	w24,	w21,	lt
    str	w25,	[sp, #1140]

    ldr	w21,	[sp, #488]

    cmp	w21,	#0
    ldr	w27,	[sp, #436]

    ldr	w0,	[sp, #488]

    csel	w0,	w27,	w0,	lt
    str	w0,	[sp, #528]

    ldr	w26,	[sp, #484]

    cmp	w26,	#0
    ldr	w18,	[sp, #448]

    ldr	w28,	[sp, #484]

    csel	w26,	w18,	w28,	lt
    str	w26,	[sp, #876]

    ldr	w0,	[sp, #472]

    cmp	w0,	#0
    ldr	w21,	[sp, #460]

    ldr	w0,	[sp, #472]

    csel	w18,	w21,	w0,	lt
    str	w18,	[sp, #868]

    ldr	w27,	[sp, #464]

    cmp	w27,	#0
    ldr	w0,	[sp, #452]

    ldr	w27,	[sp, #464]

    csel	w26,	w0,	w27,	lt
    str	w26,	[sp, #916]

    ldr	w28,	[sp, #456]

    cmp	w28,	#0
    ldr	w19,	[sp, #440]

    ldr	w26,	[sp, #456]

    csel	w18,	w19,	w26,	lt
    str	w18,	[sp, #920]

    ldr	w25,	[sp, #444]

    cmp	w25,	#0
    ldr	w22,	[sp, #428]

    ldr	w26,	[sp, #444]

    csel	w26,	w22,	w26,	lt
    str	w26,	[sp, #932]

    ldr	w0,	[sp, #432]

    cmp	w0,	#0
    ldr	w18,	[sp, #416]

    ldr	w23,	[sp, #432]

    csel	w0,	w18,	w23,	lt
    str	w0,	[sp, #872]

    ldr	w19,	[sp, #420]

    cmp	w19,	#0
    ldr	w25,	[sp, #404]

    ldr	w20,	[sp, #420]

    csel	w0,	w25,	w20,	lt
    str	w0,	[sp, #536]

    ldr	w20,	[sp, #412]

    cmp	w20,	#0
    ldr	w25,	[sp, #396]

    ldr	w21,	[sp, #412]

    csel	w27,	w25,	w21,	lt
    str	w27,	[sp, #320]

    ldr	w0,	[sp, #400]

    cmp	w0,	#0
    ldr	w22,	[sp, #384]

    ldr	w18,	[sp, #400]

    csel	w23,	w22,	w18,	lt
    str	w23,	[sp, #220]

    ldr	w26,	[sp, #388]

    cmp	w26,	#0
    ldr	w21,	[sp, #376]

    ldr	w27,	[sp, #388]

    csel	w0,	w21,	w27,	lt
    str	w0,	[sp, #248]

    ldr	w27,	[sp, #380]

    cmp	w27,	#0
    ldr	w21,	[sp, #368]

    ldr	w28,	[sp, #380]

    csel	w27,	w21,	w28,	lt
    str	w27,	[sp, #260]

    ldr	w28,	[sp, #372]

    cmp	w28,	#0
    ldr	w28,	[sp, #364]

    ldr	w0,	[sp, #372]

    csel	w19,	w28,	w0,	lt
    str	w19,	[sp, #328]

    ldr	w23,	[sp, #1136]

    cmp	w23,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w26,	ne
    mov	w20,	w26
    str	w20,	[sp, #344]

    ldr	w19,	[sp, #880]

    cmp	w19,	#0
    cset	w23,	ne
    cmp	w23,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w23,	ne
    cmp	w23,	#0
    cset	w23,	ne
    cmp	w23,	#0
    cset	w18,	ne
    mov	w23,	w18
    str	w23,	[sp, #336]

    ldr	w20,	[sp, #880]

    cmp	w20,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w26,	ne
    ldr	w25,	[sp, #1140]

    mov	w20,	w26
    cmp	w25,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w18,	ne
    mov	w0,	w18
    str	w0,	[sp, #268]

    cmp	w20,	#0
    cset	w28,	ne
    ldr	w24,	[sp, #268]

    mov	w25,	w28
    cmp	w24,	#0
    movz	w18,	#1
    csel	w21,	w18,	w25,	ne
    cmp	w20,	#0
    cset	w25,	ne
    mov	w18,	w25
    str	w18,	[sp, #264]

    ldr	w26,	[sp, #268]

    cmp	w26,	#0
    movz	w25,	#0
    ldr	w19,	[sp, #264]

    csel	w28,	w19,	w25,	ne
    cmp	w28,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w25,	ne
    cmp	w21,	#0
    movz	w18,	#0
    csel	w19,	w25,	w18,	ne
    str	w19,	[sp, #256]

    ldr	w26,	[sp, #1140]

    cmp	w26,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w20,	#0
    ldr	w27,	[sp, #268]

    cset	w26,	ne
    cmp	w27,	#0
    movz	w24,	#0
    csel	w21,	w26,	w24,	ne
    cmp	w21,	#0
    cset	w26,	ne
    cmp	w18,	#0
    movz	w18,	#1
    csel	w21,	w18,	w26,	ne
    ldr	w18,	[sp, #528]

    cmp	w18,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w26,	ne
    mov	w23,	w26
    cmp	w21,	#0
    cset	w18,	ne
    cmp	w23,	#0
    movz	w28,	#1
    csel	w18,	w28,	w18,	ne
    cmp	w21,	#0
    cset	w20,	ne
    str	w20,	[sp, #316]

    cmp	w23,	#0
    movz	w20,	#0
    ldr	w27,	[sp, #316]

    csel	w20,	w27,	w20,	ne
    cmp	w20,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w20,	ne
    cmp	w18,	#0
    movz	w28,	#0
    csel	w27,	w20,	w28,	ne
    str	w27,	[sp, #236]

    ldr	w18,	[sp, #528]

    cmp	w18,	#0
    cset	w20,	ne
    mov	w18,	w20
    cmp	w21,	#0
    cset	w20,	ne
    cmp	w23,	#0
    movz	w25,	#0
    csel	w25,	w20,	w25,	ne
    cmp	w25,	#0
    cset	w20,	ne
    cmp	w18,	#0
    ldr	w21,	[sp, #876]

    movz	w26,	#1
    csel	w25,	w26,	w20,	ne
    cmp	w21,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w26,	ne
    mov	w24,	w26
    cmp	w25,	#0
    cset	w18,	ne
    cmp	w24,	#0
    movz	w28,	#1
    csel	w20,	w28,	w18,	ne
    cmp	w25,	#0
    cset	w18,	ne
    cmp	w24,	#0
    movz	w26,	#0
    csel	w23,	w18,	w26,	ne
    cmp	w23,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w18,	ne
    cmp	w20,	#0
    movz	w28,	#0
    csel	w0,	w18,	w28,	ne
    str	w0,	[sp, #208]

    ldr	w20,	[sp, #876]

    cmp	w20,	#0
    cset	w18,	ne
    cmp	w25,	#0
    cset	w25,	ne
    cmp	w24,	#0
    movz	w28,	#0
    csel	w22,	w25,	w28,	ne
    cmp	w22,	#0
    cset	w21,	ne
    cmp	w18,	#0
    movz	w18,	#1
    csel	w0,	w18,	w21,	ne
    str	w0,	[sp, #1144]

    ldr	w19,	[sp, #868]

    cmp	w19,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w18,	eq
    cmp	w18,	#0
    ldr	w19,	[sp, #1144]

    cset	w26,	ne
    mov	w18,	w26
    cmp	w19,	#0
    cset	w21,	ne
    cmp	w18,	#0
    movz	w26,	#1
    ldr	w24,	[sp, #1144]

    csel	w28,	w26,	w21,	ne
    cmp	w24,	#0
    cset	w21,	ne
    mov	w20,	w21
    cmp	w18,	#0
    movz	w21,	#0
    csel	w20,	w20,	w21,	ne
    cmp	w20,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w20,	ne
    cmp	w28,	#0
    movz	w25,	#0
    csel	w26,	w20,	w25,	ne
    str	w26,	[sp, #304]

    ldr	w27,	[sp, #868]

    cmp	w27,	#0
    cset	w20,	ne
    ldr	w26,	[sp, #1144]

    mov	w25,	w20
    cmp	w26,	#0
    cset	w24,	ne
    cmp	w18,	#0
    movz	w18,	#0
    csel	w18,	w24,	w18,	ne
    cmp	w18,	#0
    cset	w26,	ne
    cmp	w25,	#0
    movz	w18,	#1
    csel	w24,	w18,	w26,	ne
    str	w24,	[sp, #1116]

    ldr	w18,	[sp, #916]

    cmp	w18,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w24,	eq
    cmp	w24,	#0
    cset	w26,	ne
    ldr	w23,	[sp, #1116]

    mov	w18,	w26
    cmp	w23,	#0
    cset	w20,	ne
    cmp	w18,	#0
    ldr	w23,	[sp, #1116]

    movz	w26,	#1
    csel	w25,	w26,	w20,	ne
    cmp	w23,	#0
    cset	w26,	ne
    mov	w22,	w26
    cmp	w18,	#0
    movz	w20,	#0
    csel	w24,	w22,	w20,	ne
    cmp	w24,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w22,	ne
    cmp	w25,	#0
    movz	w25,	#0
    csel	w24,	w22,	w25,	ne
    str	w24,	[sp, #952]

    ldr	w27,	[sp, #916]

    cmp	w27,	#0
    cset	w26,	ne
    ldr	w25,	[sp, #1116]

    mov	w21,	w26
    cmp	w25,	#0
    cset	w26,	ne
    cmp	w18,	#0
    movz	w18,	#0
    csel	w18,	w26,	w18,	ne
    cmp	w18,	#0
    cset	w23,	ne
    cmp	w21,	#0
    ldr	w0,	[sp, #920]

    movz	w20,	#1
    csel	w21,	w20,	w23,	ne
    cmp	w0,	#0
    cset	w27,	ne
    cmp	w27,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w26,	ne
    mov	w22,	w26
    cmp	w21,	#0
    cset	w26,	ne
    mov	w18,	w26
    cmp	w22,	#0
    movz	w20,	#1
    csel	w23,	w20,	w18,	ne
    cmp	w21,	#0
    cset	w18,	ne
    cmp	w22,	#0
    movz	w20,	#0
    csel	w27,	w18,	w20,	ne
    cmp	w27,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w26,	ne
    cmp	w23,	#0
    movz	w18,	#0
    csel	w28,	w26,	w18,	ne
    str	w28,	[sp, #956]

    ldr	w23,	[sp, #920]

    cmp	w23,	#0
    cset	w26,	ne
    mov	w18,	w26
    cmp	w21,	#0
    cset	w26,	ne
    cmp	w22,	#0
    movz	w21,	#0
    csel	w22,	w26,	w21,	ne
    cmp	w22,	#0
    cset	w25,	ne
    cmp	w18,	#0
    movz	w26,	#1
    csel	w0,	w26,	w25,	ne
    str	w0,	[sp, #1148]

    ldr	w27,	[sp, #932]

    cmp	w27,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w20,	ne
    ldr	w24,	[sp, #1148]

    mov	w22,	w20
    cmp	w24,	#0
    cset	w26,	ne
    cmp	w22,	#0
    movz	w24,	#1
    ldr	w28,	[sp, #1148]

    csel	w24,	w24,	w26,	ne
    cmp	w28,	#0
    cset	w23,	ne
    cmp	w22,	#0
    movz	w18,	#0
    csel	w18,	w23,	w18,	ne
    cmp	w18,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w18,	ne
    cmp	w24,	#0
    movz	w20,	#0
    csel	w28,	w18,	w20,	ne
    str	w28,	[sp, #944]

    ldr	w23,	[sp, #932]

    cmp	w23,	#0
    cset	w18,	ne
    mov	w21,	w18
    ldr	w18,	[sp, #1148]

    cmp	w18,	#0
    cset	w26,	ne
    cmp	w22,	#0
    movz	w23,	#0
    csel	w23,	w26,	w23,	ne
    cmp	w23,	#0
    cset	w26,	ne
    cmp	w21,	#0
    movz	w18,	#1
    csel	w19,	w18,	w26,	ne
    str	w19,	[sp, #524]

    ldr	w27,	[sp, #872]

    cmp	w27,	#0
    cset	w28,	ne
    cmp	w28,	#0
    cset	w22,	eq
    cmp	w22,	#0
    ldr	w0,	[sp, #524]

    cset	w20,	ne
    mov	w22,	w20
    cmp	w0,	#0
    cset	w18,	ne
    mov	w23,	w18
    cmp	w22,	#0
    ldr	w0,	[sp, #524]

    movz	w25,	#1
    csel	w21,	w25,	w23,	ne
    cmp	w0,	#0
    cset	w18,	ne
    cmp	w22,	#0
    movz	w20,	#0
    csel	w18,	w18,	w20,	ne
    cmp	w18,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w18,	ne
    cmp	w21,	#0
    movz	w25,	#0
    csel	w19,	w18,	w25,	ne
    str	w19,	[sp, #948]

    ldr	w26,	[sp, #872]

    cmp	w26,	#0
    cset	w18,	ne
    mov	w21,	w18
    ldr	w18,	[sp, #524]

    cmp	w18,	#0
    cset	w26,	ne
    cmp	w22,	#0
    movz	w23,	#0
    csel	w23,	w26,	w23,	ne
    cmp	w23,	#0
    cset	w27,	ne
    cmp	w21,	#0
    movz	w18,	#1
    csel	w0,	w18,	w27,	ne
    str	w0,	[sp, #744]

    ldr	w18,	[sp, #536]

    cmp	w18,	#0
    cset	w28,	ne
    cmp	w28,	#0
    cset	w22,	eq
    cmp	w22,	#0
    ldr	w21,	[sp, #744]

    cset	w26,	ne
    cmp	w21,	#0
    cset	w27,	ne
    cmp	w26,	#0
    movz	w23,	#1
    ldr	w19,	[sp, #744]

    csel	w23,	w23,	w27,	ne
    cmp	w19,	#0
    cset	w25,	ne
    mov	w21,	w25
    cmp	w26,	#0
    movz	w28,	#0
    csel	w28,	w21,	w28,	ne
    cmp	w28,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w21,	ne
    cmp	w23,	#0
    movz	w18,	#0
    csel	w0,	w21,	w18,	ne
    str	w0,	[sp, #960]

    ldr	w27,	[sp, #536]

    cmp	w27,	#0
    cset	w27,	ne
    ldr	w22,	[sp, #744]

    mov	w21,	w27
    cmp	w22,	#0
    cset	w23,	ne
    cmp	w26,	#0
    movz	w24,	#0
    csel	w23,	w23,	w24,	ne
    cmp	w23,	#0
    cset	w27,	ne
    cmp	w21,	#0
    movz	w18,	#1
    ldr	w0,	[sp, #320]

    csel	w24,	w18,	w27,	ne
    cmp	w0,	#0
    cset	w28,	ne
    cmp	w28,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w23,	ne
    mov	w18,	w23
    cmp	w24,	#0
    cset	w20,	ne
    mov	w23,	w20
    cmp	w18,	#0
    movz	w28,	#1
    csel	w28,	w28,	w23,	ne
    cmp	w24,	#0
    cset	w21,	ne
    cmp	w18,	#0
    movz	w26,	#0
    csel	w25,	w21,	w26,	ne
    cmp	w25,	#0
    cset	w21,	eq
    cmp	w21,	#0
    cset	w20,	ne
    cmp	w28,	#0
    movz	w26,	#0
    csel	w20,	w20,	w26,	ne
    str	w20,	[sp, #540]

    ldr	w0,	[sp, #320]

    cmp	w0,	#0
    cset	w20,	ne
    mov	w23,	w20
    cmp	w24,	#0
    cset	w25,	ne
    cmp	w18,	#0
    movz	w22,	#0
    csel	w25,	w25,	w22,	ne
    cmp	w25,	#0
    cset	w20,	ne
    cmp	w23,	#0
    movz	w22,	#1
    csel	w27,	w22,	w20,	ne
    str	w27,	[sp, #1152]

    ldr	w24,	[sp, #220]

    cmp	w24,	#0
    cset	w22,	ne
    cmp	w22,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w22,	w28
    ldr	w28,	[sp, #1152]

    cmp	w28,	#0
    cset	w27,	ne
    mov	w20,	w27
    cmp	w22,	#0
    movz	w18,	#1
    ldr	w25,	[sp, #1152]

    csel	w18,	w18,	w20,	ne
    cmp	w25,	#0
    cset	w20,	ne
    mov	w27,	w20
    cmp	w22,	#0
    movz	w23,	#0
    csel	w20,	w27,	w23,	ne
    cmp	w20,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w23,	ne
    cmp	w18,	#0
    movz	w24,	#0
    csel	w23,	w23,	w24,	ne
    str	w23,	[sp, #532]

    ldr	w28,	[sp, #220]

    cmp	w28,	#0
    ldr	w25,	[sp, #1152]

    cset	w27,	ne
    cmp	w25,	#0
    cset	w18,	ne
    cmp	w22,	#0
    movz	w23,	#0
    csel	w18,	w18,	w23,	ne
    cmp	w18,	#0
    cset	w22,	ne
    cmp	w27,	#0
    movz	w21,	#1
    csel	w24,	w21,	w22,	ne
    str	w24,	[sp, #544]

    ldr	w18,	[sp, #248]

    cmp	w18,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w27,	eq
    cmp	w27,	#0
    ldr	w23,	[sp, #544]

    cset	w28,	ne
    mov	w18,	w28
    cmp	w23,	#0
    cset	w25,	ne
    mov	w23,	w25
    cmp	w18,	#0
    ldr	w25,	[sp, #544]

    movz	w24,	#1
    csel	w26,	w24,	w23,	ne
    cmp	w25,	#0
    cset	w20,	ne
    cmp	w18,	#0
    movz	w22,	#0
    csel	w23,	w20,	w22,	ne
    cmp	w23,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w25,	ne
    cmp	w26,	#0
    movz	w21,	#0
    csel	w0,	w25,	w21,	ne
    str	w0,	[sp, #928]

    ldr	w26,	[sp, #248]

    cmp	w26,	#0
    cset	w25,	ne
    ldr	w27,	[sp, #544]

    mov	w20,	w25
    cmp	w27,	#0
    cset	w26,	ne
    cmp	w18,	#0
    movz	w23,	#0
    csel	w18,	w26,	w23,	ne
    cmp	w18,	#0
    cset	w27,	ne
    cmp	w20,	#0
    movz	w22,	#1
    ldr	w24,	[sp, #260]

    csel	w21,	w22,	w27,	ne
    cmp	w24,	#0
    cset	w22,	ne
    cmp	w22,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w22,	ne
    mov	w26,	w22
    str	w26,	[sp, #296]

    cmp	w21,	#0
    cset	w20,	ne
    ldr	w27,	[sp, #296]

    cmp	w27,	#0
    movz	w18,	#1
    csel	w23,	w18,	w20,	ne
    cmp	w21,	#0
    ldr	w0,	[sp, #296]

    cset	w27,	ne
    mov	w24,	w27
    cmp	w0,	#0
    movz	w18,	#0
    csel	w18,	w24,	w18,	ne
    cmp	w18,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w26,	ne
    cmp	w23,	#0
    movz	w27,	#0
    csel	w25,	w26,	w27,	ne
    str	w25,	[sp, #840]

    ldr	w0,	[sp, #260]

    cmp	w0,	#0
    cset	w26,	ne
    mov	w22,	w26
    cmp	w21,	#0
    ldr	w27,	[sp, #296]

    cset	w23,	ne
    cmp	w27,	#0
    movz	w18,	#0
    csel	w23,	w23,	w18,	ne
    cmp	w23,	#0
    cset	w23,	ne
    cmp	w22,	#0
    ldr	w20,	[sp, #328]

    movz	w27,	#1
    csel	w23,	w27,	w23,	ne
    cmp	w20,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w18,	w28
    cmp	w23,	#0
    cset	w25,	ne
    str	w25,	[sp, #300]

    cmp	w18,	#0
    movz	w25,	#1
    ldr	w27,	[sp, #300]

    csel	w27,	w25,	w27,	ne
    cmp	w23,	#0
    cset	w23,	ne
    cmp	w18,	#0
    movz	w18,	#0
    csel	w26,	w23,	w18,	ne
    cmp	w26,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w26,	ne
    cmp	w27,	#0
    movz	w22,	#0
    ldr	w25,	[sp, #840]

    csel	w20,	w26,	w22,	ne
    ldr	w0,	[sp, #928]

    lsl	w26,	w20,	#1
    ldr	w23,	[sp, #532]

    ldr	w19,	[sp, #540]

    add	w20,	w26,	w25
    lsl	w22,	w20,	#1
    add	w26,	w22,	w0
    lsl	w27,	w26,	#1
    add	w28,	w27,	w23
    lsl	w20,	w28,	#1
    add	w28,	w20,	w19
    ldr	w19,	[sp, #960]

    ldr	w21,	[sp, #948]

    lsl	w20,	w28,	#1
    ldr	w0,	[sp, #944]

    add	w27,	w20,	w19
    lsl	w28,	w27,	#1
    add	w20,	w28,	w21
    lsl	w22,	w20,	#1
    add	w26,	w22,	w0
    lsl	w27,	w26,	#1
    ldr	w26,	[sp, #956]

    add	w23,	w27,	w26
    ldr	w0,	[sp, #952]

    lsl	w26,	w23,	#1
    add	w27,	w26,	w0
    lsl	w18,	w27,	#1
    ldr	w27,	[sp, #304]

    add	w27,	w18,	w27
    ldr	w25,	[sp, #208]

    lsl	w24,	w27,	#1
    add	w18,	w24,	w25
    lsl	w26,	w18,	#1
    ldr	w18,	[sp, #236]

    add	w22,	w26,	w18
    ldr	w25,	[sp, #256]

    ldr	w27,	[sp, #336]

    ldr	w21,	[sp, #344]

    lsl	w20,	w22,	#1
    add	w24,	w20,	w25
    lsl	w18,	w24,	#1
    add	w0,	w18,	w27
    lsl	w24,	w0,	#1
    add	w0,	w24,	w21
    bl	fib
    movz	w4,	#0
    ldr	w14,	[sp, #360]

    ldr	w15,	[sp, #360]

    asr	w12,	w14,	#31
    ldr	w16,	[sp, #360]

    lsr	w13,	w12,	#31
    add	w14,	w15,	w13
    asr	w5,	w14,	#1
    lsl	w6,	w5,	#1
    sub	w3,	w16,	w6
    sub	w24,	w4,	w3
    cmp	w3,	#0
    csel	w4,	w24,	w3,	lt
    movz	w20,	#0
    str	w4,	[sp, #1188]

    ldr	w17,	[sp, #360]

    ldr	w18,	[sp, #360]

    asr	w23,	w17,	#31
    lsr	w26,	w23,	#31
    add	w25,	w18,	w26
    asr	w10,	w25,	#1
    asr	w26,	w10,	#31
    lsr	w27,	w26,	#31
    add	w28,	w10,	w27
    asr	w21,	w28,	#1
    lsl	w22,	w21,	#1
    sub	w3,	w10,	w22
    sub	w6,	w20,	w3
    cmp	w3,	#0
    csel	w21,	w6,	w3,	lt
    asr	w5,	w10,	#31
    movz	w2,	#0
    str	w21,	[sp, #1048]

    lsr	w6,	w5,	#31
    add	w7,	w10,	w6
    asr	w23,	w7,	#1
    asr	w8,	w23,	#31
    lsr	w9,	w8,	#31
    add	w11,	w23,	w9
    asr	w3,	w11,	#1
    lsl	w4,	w3,	#1
    sub	w7,	w23,	w4
    sub	w12,	w2,	w7
    cmp	w7,	#0
    asr	w17,	w23,	#31
    csel	w15,	w12,	w7,	lt
    movz	w11,	#0
    str	w15,	[sp, #1044]

    lsr	w18,	w17,	#31
    add	w19,	w23,	w18
    asr	w1,	w19,	#1
    asr	w21,	w1,	#31
    lsr	w23,	w21,	#31
    add	w24,	w1,	w23
    asr	w12,	w24,	#1
    lsl	w13,	w12,	#1
    sub	w2,	w1,	w13
    sub	w12,	w11,	w2
    cmp	w2,	#0
    asr	w11,	w1,	#31
    csel	w8,	w12,	w2,	lt
    str	w8,	[sp, #1168]

    lsr	w12,	w11,	#31
    add	w13,	w1,	w12
    movz	w1,	#0
    asr	w9,	w13,	#1
    asr	w14,	w9,	#31
    lsr	w15,	w14,	#31
    add	w17,	w9,	w15
    asr	w2,	w17,	#1
    lsl	w2,	w2,	#1
    sub	w19,	w9,	w2
    sub	w18,	w1,	w19
    cmp	w19,	#0
    asr	w1,	w9,	#31
    movz	w8,	#0
    csel	w14,	w18,	w19,	lt
    lsr	w2,	w1,	#31
    str	w14,	[sp, #1172]

    add	w2,	w9,	w2
    asr	w19,	w2,	#1
    asr	w3,	w19,	#31
    lsr	w4,	w3,	#31
    add	w5,	w19,	w4
    asr	w11,	w5,	#1
    lsl	w12,	w11,	#1
    sub	w3,	w19,	w12
    sub	w12,	w8,	w3
    cmp	w3,	#0
    csel	w24,	w12,	w3,	lt
    movz	w23,	#0
    str	w24,	[sp, #1240]

    asr	w24,	w19,	#31
    lsr	w25,	w24,	#31
    add	w26,	w19,	w25
    asr	w8,	w26,	#1
    asr	w27,	w8,	#31
    lsr	w28,	w27,	#31
    add	w1,	w8,	w28
    asr	w24,	w1,	#1
    lsl	w25,	w24,	#1
    sub	w5,	w8,	w25
    sub	w3,	w23,	w5
    cmp	w5,	#0
    csel	w26,	w3,	w5,	lt
    asr	w14,	w8,	#31
    str	w26,	[sp, #1052]

    lsr	w15,	w14,	#31
    movz	w26,	#0
    add	w17,	w8,	w15
    asr	w4,	w17,	#1
    asr	w18,	w4,	#31
    lsr	w19,	w18,	#31
    add	w21,	w4,	w19
    asr	w27,	w21,	#1
    lsl	w28,	w27,	#1
    sub	w23,	w4,	w28
    sub	w14,	w26,	w23
    cmp	w23,	#0
    movz	w1,	#0
    asr	w5,	w4,	#31
    csel	w2,	w14,	w23,	lt
    lsr	w6,	w5,	#31
    str	w2,	[sp, #1164]

    add	w7,	w4,	w6
    asr	w11,	w7,	#1
    asr	w12,	w11,	#31
    lsr	w15,	w12,	#31
    add	w17,	w11,	w15
    asr	w2,	w17,	#1
    lsl	w2,	w2,	#1
    sub	w5,	w11,	w2
    sub	w18,	w1,	w5
    cmp	w5,	#0
    movz	w28,	#0
    asr	w2,	w11,	#31
    csel	w19,	w18,	w5,	lt
    lsr	w2,	w2,	#31
    str	w19,	[sp, #1176]

    add	w3,	w11,	w2
    asr	w7,	w3,	#1
    asr	w4,	w7,	#31
    lsr	w5,	w4,	#31
    add	w6,	w7,	w5
    asr	w1,	w6,	#1
    lsl	w2,	w1,	#1
    sub	w19,	w7,	w2
    sub	w5,	w28,	w19
    cmp	w19,	#0
    movz	w1,	#0
    asr	w3,	w7,	#31
    csel	w18,	w5,	w19,	lt
    lsr	w4,	w3,	#31
    str	w18,	[sp, #1236]

    add	w5,	w7,	w4
    asr	w21,	w5,	#1
    asr	w6,	w21,	#31
    lsr	w12,	w6,	#31
    add	w15,	w21,	w12
    asr	w2,	w15,	#1
    lsl	w2,	w2,	#1
    sub	w5,	w21,	w2
    sub	w26,	w1,	w5
    cmp	w5,	#0
    asr	w17,	w21,	#31
    csel	w1,	w26,	w5,	lt
    str	w1,	[sp, #1184]

    lsr	w18,	w17,	#31
    add	w19,	w21,	w18
    asr	w10,	w19,	#1
    asr	w23,	w10,	#31
    lsr	w25,	w23,	#31
    add	w26,	w10,	w25
    asr	w2,	w26,	#1
    lsl	w3,	w2,	#1
    movz	w2,	#0
    sub	w21,	w10,	w3
    sub	w2,	w2,	w21
    cmp	w21,	#0
    movz	w1,	#0
    csel	w27,	w2,	w21,	lt
    asr	w2,	w10,	#31
    str	w27,	[sp, #896]

    lsr	w2,	w2,	#31
    add	w4,	w10,	w2
    asr	w3,	w4,	#1
    asr	w5,	w3,	#31
    lsr	w6,	w5,	#31
    add	w12,	w3,	w6
    asr	w2,	w12,	#1
    lsl	w2,	w2,	#1
    sub	w26,	w3,	w2
    sub	w28,	w1,	w26
    cmp	w26,	#0
    csel	w4,	w28,	w26,	lt
    asr	w28,	w3,	#31
    str	w4,	[sp, #900]

    lsr	w1,	w28,	#31
    movz	w28,	#0
    add	w2,	w3,	w1
    asr	w25,	w2,	#1
    asr	w12,	w25,	#31
    lsr	w15,	w12,	#31
    add	w17,	w25,	w15
    asr	w18,	w17,	#1
    lsl	w19,	w18,	#1
    sub	w4,	w25,	w19
    sub	w5,	w28,	w4
    cmp	w4,	#0
    csel	w16,	w5,	w4,	lt
    asr	w1,	w25,	#31
    str	w16,	[sp, #888]

    lsr	w2,	w1,	#31
    add	w23,	w25,	w2
    asr	w8,	w23,	#1
    asr	w2,	w8,	#31
    lsr	w4,	w2,	#31
    add	w5,	w8,	w4
    asr	w19,	w5,	#1
    movz	w5,	#0
    lsl	w20,	w19,	#1
    sub	w3,	w8,	w20
    sub	w17,	w5,	w3
    cmp	w3,	#0
    asr	w5,	w8,	#31
    csel	w13,	w17,	w3,	lt
    movz	w2,	#0
    str	w13,	[sp, #884]

    lsr	w14,	w5,	#31
    add	w17,	w8,	w14
    asr	w21,	w17,	#1
    asr	w18,	w21,	#31
    lsr	w19,	w18,	#31
    add	w23,	w21,	w19
    asr	w5,	w23,	#1
    lsl	w6,	w5,	#1
    sub	w8,	w21,	w6
    sub	w25,	w2,	w8
    cmp	w8,	#0
    asr	w23,	w0,	#31
    csel	w9,	w25,	w8,	lt
    movz	w1,	#0
    str	w9,	[sp, #1192]

    lsr	w25,	w23,	#31
    add	w27,	w0,	w25
    asr	w2,	w27,	#1
    lsl	w6,	w2,	#1
    sub	w28,	w0,	w6
    sub	w2,	w1,	w28
    cmp	w28,	#0
    asr	w12,	w0,	#31
    csel	w22,	w2,	w28,	lt
    movz	w21,	#0
    str	w22,	[sp, #1180]

    lsr	w15,	w12,	#31
    add	w0,	w0,	w15
    asr	w10,	w0,	#1
    asr	w18,	w10,	#31
    lsr	w19,	w18,	#31
    add	w23,	w10,	w19
    asr	w19,	w23,	#1
    lsl	w23,	w19,	#1
    sub	w18,	w10,	w23
    sub	w0,	w21,	w18
    cmp	w18,	#0
    csel	w8,	w0,	w18,	lt
    str	w8,	[sp, #1040]

    asr	w0,	w10,	#31
    lsr	w15,	w0,	#31
    add	w26,	w10,	w15
    asr	w23,	w26,	#1
    asr	w14,	w23,	#31
    lsr	w15,	w14,	#31
    add	w16,	w23,	w15
    asr	w0,	w16,	#1
    lsl	w10,	w0,	#1
    movz	w0,	#0
    sub	w15,	w23,	w10
    sub	w28,	w0,	w15
    cmp	w15,	#0
    csel	w3,	w28,	w15,	lt
    movz	w17,	#0
    str	w3,	[sp, #1036]

    asr	w28,	w23,	#31
    lsr	w0,	w28,	#31
    add	w26,	w23,	w0
    asr	w4,	w26,	#1
    asr	w10,	w4,	#31
    lsr	w13,	w10,	#31
    add	w14,	w4,	w13
    asr	w0,	w14,	#1
    lsl	w10,	w0,	#1
    sub	w18,	w4,	w10
    sub	w14,	w17,	w18
    cmp	w18,	#0
    asr	w17,	w4,	#31
    csel	w2,	w14,	w18,	lt
    str	w2,	[sp, #904]

    lsr	w21,	w17,	#31
    movz	w17,	#0
    add	w25,	w4,	w21
    asr	w6,	w25,	#1
    asr	w26,	w6,	#31
    lsr	w0,	w26,	#31
    add	w10,	w6,	w0
    asr	w0,	w10,	#1
    lsl	w10,	w0,	#1
    sub	w0,	w6,	w10
    sub	w17,	w17,	w0
    cmp	w0,	#0
    csel	w14,	w17,	w0,	lt
    asr	w23,	w6,	#31
    lsr	w27,	w23,	#31
    add	w23,	w6,	w27
    asr	w7,	w23,	#1
    asr	w0,	w7,	#31
    lsr	w11,	w0,	#31
    add	w19,	w7,	w11
    asr	w24,	w19,	#1
    movz	w19,	#0
    lsl	w28,	w24,	#1
    sub	w23,	w7,	w28
    sub	w0,	w19,	w23
    cmp	w23,	#0
    csel	w23,	w0,	w23,	lt
    asr	w28,	w7,	#31
    str	w23,	[sp, #1028]

    lsr	w0,	w28,	#31
    add	w28,	w7,	w0
    movz	w0,	#0
    asr	w22,	w28,	#1
    asr	w18,	w22,	#31
    lsr	w24,	w18,	#31
    add	w28,	w22,	w24
    asr	w10,	w28,	#1
    lsl	w18,	w10,	#1
    sub	w26,	w22,	w18
    sub	w0,	w0,	w26
    cmp	w26,	#0
    csel	w11,	w0,	w26,	lt
    asr	w18,	w22,	#31
    str	w11,	[sp, #908]

    lsr	w24,	w18,	#31
    add	w18,	w22,	w24
    asr	w21,	w18,	#1
    asr	w0,	w21,	#31
    lsr	w1,	w0,	#31
    add	w18,	w21,	w1
    movz	w1,	#0
    mov	w0,	w1
    asr	w18,	w18,	#1
    lsl	w24,	w18,	#1
    sub	w3,	w21,	w24
    sub	w0,	w0,	w3
    cmp	w3,	#0
    csel	w4,	w0,	w3,	lt
    asr	w18,	w21,	#31
    str	w4,	[sp, #1252]

    lsr	w25,	w18,	#31
    add	w27,	w21,	w25
    asr	w28,	w27,	#1
    asr	w0,	w28,	#31
    lsr	w18,	w0,	#31
    movz	w0,	#0
    add	w19,	w28,	w18
    asr	w18,	w19,	#1
    lsl	w19,	w18,	#1
    sub	w19,	w28,	w19
    sub	w23,	w0,	w19
    cmp	w19,	#0
    csel	w18,	w23,	w19,	lt
    str	w18,	[sp, #912]

    asr	w23,	w28,	#31
    lsr	w0,	w23,	#31
    add	w18,	w28,	w0
    asr	w24,	w18,	#1
    asr	w0,	w24,	#31
    lsr	w0,	w0,	#31
    add	w18,	w24,	w0
    asr	w18,	w18,	#1
    lsl	w0,	w18,	#1
    sub	w20,	w24,	w0
    movz	w0,	#0
    sub	w0,	w0,	w20
    cmp	w20,	#0
    csel	w28,	w0,	w20,	lt
    asr	w18,	w24,	#31
    str	w28,	[sp, #1032]

    lsr	w0,	w18,	#31
    add	w18,	w24,	w0
    asr	w19,	w18,	#1
    asr	w28,	w19,	#31
    lsr	w24,	w28,	#31
    add	w28,	w19,	w24
    asr	w24,	w28,	#1
    lsl	w28,	w24,	#1
    sub	w24,	w19,	w28
    movz	w28,	#0
    mov	w27,	w28
    sub	w28,	w27,	w24
    cmp	w24,	#0
    csel	w6,	w28,	w24,	lt
    str	w6,	[sp, #200]

    asr	w24,	w19,	#31
    lsr	w28,	w24,	#31
    add	w18,	w19,	w28
    asr	w0,	w18,	#1
    asr	w24,	w0,	#31
    lsr	w19,	w24,	#31
    add	w24,	w0,	w19
    asr	w19,	w24,	#1
    lsl	w24,	w19,	#1
    sub	w19,	w0,	w24
    movz	w24,	#0
    mov	w23,	w24
    sub	w24,	w23,	w19
    cmp	w19,	#0
    csel	w25,	w24,	w19,	lt
    str	w25,	[sp, #244]

    asr	w19,	w0,	#31
    lsr	w24,	w19,	#31
    add	w18,	w0,	w24
    asr	w25,	w18,	#1
    asr	w28,	w25,	#31
    lsr	w18,	w28,	#31
    add	w28,	w25,	w18
    asr	w18,	w28,	#1
    lsl	w28,	w18,	#1
    sub	w18,	w25,	w28
    movz	w28,	#0
    mov	w27,	w28
    sub	w28,	w27,	w18
    cmp	w18,	#0
    csel	w10,	w28,	w18,	lt
    movz	w27,	#0
    str	w10,	[sp, #232]

    asr	w18,	w25,	#31
    lsr	w28,	w18,	#31
    add	w18,	w25,	w28
    asr	w19,	w18,	#1
    asr	w28,	w19,	#31
    lsr	w24,	w28,	#31
    add	w28,	w19,	w24
    asr	w24,	w28,	#1
    lsl	w28,	w24,	#1
    sub	w24,	w19,	w28
    sub	w28,	w27,	w24
    cmp	w24,	#0
    csel	w5,	w28,	w24,	lt
    movz	w23,	#0
    str	w5,	[sp, #228]

    asr	w24,	w19,	#31
    lsr	w28,	w24,	#31
    add	w18,	w19,	w28
    asr	w0,	w18,	#1
    asr	w24,	w0,	#31
    lsr	w19,	w24,	#31
    add	w24,	w0,	w19
    asr	w19,	w24,	#1
    lsl	w24,	w19,	#1
    sub	w19,	w0,	w24
    sub	w24,	w23,	w19
    cmp	w19,	#0
    csel	w20,	w24,	w19,	lt
    movz	w27,	#0
    str	w20,	[sp, #212]

    asr	w19,	w0,	#31
    lsr	w24,	w19,	#31
    add	w18,	w0,	w24
    asr	w23,	w18,	#1
    asr	w0,	w23,	#31
    lsr	w18,	w0,	#31
    add	w0,	w23,	w18
    asr	w18,	w0,	#1
    lsl	w0,	w18,	#1
    sub	w18,	w23,	w0
    sub	w27,	w27,	w18
    cmp	w18,	#0
    csel	w18,	w27,	w18,	lt
    str	w18,	[sp, #892]

    ldr	w23,	[sp, #1180]

    cmp	w23,	#0
    cset	w18,	ne
    ldr	w5,	[sp, #1188]

    mov	w0,	w18
    cmp	w5,	#0
    movz	w19,	#1
    ldr	w26,	[sp, #1180]

    mov	w18,	w19
    csel	w19,	w18,	w0,	ne
    cmp	w26,	#0
    cset	w27,	ne
    str	w27,	[sp, #324]

    ldr	w5,	[sp, #1188]

    cmp	w5,	#0
    ldr	w0,	[sp, #324]

    movz	w27,	#0
    csel	w27,	w0,	w27,	ne
    cmp	w27,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w19,	#0
    movz	w18,	#0
    csel	w27,	w28,	w18,	ne
    cmp	w27,	#0
    cset	w27,	ne
    cmp	w27,	#0
    cset	w18,	ne
    ldr	w27,	[sp, #1180]

    mov	w16,	w18
    cmp	w27,	#0
    cset	w0,	ne
    ldr	w10,	[sp, #1188]

    mov	w2,	w0
    cmp	w10,	#0
    movz	w9,	#0
    mov	w8,	w9
    csel	w4,	w2,	w8,	ne
    cmp	w4,	#0
    cset	w8,	ne
    ldr	w10,	[sp, #1040]

    mov	w0,	w8
    cmp	w10,	#0
    ldr	w2,	[sp, #1048]

    cset	w5,	ne
    mov	w11,	w5
    cmp	w2,	#0
    ldr	w21,	[sp, #1040]

    movz	w5,	#1
    csel	w10,	w5,	w11,	ne
    cmp	w21,	#0
    cset	w9,	ne
    mov	w1,	w9
    str	w1,	[sp, #192]

    ldr	w4,	[sp, #1048]

    cmp	w4,	#0
    ldr	w3,	[sp, #192]

    movz	w9,	#0
    csel	w9,	w3,	w9,	ne
    cmp	w9,	#0
    cset	w9,	eq
    cmp	w9,	#0
    cset	w9,	ne
    mov	w11,	w9
    cmp	w10,	#0
    movz	w5,	#0
    csel	w11,	w11,	w5,	ne
    str	w11,	[sp, #276]

    cmp	w0,	#0
    ldr	w13,	[sp, #276]

    cset	w5,	ne
    cmp	w13,	#0
    movz	w11,	#1
    mov	w9,	w11
    csel	w8,	w9,	w5,	ne
    str	w8,	[sp, #272]

    cmp	w0,	#0
    cset	w5,	ne
    ldr	w15,	[sp, #276]

    mov	w11,	w5
    cmp	w15,	#0
    movz	w5,	#0
    csel	w9,	w11,	w5,	ne
    cmp	w9,	#0
    cset	w9,	eq
    cmp	w9,	#0
    cset	w9,	ne
    ldr	w8,	[sp, #272]

    mov	w11,	w9
    cmp	w8,	#0
    movz	w5,	#0
    csel	w21,	w11,	w5,	ne
    str	w21,	[sp, #1232]

    ldr	w12,	[sp, #1040]

    cmp	w12,	#0
    ldr	w1,	[sp, #1048]

    cset	w28,	ne
    mov	w2,	w28
    cmp	w1,	#0
    movz	w6,	#0
    mov	w5,	w6
    csel	w10,	w2,	w5,	ne
    cmp	w0,	#0
    cset	w4,	ne
    ldr	w18,	[sp, #276]

    mov	w5,	w4
    cmp	w18,	#0
    movz	w2,	#0
    mov	w0,	w2
    csel	w0,	w5,	w0,	ne
    cmp	w0,	#0
    cset	w27,	ne
    cmp	w10,	#0
    ldr	w4,	[sp, #1036]

    movz	w24,	#1
    csel	w11,	w24,	w27,	ne
    cmp	w4,	#0
    cset	w25,	ne
    mov	w3,	w25
    ldr	w25,	[sp, #1044]

    cmp	w25,	#0
    ldr	w10,	[sp, #1036]

    movz	w5,	#1
    mov	w4,	w5
    csel	w2,	w4,	w3,	ne
    cmp	w10,	#0
    cset	w4,	ne
    ldr	w18,	[sp, #1044]

    mov	w5,	w4
    cmp	w18,	#0
    movz	w3,	#0
    mov	w1,	w3
    csel	w4,	w5,	w1,	ne
    cmp	w4,	#0
    cset	w1,	eq
    cmp	w1,	#0
    cset	w1,	ne
    mov	w3,	w1
    cmp	w2,	#0
    movz	w26,	#0
    mov	w25,	w26
    csel	w13,	w3,	w25,	ne
    cmp	w11,	#0
    cset	w4,	ne
    mov	w27,	w4
    cmp	w13,	#0
    movz	w4,	#1
    csel	w6,	w4,	w27,	ne
    cmp	w11,	#0
    cset	w25,	ne
    mov	w3,	w25
    str	w3,	[sp, #196]

    cmp	w13,	#0
    ldr	w26,	[sp, #196]

    movz	w25,	#0
    csel	w27,	w26,	w25,	ne
    cmp	w27,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w6,	#0
    movz	w4,	#0
    csel	w17,	w26,	w4,	ne
    str	w17,	[sp, #1244]

    ldr	w15,	[sp, #1036]

    cmp	w15,	#0
    ldr	w19,	[sp, #1044]

    cset	w20,	ne
    cmp	w19,	#0
    movz	w25,	#0
    mov	w23,	w25
    csel	w28,	w20,	w23,	ne
    cmp	w11,	#0
    cset	w19,	ne
    mov	w20,	w19
    cmp	w13,	#0
    movz	w2,	#0
    mov	w0,	w2
    csel	w19,	w20,	w0,	ne
    cmp	w19,	#0
    cset	w0,	ne
    cmp	w28,	#0
    ldr	w17,	[sp, #904]

    movz	w20,	#1
    csel	w23,	w20,	w0,	ne
    cmp	w17,	#0
    ldr	w17,	[sp, #1168]

    cset	w22,	ne
    mov	w21,	w22
    cmp	w17,	#0
    movz	w4,	#1
    ldr	w3,	[sp, #904]

    csel	w1,	w4,	w21,	ne
    cmp	w3,	#0
    cset	w4,	ne
    ldr	w8,	[sp, #1168]

    mov	w20,	w4
    cmp	w8,	#0
    movz	w2,	#0
    mov	w0,	w2
    csel	w5,	w20,	w0,	ne
    cmp	w5,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w19,	ne
    cmp	w1,	#0
    movz	w24,	#0
    mov	w22,	w24
    csel	w8,	w19,	w22,	ne
    cmp	w23,	#0
    cset	w19,	ne
    mov	w24,	w19
    cmp	w8,	#0
    movz	w4,	#1
    csel	w1,	w4,	w24,	ne
    cmp	w23,	#0
    cset	w4,	ne
    mov	w21,	w4
    cmp	w8,	#0
    movz	w4,	#0
    csel	w24,	w21,	w4,	ne
    cmp	w24,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w19,	ne
    cmp	w1,	#0
    movz	w24,	#0
    mov	w22,	w24
    csel	w21,	w19,	w22,	ne
    str	w21,	[sp, #1248]

    ldr	w3,	[sp, #904]

    cmp	w3,	#0
    ldr	w10,	[sp, #1168]

    cset	w13,	ne
    mov	w18,	w13
    cmp	w10,	#0
    movz	w4,	#0
    csel	w11,	w18,	w4,	ne
    cmp	w23,	#0
    cset	w27,	ne
    mov	w28,	w27
    cmp	w8,	#0
    movz	w13,	#0
    csel	w4,	w28,	w13,	ne
    cmp	w4,	#0
    cset	w19,	ne
    cmp	w11,	#0
    movz	w7,	#1
    csel	w1,	w7,	w19,	ne
    cmp	w14,	#0
    ldr	w25,	[sp, #1172]

    cset	w4,	ne
    mov	w2,	w4
    cmp	w25,	#0
    movz	w5,	#1
    mov	w4,	w5
    csel	w9,	w4,	w2,	ne
    cmp	w14,	#0
    cset	w27,	ne
    ldr	w19,	[sp, #1172]

    mov	w28,	w27
    cmp	w19,	#0
    movz	w2,	#0
    mov	w0,	w2
    csel	w21,	w28,	w0,	ne
    cmp	w21,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w13,	ne
    mov	w15,	w13
    cmp	w9,	#0
    movz	w7,	#0
    csel	w22,	w15,	w7,	ne
    cmp	w1,	#0
    cset	w4,	ne
    mov	w9,	w4
    cmp	w22,	#0
    movz	w4,	#1
    csel	w24,	w4,	w9,	ne
    cmp	w1,	#0
    cset	w4,	ne
    mov	w8,	w4
    cmp	w22,	#0
    movz	w2,	#0
    mov	w0,	w2
    csel	w6,	w8,	w0,	ne
    cmp	w6,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w7,	ne
    cmp	w24,	#0
    movz	w18,	#0
    mov	w13,	w18
    csel	w28,	w7,	w13,	ne
    str	w28,	[sp, #1228]

    cmp	w14,	#0
    cset	w27,	ne
    mov	w0,	w27
    ldr	w27,	[sp, #1172]

    cmp	w27,	#0
    movz	w12,	#0
    mov	w11,	w12
    csel	w18,	w0,	w11,	ne
    cmp	w1,	#0
    cset	w15,	ne
    cmp	w22,	#0
    movz	w27,	#0
    csel	w27,	w15,	w27,	ne
    cmp	w27,	#0
    cset	w13,	ne
    cmp	w18,	#0
    ldr	w24,	[sp, #1028]

    movz	w11,	#1
    csel	w5,	w11,	w13,	ne
    cmp	w24,	#0
    ldr	w2,	[sp, #1240]

    cset	w25,	ne
    mov	w15,	w25
    cmp	w2,	#0
    ldr	w27,	[sp, #1028]

    movz	w4,	#1
    csel	w20,	w4,	w15,	ne
    cmp	w27,	#0
    ldr	w9,	[sp, #1240]

    cset	w27,	ne
    mov	w25,	w27
    cmp	w9,	#0
    movz	w0,	#0
    mov	w27,	w0
    csel	w15,	w25,	w27,	ne
    cmp	w15,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w13,	ne
    cmp	w20,	#0
    movz	w0,	#0
    csel	w8,	w13,	w0,	ne
    cmp	w5,	#0
    cset	w25,	ne
    mov	w13,	w25
    cmp	w8,	#0
    movz	w19,	#1
    mov	w15,	w19
    csel	w22,	w15,	w13,	ne
    cmp	w5,	#0
    cset	w4,	ne
    mov	w27,	w4
    cmp	w8,	#0
    movz	w13,	#0
    csel	w2,	w27,	w13,	ne
    cmp	w2,	#0
    cset	w13,	eq
    cmp	w13,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w22,	#0
    movz	w13,	#0
    csel	w13,	w27,	w13,	ne
    str	w13,	[sp, #1224]

    ldr	w28,	[sp, #1028]

    cmp	w28,	#0
    cset	w25,	ne
    ldr	w12,	[sp, #1240]

    mov	w26,	w25
    cmp	w12,	#0
    movz	w0,	#0
    csel	w3,	w26,	w0,	ne
    cmp	w5,	#0
    cset	w4,	ne
    cmp	w8,	#0
    movz	w0,	#0
    csel	w15,	w4,	w0,	ne
    cmp	w15,	#0
    cset	w0,	ne
    cmp	w3,	#0
    ldr	w14,	[sp, #908]

    movz	w27,	#1
    csel	w6,	w27,	w0,	ne
    cmp	w14,	#0
    ldr	w1,	[sp, #1052]

    cset	w13,	ne
    cmp	w1,	#0
    movz	w19,	#1
    ldr	w25,	[sp, #908]

    csel	w5,	w19,	w13,	ne
    cmp	w25,	#0
    cset	w0,	ne
    ldr	w10,	[sp, #1052]

    cmp	w10,	#0
    movz	w15,	#0
    mov	w13,	w15
    csel	w18,	w0,	w13,	ne
    cmp	w18,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w9,	ne
    cmp	w5,	#0
    movz	w13,	#0
    csel	w3,	w9,	w13,	ne
    cmp	w6,	#0
    cset	w25,	ne
    mov	w13,	w25
    cmp	w3,	#0
    movz	w0,	#1
    csel	w28,	w0,	w13,	ne
    cmp	w6,	#0
    cset	w25,	ne
    mov	w11,	w25
    cmp	w3,	#0
    movz	w19,	#0
    mov	w15,	w19
    csel	w14,	w11,	w15,	ne
    cmp	w14,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w0,	ne
    cmp	w28,	#0
    movz	w19,	#0
    mov	w18,	w19
    csel	w10,	w0,	w18,	ne
    str	w10,	[sp, #1220]

    ldr	w26,	[sp, #908]

    cmp	w26,	#0
    cset	w10,	ne
    ldr	w8,	[sp, #1052]

    cmp	w8,	#0
    movz	w15,	#0
    mov	w14,	w15
    csel	w0,	w10,	w14,	ne
    cmp	w6,	#0
    cset	w4,	ne
    cmp	w3,	#0
    movz	w13,	#0
    csel	w4,	w4,	w13,	ne
    cmp	w4,	#0
    cset	w9,	ne
    cmp	w0,	#0
    movz	w4,	#1
    ldr	w6,	[sp, #1252]

    csel	w1,	w4,	w9,	ne
    cmp	w6,	#0
    ldr	w4,	[sp, #1164]

    cset	w9,	ne
    cmp	w4,	#0
    movz	w0,	#1
    ldr	w14,	[sp, #1252]

    csel	w12,	w0,	w9,	ne
    cmp	w14,	#0
    cset	w13,	ne
    ldr	w10,	[sp, #1164]

    cmp	w10,	#0
    movz	w27,	#0
    mov	w25,	w27
    csel	w4,	w13,	w25,	ne
    cmp	w4,	#0
    cset	w9,	eq
    cmp	w9,	#0
    cset	w13,	ne
    cmp	w12,	#0
    movz	w0,	#0
    csel	w2,	w13,	w0,	ne
    cmp	w1,	#0
    cset	w10,	ne
    cmp	w2,	#0
    movz	w27,	#1
    mov	w26,	w27
    csel	w0,	w26,	w10,	ne
    cmp	w1,	#0
    cset	w4,	ne
    mov	w6,	w4
    cmp	w2,	#0
    movz	w13,	#0
    mov	w11,	w13
    csel	w14,	w6,	w11,	ne
    cmp	w14,	#0
    cset	w13,	eq
    cmp	w13,	#0
    cset	w6,	ne
    cmp	w0,	#0
    movz	w11,	#0
    mov	w10,	w11
    csel	w7,	w6,	w10,	ne
    str	w7,	[sp, #1216]

    ldr	w15,	[sp, #1252]

    cmp	w15,	#0
    ldr	w15,	[sp, #1164]

    cset	w10,	ne
    cmp	w15,	#0
    movz	w14,	#0
    csel	w21,	w10,	w14,	ne
    cmp	w1,	#0
    cset	w28,	ne
    cmp	w2,	#0
    movz	w6,	#0
    csel	w12,	w28,	w6,	ne
    cmp	w12,	#0
    cset	w25,	ne
    cmp	w21,	#0
    ldr	w21,	[sp, #912]

    movz	w6,	#1
    csel	w19,	w6,	w25,	ne
    cmp	w21,	#0
    ldr	w22,	[sp, #1176]

    cset	w28,	ne
    cmp	w22,	#0
    movz	w0,	#1
    ldr	w1,	[sp, #912]

    csel	w8,	w0,	w28,	ne
    cmp	w1,	#0
    ldr	w3,	[sp, #1176]

    cset	w12,	ne
    mov	w13,	w12
    cmp	w3,	#0
    movz	w1,	#0
    mov	w0,	w1
    csel	w17,	w13,	w0,	ne
    cmp	w17,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w9,	ne
    cmp	w8,	#0
    movz	w15,	#0
    csel	w27,	w9,	w15,	ne
    cmp	w19,	#0
    cset	w0,	ne
    cmp	w27,	#0
    movz	w14,	#1
    mov	w13,	w14
    csel	w2,	w13,	w0,	ne
    cmp	w19,	#0
    cset	w0,	ne
    mov	w1,	w0
    cmp	w27,	#0
    movz	w13,	#0
    mov	w12,	w13
    csel	w3,	w1,	w12,	ne
    cmp	w3,	#0
    cset	w9,	eq
    cmp	w9,	#0
    cset	w12,	ne
    cmp	w2,	#0
    movz	w9,	#0
    csel	w1,	w12,	w9,	ne
    str	w1,	[sp, #1212]

    ldr	w2,	[sp, #912]

    cmp	w2,	#0
    ldr	w0,	[sp, #1176]

    cset	w12,	ne
    cmp	w0,	#0
    movz	w5,	#0
    csel	w23,	w12,	w5,	ne
    cmp	w19,	#0
    cset	w25,	ne
    cmp	w27,	#0
    movz	w9,	#0
    csel	w12,	w25,	w9,	ne
    cmp	w12,	#0
    cset	w19,	ne
    cmp	w23,	#0
    movz	w5,	#1
    ldr	w0,	[sp, #1032]

    csel	w6,	w5,	w19,	ne
    cmp	w0,	#0
    ldr	w26,	[sp, #1236]

    cset	w5,	ne
    cmp	w26,	#0
    movz	w0,	#1
    csel	w14,	w0,	w5,	ne
    ldr	w0,	[sp, #1032]

    cmp	w0,	#0
    ldr	w3,	[sp, #1236]

    cset	w5,	ne
    cmp	w3,	#0
    movz	w1,	#0
    csel	w12,	w5,	w1,	ne
    cmp	w12,	#0
    cset	w15,	eq
    cmp	w15,	#0
    cset	w25,	ne
    cmp	w14,	#0
    movz	w19,	#0
    csel	w1,	w25,	w19,	ne
    cmp	w6,	#0
    cset	w15,	ne
    cmp	w1,	#0
    movz	w21,	#1
    csel	w9,	w21,	w15,	ne
    cmp	w6,	#0
    cset	w25,	ne
    cmp	w1,	#0
    movz	w0,	#0
    mov	w28,	w0
    csel	w15,	w25,	w28,	ne
    cmp	w15,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w28,	ne
    cmp	w9,	#0
    movz	w9,	#0
    csel	w2,	w28,	w9,	ne
    str	w2,	[sp, #1208]

    ldr	w3,	[sp, #1032]

    cmp	w3,	#0
    cset	w28,	ne
    ldr	w7,	[sp, #1236]

    cmp	w7,	#0
    movz	w11,	#0
    csel	w10,	w28,	w11,	ne
    cmp	w6,	#0
    cset	w0,	ne
    cmp	w1,	#0
    movz	w12,	#0
    csel	w9,	w0,	w12,	ne
    cmp	w9,	#0
    cset	w11,	ne
    cmp	w10,	#0
    movz	w21,	#1
    ldr	w7,	[sp, #200]

    csel	w18,	w21,	w11,	ne
    cmp	w7,	#0
    cset	w19,	ne
    ldr	w2,	[sp, #1184]

    cmp	w2,	#0
    movz	w5,	#1
    ldr	w8,	[sp, #200]

    csel	w20,	w5,	w19,	ne
    cmp	w8,	#0
    cset	w0,	ne
    ldr	w11,	[sp, #1184]

    cmp	w11,	#0
    movz	w2,	#0
    csel	w26,	w0,	w2,	ne
    cmp	w26,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w5,	ne
    cmp	w20,	#0
    movz	w1,	#0
    csel	w2,	w5,	w1,	ne
    cmp	w18,	#0
    cset	w12,	ne
    cmp	w2,	#0
    movz	w21,	#1
    csel	w6,	w21,	w12,	ne
    cmp	w18,	#0
    cset	w5,	ne
    cmp	w2,	#0
    movz	w13,	#0
    mov	w12,	w13
    csel	w14,	w5,	w12,	ne
    cmp	w14,	#0
    cset	w12,	eq
    cmp	w12,	#0
    cset	w19,	ne
    cmp	w6,	#0
    movz	w11,	#0
    csel	w27,	w19,	w11,	ne
    str	w27,	[sp, #1204]

    ldr	w9,	[sp, #200]

    cmp	w9,	#0
    cset	w28,	ne
    ldr	w12,	[sp, #1184]

    cmp	w12,	#0
    movz	w11,	#0
    csel	w20,	w28,	w11,	ne
    cmp	w18,	#0
    cset	w19,	ne
    cmp	w2,	#0
    movz	w13,	#0
    csel	w25,	w19,	w13,	ne
    cmp	w25,	#0
    cset	w0,	ne
    cmp	w20,	#0
    movz	w25,	#1
    csel	w2,	w25,	w0,	ne
    ldr	w25,	[sp, #244]

    cmp	w25,	#0
    cset	w0,	ne
    ldr	w6,	[sp, #896]

    cmp	w6,	#0
    ldr	w26,	[sp, #244]

    movz	w22,	#1
    csel	w4,	w22,	w0,	ne
    cmp	w26,	#0
    cset	w21,	ne
    ldr	w17,	[sp, #896]

    cmp	w17,	#0
    movz	w9,	#0
    csel	w21,	w21,	w9,	ne
    cmp	w21,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w9,	ne
    cmp	w4,	#0
    movz	w5,	#0
    csel	w14,	w9,	w5,	ne
    cmp	w2,	#0
    cset	w19,	ne
    cmp	w14,	#0
    movz	w0,	#1
    csel	w18,	w0,	w19,	ne
    cmp	w2,	#0
    cset	w0,	ne
    cmp	w14,	#0
    movz	w6,	#0
    csel	w24,	w0,	w6,	ne
    cmp	w24,	#0
    cset	w5,	eq
    cmp	w5,	#0
    cset	w10,	ne
    cmp	w18,	#0
    movz	w15,	#0
    csel	w24,	w10,	w15,	ne
    str	w24,	[sp, #1200]

    ldr	w27,	[sp, #244]

    cmp	w27,	#0
    cset	w0,	ne
    ldr	w21,	[sp, #896]

    cmp	w21,	#0
    movz	w11,	#0
    csel	w0,	w0,	w11,	ne
    cmp	w2,	#0
    cset	w9,	ne
    cmp	w14,	#0
    movz	w1,	#0
    csel	w11,	w9,	w1,	ne
    cmp	w11,	#0
    cset	w19,	ne
    cmp	w0,	#0
    movz	w0,	#1
    ldr	w11,	[sp, #232]

    csel	w20,	w0,	w19,	ne
    cmp	w11,	#0
    cset	w10,	ne
    ldr	w8,	[sp, #900]

    cmp	w8,	#0
    movz	w1,	#1
    ldr	w12,	[sp, #232]

    csel	w18,	w1,	w10,	ne
    cmp	w12,	#0
    cset	w21,	ne
    ldr	w26,	[sp, #900]

    cmp	w26,	#0
    movz	w9,	#0
    csel	w24,	w21,	w9,	ne
    cmp	w24,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w5,	ne
    cmp	w18,	#0
    movz	w11,	#0
    csel	w7,	w5,	w11,	ne
    cmp	w20,	#0
    cset	w9,	ne
    cmp	w7,	#0
    movz	w1,	#1
    csel	w4,	w1,	w9,	ne
    cmp	w20,	#0
    cset	w1,	ne
    cmp	w7,	#0
    movz	w19,	#0
    csel	w9,	w1,	w19,	ne
    cmp	w9,	#0
    cset	w11,	eq
    cmp	w11,	#0
    cset	w21,	ne
    cmp	w4,	#0
    movz	w11,	#0
    csel	w17,	w21,	w11,	ne
    str	w17,	[sp, #1196]

    ldr	w13,	[sp, #232]

    cmp	w13,	#0
    ldr	w26,	[sp, #900]

    cset	w1,	ne
    cmp	w26,	#0
    movz	w24,	#0
    csel	w3,	w1,	w24,	ne
    cmp	w20,	#0
    cset	w0,	ne
    cmp	w7,	#0
    movz	w11,	#0
    csel	w1,	w0,	w11,	ne
    cmp	w1,	#0
    cset	w10,	ne
    cmp	w3,	#0
    ldr	w6,	[sp, #228]

    movz	w9,	#1
    csel	w2,	w9,	w10,	ne
    cmp	w6,	#0
    ldr	w23,	[sp, #888]

    cset	w24,	ne
    cmp	w23,	#0
    ldr	w7,	[sp, #228]

    movz	w1,	#1
    csel	w3,	w1,	w24,	ne
    cmp	w7,	#0
    cset	w0,	ne
    ldr	w9,	[sp, #888]

    cmp	w9,	#0
    movz	w14,	#0
    csel	w28,	w0,	w14,	ne
    cmp	w28,	#0
    cset	w13,	eq
    cmp	w13,	#0
    cset	w9,	ne
    cmp	w3,	#0
    movz	w15,	#0
    csel	w7,	w9,	w15,	ne
    cmp	w2,	#0
    cset	w1,	ne
    cmp	w7,	#0
    movz	w9,	#1
    csel	w8,	w9,	w1,	ne
    cmp	w2,	#0
    cset	w10,	ne
    cmp	w7,	#0
    movz	w26,	#0
    csel	w25,	w10,	w26,	ne
    cmp	w25,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w9,	ne
    cmp	w8,	#0
    movz	w26,	#0
    csel	w5,	w9,	w26,	ne
    ldr	w9,	[sp, #228]

    cmp	w9,	#0
    ldr	w8,	[sp, #888]

    cset	w0,	ne
    cmp	w8,	#0
    movz	w1,	#0
    csel	w8,	w0,	w1,	ne
    cmp	w2,	#0
    cset	w25,	ne
    cmp	w7,	#0
    movz	w20,	#0
    csel	w26,	w25,	w20,	ne
    cmp	w26,	#0
    cset	w26,	ne
    cmp	w8,	#0
    ldr	w21,	[sp, #212]

    movz	w14,	#1
    csel	w13,	w14,	w26,	ne
    cmp	w21,	#0
    ldr	w3,	[sp, #884]

    cset	w0,	ne
    cmp	w3,	#0
    ldr	w22,	[sp, #212]

    movz	w14,	#1
    csel	w21,	w14,	w0,	ne
    cmp	w22,	#0
    ldr	w1,	[sp, #884]

    cset	w15,	ne
    cmp	w1,	#0
    movz	w11,	#0
    csel	w0,	w15,	w11,	ne
    cmp	w0,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w11,	ne
    cmp	w21,	#0
    movz	w22,	#0
    csel	w8,	w11,	w22,	ne
    cmp	w13,	#0
    cset	w23,	ne
    cmp	w8,	#0
    movz	w12,	#1
    csel	w1,	w12,	w23,	ne
    cmp	w13,	#0
    cset	w2,	ne
    cmp	w8,	#0
    movz	w25,	#0
    csel	w11,	w2,	w25,	ne
    cmp	w11,	#0
    cset	w14,	eq
    cmp	w14,	#0
    cset	w26,	ne
    cmp	w1,	#0
    movz	w22,	#0
    ldr	w23,	[sp, #212]

    csel	w11,	w26,	w22,	ne
    cmp	w23,	#0
    cset	w0,	ne
    ldr	w2,	[sp, #884]

    cmp	w2,	#0
    movz	w1,	#0
    csel	w12,	w0,	w1,	ne
    cmp	w13,	#0
    cset	w27,	ne
    cmp	w8,	#0
    movz	w25,	#0
    csel	w14,	w27,	w25,	ne
    cmp	w14,	#0
    cset	w0,	ne
    cmp	w12,	#0
    movz	w24,	#1
    ldr	w13,	[sp, #892]

    csel	w10,	w24,	w0,	ne
    cmp	w13,	#0
    cset	w14,	ne
    ldr	w20,	[sp, #1192]

    cmp	w20,	#0
    movz	w23,	#1
    ldr	w9,	[sp, #892]

    csel	w22,	w23,	w14,	ne
    cmp	w9,	#0
    cset	w21,	ne
    ldr	w13,	[sp, #1192]

    cmp	w13,	#0
    movz	w2,	#0
    csel	w27,	w21,	w2,	ne
    cmp	w27,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w28,	ne
    cmp	w22,	#0
    movz	w0,	#0
    csel	w24,	w28,	w0,	ne
    cmp	w10,	#0
    cset	w3,	ne
    cmp	w24,	#0
    movz	w28,	#1
    csel	w4,	w28,	w3,	ne
    cmp	w10,	#0
    cset	w1,	ne
    cmp	w24,	#0
    movz	w27,	#0
    csel	w24,	w1,	w27,	ne
    cmp	w24,	#0
    cset	w3,	eq
    cmp	w3,	#0
    cset	w12,	ne
    cmp	w4,	#0
    ldr	w15,	[sp, #1196]

    movz	w0,	#0
    csel	w20,	w12,	w0,	ne
    lsl	w22,	w20,	#1
    ldr	w20,	[sp, #1200]

    add	w12,	w22,	w11
    ldr	w23,	[sp, #1204]

    ldr	w24,	[sp, #1208]

    ldr	w0,	[sp, #1212]

    lsl	w14,	w12,	#1
    add	w11,	w14,	w5
    lsl	w13,	w11,	#1
    add	w10,	w13,	w15
    lsl	w11,	w10,	#1
    add	w2,	w11,	w20
    lsl	w3,	w2,	#1
    add	w25,	w3,	w23
    ldr	w3,	[sp, #1216]

    ldr	w4,	[sp, #1220]

    lsl	w26,	w25,	#1
    ldr	w7,	[sp, #1224]

    add	w13,	w26,	w24
    lsl	w15,	w13,	#1
    add	w0,	w15,	w0
    lsl	w0,	w0,	#1
    add	w9,	w0,	w3
    lsl	w10,	w9,	#1
    add	w12,	w10,	w4
    ldr	w10,	[sp, #1228]

    ldr	w2,	[sp, #1248]

    lsl	w13,	w12,	#1
    ldr	w1,	[sp, #1244]

    add	w15,	w13,	w7
    lsl	w19,	w15,	#1
    ldr	w15,	[sp, #1232]

    add	w10,	w19,	w10
    lsl	w11,	w10,	#1
    add	w12,	w11,	w2
    lsl	w13,	w12,	#1
    add	w11,	w13,	w1
    lsl	w12,	w11,	#1
    add	w5,	w12,	w15
    lsl	w6,	w5,	#1
    add	w0,	w6,	w16
    b	fib_1892

fib_1891:
    movz	w0,	#1

fib_1892:
    movz	w18,	#1
    movz	fp,	#500
    ldr	x16,	[sp, fp]

    movz	fp,	#492
    str	w18,	[x16]

    ldr	x2,	[sp, fp]

    movz	fp,	#508
    ldr	w1,	[sp, #516]

    str	w1,	[x2]

    ldr	x12,	[sp, fp]

    add	x12,	x12,	#4
    str	w0,	[x12]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #1264
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


