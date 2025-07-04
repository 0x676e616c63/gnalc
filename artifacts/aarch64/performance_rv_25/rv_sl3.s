.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global x
.align	2
x:
.type x, %object
    .zero	4000000

.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w27,	w0
    movz	w0,	#13
    bl	_sysy_starttime
    movz	w11,	#0
    cmp	w11,	w28
    bge	main_27

main_4:
    movz	w7,	#0

main_6:
    movz	w2,	#40000
    adrp	x21, :got:x
    movz	w12,	#0
    ldr	x21, [x21, #:got_lo12:x]
    madd	x2,	x7,	x2,	x21


main_10:
    movz	w11,	#400
    movz	w5,	#0
    madd	x16,	x12,	x11,	x2


main_13:
    cmp	w5,	w28
    blt	main_16

main_19:
    add	w12,	w12,	#1
    cmp	w12,	w28
    blt	main_10

main_22:
    add	w7,	w7,	#1
    cmp	w7,	w28
    blt	main_6
    b	main_27

main_16:
    lsl	w9,	w5,	#2
    movz	w15,	#1
    add	w5,	w5,	#1
    add	x24,	x16,	x9
    str	w15,	[x24]

    b	main_13

main_27:
    sub	w3,	w28,	#1
    movz	w17,	#1
    cmp	w17,	w3
    bge	main_80

main_30:
    movz	w24,	#1

main_32:
    movz	w9,	#40000
    adrp	x15, :got:x
    sub	x16,	x24,	#1
    movz	w8,	#40000
    adrp	x11, :got:x
    movz	w7,	#40000
    adrp	x22, :got:x
    movz	w25,	#1
    ldr	x15, [x15, #:got_lo12:x]
    ldr	x11, [x11, #:got_lo12:x]
    madd	x6,	x24,	x9,	x15

    ldr	x22, [x22, #:got_lo12:x]
    madd	x26,	x16,	x8,	x11

    add	x24,	x24,	#1
    madd	x4,	x24,	x7,	x22


main_40:
    movz	w14,	#400
    movz	w13,	#400
    movz	w19,	#400
    sub	x8,	x25,	#1
    movz	w18,	#400
    add	x23,	x25,	#1
    movz	w17,	#400
    madd	x10,	x25,	x14,	x6

    madd	x13,	x25,	x13,	x26

    madd	x16,	x25,	x19,	x4

    madd	x21,	x8,	x18,	x6

    madd	x0,	x23,	x17,	x6

    movz	w8,	#1

main_49:
    cmp	w8,	w3
    blt	main_52

main_75:
    add	w25,	w25,	#1
    cmp	w25,	w3
    blt	main_40

main_78:
    cmp	w24,	w3
    blt	main_32
    b	main_82

main_52:
    lsl	w1,	w8,	#2
    lsl	w19,	w8,	#2
    lsl	w9,	w8,	#2
    lsl	w15,	w8,	#2
    add	w5,	w8,	#1
    add	x23,	x10,	x1
    add	x18,	x13,	x19
    add	x7,	x21,	x9
    add	x14,	x0,	x15
    lsl	w1,	w8,	#2
    sub	w19,	w8,	#1
    ldr	w17,	[x18]

    add	x22,	x16,	x1
    add	w8,	w8,	#1
    ldr	w2,	[x22]

    lsl	w22,	w19,	#2
    ldr	w11,	[x7]

    add	w1,	w2,	w17
    add	x20,	x10,	x22
    ldr	w17,	[x14]

    add	w9,	w1,	w11
    ldr	w1,	[x20]

    add	w2,	w9,	w17
    lsl	w9,	w5,	#2
    add	w17,	w2,	w1
    add	x7,	x10,	x9
    ldr	w11,	[x7]

    add	w12,	w17,	w11
    sdiv	w14,	w12,	w27
    str	w14,	[x23]

    b	main_49

main_80:
    movz	w24,	#1
    movz	w25,	#1

main_82:
    movz	w0,	#53
    bl	_sysy_stoptime
    mov	w0,	w28
    adrp	x1, :got:x
    ldr	x1, [x1, #:got_lo12:x]
    bl	putarray
    asr	w1,	w28,	#31
    movz	w20,	#40000
    adrp	x27, :got:x
    mov	w0,	w28
    movz	w23,	#400
    lsr	w18,	w1,	#31
    ldr	x27, [x27, #:got_lo12:x]
    add	w19,	w28,	w18
    asr	w26,	w19,	#1
    madd	x22,	x26,	x20,	x27

    madd	x1,	x26,	x23,	x22

    bl	putarray
    mov	w0,	w28
    movz	w1,	#400
    adrp	x20, :got:x
    movz	w18,	#40000
    sub	w23,	w25,	#1
    sub	w26,	w24,	#1
    ldr	x20, [x20, #:got_lo12:x]
    madd	x18,	x26,	x18,	x20

    madd	x1,	x23,	x1,	x18

    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


