.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global x
.align	2
x:
    .zero	4000000


.text

.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w26,	w0
    movz	w0,	#13
    bl	_sysy_starttime
    movz	w11,	#0
    cmp	w11,	w28
    bge	main_27

main_4:
    movz	w3,	#0

main_6:
    movz	w2,	#40000
    adrp	x21, :got:x
    movz	w7,	#0
    ldr	x21, [x21, #:got_lo12:x]
    madd	x2,	x3,	x2,	x21


main_10:
    movz	w12,	#400
    movz	w14,	#0
    madd	x16,	x7,	x12,	x2


main_13:
    cmp	w14,	w28
    bge	main_19

main_16:
    lsl	w4,	w14,	#2
    movz	w13,	#1
    add	w14,	w14,	#1
    add	x20,	x16,	x4
    str	w13,	[x20]

    b	main_13

main_19:
    add	w7,	w7,	#1
    cmp	w7,	w28
    blt	main_10

main_22:
    add	w3,	w3,	#1
    cmp	w3,	w28
    blt	main_6

main_27:
    sub	w3,	w28,	#1
    movz	w17,	#1
    cmp	w17,	w3
    blt	main_30

main_80:
    movz	w27,	#1
    movz	w24,	#1
    b	main_82

main_30:
    movz	w27,	#1

main_32:
    movz	w9,	#40000
    adrp	x15, :got:x
    sub	x16,	x27,	#1
    movz	w8,	#40000
    adrp	x11, :got:x
    movz	w7,	#40000
    adrp	x22, :got:x
    movz	w24,	#1
    ldr	x15, [x15, #:got_lo12:x]
    ldr	x11, [x11, #:got_lo12:x]
    madd	x6,	x27,	x9,	x15

    ldr	x22, [x22, #:got_lo12:x]
    madd	x25,	x16,	x8,	x11

    add	x27,	x27,	#1
    madd	x4,	x27,	x7,	x22


main_40:
    movz	w14,	#400
    movz	w20,	#400
    movz	w19,	#400
    sub	x8,	x24,	#1
    movz	w18,	#400
    add	x23,	x24,	#1
    movz	w17,	#400
    madd	x10,	x24,	x14,	x6

    madd	x13,	x24,	x20,	x25

    madd	x16,	x24,	x19,	x4

    madd	x21,	x8,	x18,	x6

    madd	x0,	x23,	x17,	x6

    movz	w8,	#1

main_49:
    cmp	w8,	w3
    bge	main_75

main_52:
    lsl	w20,	w8,	#2
    lsl	w15,	w8,	#2
    lsl	w2,	w8,	#2
    lsl	w11,	w8,	#2
    add	w23,	w8,	#1
    add	x19,	x10,	x20
    add	x14,	x13,	x15
    add	x1,	x21,	x2
    lsl	w20,	w8,	#2
    sub	w15,	w8,	#1
    add	w8,	w8,	#1
    ldr	w9,	[x14]

    add	x18,	x16,	x20
    ldr	w22,	[x18]

    lsl	w18,	w15,	#2
    ldr	w5,	[x1]

    add	w20,	w22,	w9
    add	x17,	x10,	x18
    add	x9,	x0,	x11
    add	w2,	w20,	w5
    ldr	w12,	[x9]

    ldr	w20,	[x17]

    add	w14,	w2,	w12
    lsl	w2,	w23,	#2
    add	w11,	w14,	w20
    add	x1,	x10,	x2
    ldr	w5,	[x1]

    add	w7,	w11,	w5
    sdiv	w9,	w7,	w26
    str	w9,	[x19]

    b	main_49

main_75:
    add	w24,	w24,	#1
    cmp	w24,	w3
    blt	main_40

main_78:
    cmp	w27,	w3
    blt	main_32

main_82:
    movz	w0,	#53
    bl	_sysy_stoptime
    mov	w0,	w28
    adrp	x1, :got:x
    ldr	x1, [x1, #:got_lo12:x]
    bl	putarray
    asr	w1,	w28,	#31
    adrp	x26, :got:x
    movz	w0,	#40000
    movz	w23,	#400
    lsr	w18,	w1,	#31
    ldr	x26, [x26, #:got_lo12:x]
    add	w19,	w28,	w18
    asr	w25,	w19,	#1
    madd	x22,	x25,	x0,	x26

    mov	w0,	w28
    madd	x1,	x25,	x23,	x22

    bl	putarray
    mov	w0,	w28
    movz	w1,	#400
    adrp	x20, :got:x
    movz	w18,	#40000
    sub	w23,	w24,	#1
    sub	w26,	w27,	#1
    ldr	x20, [x20, #:got_lo12:x]
    madd	x18,	x26,	x18,	x20

    madd	x1,	x23,	x1,	x18

    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


