.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global x
.align	2
x:
.type x, %object
    .zero	32000000

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
    mov	w19,	w0
    movz	w0,	#13
    bl	_sysy_starttime
    movz	w20,	#28928
    movz	w0,	#0
    movk	w20,	#2,	lsl #16
    cmp	w0,	w28
    bge	main_27

main_4:
    movz	w11,	#0

main_6:
    adrp	x22, :got:x
    movz	w0,	#0
    ldr	x22, [x22, #:got_lo12:x]
    madd	x3,	x11,	x20,	x22


main_10:
    movz	w21,	#800
    movz	w9,	#0
    madd	x22,	x0,	x21,	x3


main_13:
    cmp	w9,	w28
    blt	main_16

main_19:
    add	w0,	w0,	#1
    cmp	w0,	w28
    blt	main_10

main_22:
    add	w11,	w11,	#1
    cmp	w11,	w28
    blt	main_6
    b	main_27

main_16:
    lsl	w26,	w9,	#2
    movz	w4,	#1
    add	w9,	w9,	#1
    add	x6,	x22,	x26
    str	w4,	[x6]

    b	main_13

main_27:
    sub	w8,	w28,	#1
    movz	w6,	#1
    cmp	w6,	w8
    bge	main_80

main_30:
    movz	w24,	#1

main_32:
    adrp	x14, :got:x
    sub	x15,	x24,	#1
    adrp	x9, :got:x
    adrp	x23, :got:x
    movz	w25,	#1
    ldr	x14, [x14, #:got_lo12:x]
    ldr	x9, [x9, #:got_lo12:x]
    madd	x10,	x24,	x20,	x14

    ldr	x23, [x23, #:got_lo12:x]
    madd	x27,	x15,	x20,	x9

    add	x24,	x24,	#1
    madd	x17,	x24,	x20,	x23


main_40:
    movz	w22,	#800
    movz	w3,	#800
    movz	w2,	#800
    sub	x18,	x25,	#1
    movz	w1,	#800
    add	x13,	x25,	#1
    movz	w0,	#800
    movz	w11,	#1
    madd	x23,	x25,	x22,	x10

    madd	x3,	x25,	x3,	x27

    madd	x5,	x25,	x2,	x17

    madd	x9,	x18,	x1,	x10

    madd	x14,	x13,	x0,	x10


main_49:
    cmp	w11,	w8
    blt	main_52

main_75:
    add	w25,	w25,	#1
    cmp	w25,	w8
    blt	main_40

main_78:
    cmp	w24,	w8
    blt	main_32
    b	main_82

main_52:
    lsl	w16,	w11,	#2
    lsl	w13,	w11,	#2
    lsl	w21,	w11,	#2
    lsl	w1,	w11,	#2
    add	x15,	x23,	x16
    add	x12,	x3,	x13
    add	x18,	x5,	x21
    add	x0,	x9,	x1
    ldr	w16,	[x12]

    ldr	w22,	[x18]

    ldr	w2,	[x0]

    add	w7,	w22,	w16
    add	w0,	w11,	#1
    sub	w16,	w11,	#1
    add	w18,	w7,	w2
    lsl	w21,	w16,	#2
    lsl	w2,	w0,	#2
    lsl	w7,	w11,	#2
    add	x1,	x23,	x2
    add	w11,	w11,	#1
    add	x6,	x14,	x7
    ldr	w12,	[x6]

    add	w12,	w18,	w12
    add	x18,	x23,	x21
    ldr	w22,	[x18]

    ldr	w4,	[x1]

    add	w12,	w12,	w22
    add	w6,	w12,	w4
    sdiv	w7,	w6,	w19
    str	w7,	[x15]

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
    asr	w21,	w28,	#31
    adrp	x27, :got:x
    movz	w0,	#800
    ldr	x27, [x27, #:got_lo12:x]
    lsr	w22,	w21,	#31
    add	w23,	w28,	w22
    asr	w26,	w23,	#1
    madd	x1,	x26,	x20,	x27

    madd	x1,	x26,	x0,	x1

    mov	w0,	w28
    bl	putarray
    mov	w0,	w28
    movz	w1,	#800
    adrp	x19, :got:x
    sub	w27,	w25,	#1
    sub	w24,	w24,	#1
    ldr	x19, [x19, #:got_lo12:x]
    madd	x18,	x24,	x20,	x19

    madd	x1,	x27,	x1,	x18

    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


