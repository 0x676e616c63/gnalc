.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global A
.align	2
A:
.type A, %object
    .zero	4194304

.global B
.align	2
B:
.type B, %object
    .zero	4194304

.global C
.align	2
C:
.type C, %object
    .zero	4194304

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
    movz	w17,	#0
    mov	w25,	w0
    cmp	w17,	w25
    bge	main_20

main_3:
    movz	w21,	#0

main_5:
    lsl	w23,	w21,	#12
    adrp	x10, :got:A
    movz	w20,	#0
    ldr	x10, [x10, #:got_lo12:A]
    add	x26,	x10,	x23

main_8:
    cmp	w20,	w25
    blt	main_11

main_15:
    add	w21,	w21,	#1
    cmp	w21,	w25
    blt	main_5
    b	main_20

main_11:
    lsl	w19,	w20,	#2
    add	x28,	x26,	x19
    bl	getfloat
    add	w20,	w20,	#1
    str	s0,	[x28]

    b	main_8

main_20:
    movz	w20,	#0
    cmp	w20,	w25
    bge	main_39

main_22:
    movz	w23,	#0

main_24:
    lsl	w6,	w23,	#12
    adrp	x21, :got:C
    movz	w22,	#0
    ldr	x21, [x21, #:got_lo12:C]
    add	x20,	x21,	x6

main_27:
    cmp	w22,	w25
    blt	main_30

main_34:
    add	w23,	w23,	#1
    cmp	w23,	w25
    blt	main_24
    b	main_39

main_30:
    lsl	w24,	w22,	#2
    add	x24,	x20,	x24
    bl	getfloat
    add	w22,	w22,	#1
    str	s0,	[x24]

    b	main_27

main_39:
    movz	w0,	#52
    bl	_sysy_starttime
    adrp	x16, :got:B
    movz	w1,	#0
    adrp	x27, :got:A
    ldr	x27, [x27, #:got_lo12:A]
    ldr	x16, [x16, #:got_lo12:B]

main_43:
    movz	w22,	#0
    cmp	w22,	w25
    bge	main_65

main_46:
    movz	w9,	#0

main_48:
    lsl	w24,	w9,	#12
    adrp	x7, :got:B
    lsl	w0,	w9,	#12
    adrp	x11, :got:C
    movz	w26,	#0
    ldr	x7, [x7, #:got_lo12:B]
    ldr	x11, [x11, #:got_lo12:C]
    add	x12,	x7,	x24
    add	x28,	x11,	x0

main_52:
    cmp	w26,	w25
    blt	main_55

main_60:
    add	w9,	w9,	#1
    cmp	w9,	w25
    blt	main_48
    b	main_65

main_55:
    lsl	w7,	w26,	#2
    lsl	w10,	w26,	#2
    add	w26,	w26,	#1
    add	x8,	x28,	x10
    add	x11,	x12,	x7
    ldr	s5,	[x8]

    str	s5,	[x11]

    b	main_52

main_65:
    movz	w28,	#0
    cmp	w28,	w25
    bge	main_104

main_67:
    movz	w12,	#0

main_69:
    movz	w17,	#0

main_72:
    lsl	w15,	w17,	#12
    lsl	w19,	w12,	#2
    lsl	w22,	w17,	#12
    lsl	w24,	w17,	#2
    add	w0,	w17,	#1
    add	x26,	x16,	x15
    add	x4,	x27,	x22
    add	x26,	x26,	x19
    add	x23,	x4,	x24
    ldr	s26,	[x26]

    ldr	s17,	[x23]

    fdiv	s18,	s26,	s17
    str	s18,	[x26]


main_82:
    cmp	w0,	w25
    blt	main_85

main_96:
    add	w17,	w17,	#1
    cmp	w17,	w25
    blt	main_72

main_99:
    add	w12,	w12,	#1
    cmp	w12,	w25
    blt	main_69
    b	main_104

main_85:
    lsl	w21,	w0,	#12
    lsl	w23,	w12,	#2
    lsl	w28,	w0,	#12
    lsl	w3,	w17,	#2
    add	x13,	x16,	x21
    add	w0,	w0,	#1
    add	x21,	x27,	x28
    add	x23,	x13,	x23
    add	x2,	x21,	x3
    ldr	s25,	[x23]

    ldr	s18,	[x2]

    ldr	s4,	[x26]

    fmul	s5,	s18,	s4
    fsub	s6,	s25,	s5
    str	s6,	[x23]

    b	main_82

main_104:
    add	w1,	w1,	#1
    cmp	w1,	#5
    blt	main_43

main_107:
    movz	w0,	#67
    bl	_sysy_stoptime
    movz	w15,	#0
    cmp	w15,	w25
    bge	main_127

main_109:
    movz	w7,	#0
    movi	v0.4s,	#0

main_111:
    lsl	w21,	w7,	#12
    adrp	x5, :got:B
    movz	w18,	#0
    ldr	x5, [x5, #:got_lo12:B]
    add	x6,	x5,	x21

main_115:
    cmp	w18,	w25
    blt	main_119

main_124:
    add	w7,	w7,	#1
    cmp	w7,	w25
    blt	main_111
    b	main_129

main_119:
    lsl	w28,	w18,	#2
    add	w18,	w18,	#1
    add	x27,	x6,	x28
    ldr	s19,	[x27]

    fadd	s0,	s0,	s19
    b	main_115

main_127:
    movi	v0.4s,	#0

main_129:
    bl	putfloat
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


