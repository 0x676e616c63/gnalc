.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global x
.align	2
x:
    .zero	864000000


.text

.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w20,	w0
    movz	w0,	#13
    bl	_sysy_starttime
    movz	w19,	#63744
    movz	w0,	#0
    movk	w19,	#21,	lsl #16
    cmp	w0,	w28
    bge	main_27

main_4:
    movz	w6,	#0

main_6:
    adrp	x22, :got:x
    movz	w7,	#0
    ldr	x22, [x22, #:got_lo12:x]
    madd	x4,	x6,	x19,	x22


main_10:
    movz	w21,	#2400
    movz	w1,	#0
    madd	x15,	x7,	x21,	x4


main_13:
    cmp	w1,	w28
    bge	main_19

main_16:
    lsl	w22,	w1,	#2
    add	w1,	w1,	#1
    add	x0,	x15,	x22
    movz	w22,	#1
    str	w22,	[x0]

    b	main_13

main_19:
    add	w7,	w7,	#1
    cmp	w7,	w28
    blt	main_10

main_22:
    add	w6,	w6,	#1
    cmp	w6,	w28
    blt	main_6

main_27:
    sub	w9,	w28,	#1
    movz	w6,	#1
    cmp	w6,	w9
    blt	main_30

main_80:
    movz	w23,	#1
    movz	w24,	#1
    b	main_82

main_30:
    movz	w23,	#1

main_32:
    adrp	x14, :got:x
    sub	x15,	x23,	#1
    adrp	x8, :got:x
    adrp	x24, :got:x
    ldr	x14, [x14, #:got_lo12:x]
    ldr	x8, [x8, #:got_lo12:x]
    madd	x12,	x23,	x19,	x14

    ldr	x24, [x24, #:got_lo12:x]
    madd	x27,	x15,	x19,	x8

    add	x23,	x23,	#1
    madd	x18,	x23,	x19,	x24

    movz	w24,	#1

main_40:
    movz	w4,	#2400
    movz	w3,	#2400
    movz	w2,	#2400
    sub	x17,	x24,	#1
    movz	w1,	#2400
    add	x13,	x24,	#1
    movz	w0,	#2400
    movz	w11,	#1
    madd	x25,	x24,	x4,	x12

    madd	x3,	x24,	x3,	x27

    madd	x5,	x24,	x2,	x18

    madd	x8,	x17,	x1,	x12

    madd	x14,	x13,	x0,	x12


main_49:
    cmp	w11,	w9
    bge	main_75

main_52:
    lsl	w10,	w11,	#2
    lsl	w6,	w11,	#2
    lsl	w15,	w11,	#2
    lsl	w22,	w11,	#2
    lsl	w2,	w11,	#2
    add	x7,	x25,	x10
    add	x4,	x3,	x6
    add	x13,	x5,	x15
    add	x21,	x8,	x22
    add	x1,	x14,	x2
    ldr	w10,	[x4]

    ldr	w16,	[x13]

    ldr	w26,	[x21]

    add	w17,	w16,	w10
    add	w21,	w11,	#1
    ldr	w4,	[x1]

    sub	w10,	w11,	#1
    add	w13,	w17,	w26
    add	w11,	w11,	#1
    lsl	w26,	w21,	#2
    lsl	w15,	w10,	#2
    add	w4,	w13,	w4
    add	x22,	x25,	x26
    add	x13,	x25,	x15
    ldr	w16,	[x13]

    ldr	w0,	[x22]

    add	w17,	w4,	w16
    add	w1,	w17,	w0
    sdiv	w2,	w1,	w20
    str	w2,	[x7]

    b	main_49

main_75:
    add	w24,	w24,	#1
    cmp	w24,	w9
    blt	main_40

main_78:
    cmp	w23,	w9
    blt	main_32

main_82:
    movz	w0,	#53
    bl	_sysy_stoptime
    mov	w0,	w28
    adrp	x1, :got:x
    ldr	x1, [x1, #:got_lo12:x]
    bl	putarray
    asr	w21,	w28,	#31
    movz	w0,	#2400
    adrp	x27, :got:x
    lsr	w22,	w21,	#31
    ldr	x27, [x27, #:got_lo12:x]
    add	w25,	w28,	w22
    asr	w26,	w25,	#1
    madd	x1,	x26,	x19,	x27

    madd	x1,	x26,	x0,	x1

    mov	w0,	w28
    bl	putarray
    mov	w0,	w28
    movz	w1,	#2400
    adrp	x20, :got:x
    sub	w27,	w24,	#1
    sub	w25,	w23,	#1
    ldr	x20, [x20, #:got_lo12:x]
    madd	x18,	x25,	x19,	x20

    madd	x1,	x27,	x1,	x18

    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


