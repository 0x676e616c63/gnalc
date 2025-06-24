.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global A
.align	2
A:
    .zero	4194304

.global B
.align	2
B:
    .zero	4194304

.global C
.align	2
C:
    .zero	4194304


.text

.globl main
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
    movz	w19,	#0

main_5:
    lsl	w23,	w19,	#12
    adrp	x10, :got:A
    movz	w22,	#0
    ldr	x10, [x10, #:got_lo12:A]
    add	x24,	x10,	x23

main_8:
    cmp	w22,	w25
    bge	main_15

main_11:
    lsl	w28,	w22,	#2
    add	x26,	x24,	x28
    bl	getfloat
    add	w22,	w22,	#1
    str	s0,	[x26]

    b	main_8

main_15:
    add	w19,	w19,	#1
    cmp	w19,	w25
    blt	main_5

main_20:
    movz	w20,	#0
    cmp	w20,	w25
    bge	main_39

main_22:
    movz	w21,	#0

main_24:
    lsl	w6,	w21,	#12
    adrp	x22, :got:C
    movz	w24,	#0
    ldr	x22, [x22, #:got_lo12:C]
    add	x22,	x22,	x6

main_27:
    cmp	w24,	w25
    bge	main_34

main_30:
    lsl	w20,	w24,	#2
    add	x20,	x22,	x20
    bl	getfloat
    add	w24,	w24,	#1
    str	s0,	[x20]

    b	main_27

main_34:
    add	w21,	w21,	#1
    cmp	w21,	w25
    blt	main_24

main_39:
    movz	w0,	#52
    bl	_sysy_starttime
    movz	w1,	#0
    adrp	x16, :got:B
    adrp	x27, :got:A
    ldr	x27, [x27, #:got_lo12:A]
    ldr	x16, [x16, #:got_lo12:B]

main_43:
    movz	w22,	#0
    cmp	w22,	w25
    bge	main_65

main_46:
    movz	w24,	#0

main_48:
    lsl	w23,	w24,	#12
    adrp	x7, :got:B
    lsl	w0,	w24,	#12
    adrp	x10, :got:C
    ldr	x7, [x7, #:got_lo12:B]
    ldr	x10, [x10, #:got_lo12:C]
    add	x12,	x7,	x23
    add	x28,	x10,	x0
    movz	w10,	#0

main_52:
    cmp	w10,	w25
    bge	main_60

main_55:
    lsl	w5,	w10,	#2
    lsl	w7,	w10,	#2
    add	w10,	w10,	#1
    add	x6,	x28,	x7
    add	x8,	x12,	x5
    ldr	s3,	[x6]

    str	s3,	[x8]

    b	main_52

main_60:
    add	w24,	w24,	#1
    cmp	w24,	w25
    blt	main_48

main_65:
    movz	w28,	#0
    cmp	w28,	w25
    bge	main_104

main_67:
    movz	w11,	#0

main_69:
    movz	w14,	#0

main_72:
    lsl	w17,	w14,	#12
    lsl	w19,	w11,	#2
    lsl	w22,	w14,	#12
    lsl	w24,	w14,	#2
    add	w18,	w14,	#1
    add	x26,	x16,	x17
    add	x4,	x27,	x22
    add	x3,	x26,	x19
    add	x23,	x4,	x24
    ldr	s26,	[x3]

    ldr	s17,	[x23]

    fdiv	s18,	s26,	s17
    str	s18,	[x3]


main_82:
    cmp	w18,	w25
    bge	main_96

main_85:
    lsl	w15,	w18,	#12
    lsl	w19,	w11,	#2
    lsl	w22,	w18,	#12
    lsl	w24,	w14,	#2
    add	x7,	x16,	x15
    add	w18,	w18,	#1
    add	x13,	x27,	x22
    add	x15,	x7,	x19
    add	x23,	x13,	x24
    ldr	s20,	[x15]

    ldr	s13,	[x23]

    ldr	s31,	[x3]

    fmul	s1,	s13,	s31
    fsub	s2,	s20,	s1
    str	s2,	[x15]

    b	main_82

main_96:
    add	w14,	w14,	#1
    cmp	w14,	w25
    blt	main_72

main_99:
    add	w11,	w11,	#1
    cmp	w11,	w25
    blt	main_69

main_104:
    add	w1,	w1,	#1
    cmp	w1,	#5
    blt	main_43

main_107:
    movz	w0,	#67
    bl	_sysy_stoptime
    movz	w10,	#0
    cmp	w10,	w25
    blt	main_109

main_127:
    movi	v0.4s,	#0
    b	main_129

main_109:
    movz	w16,	#0
    movi	v0.4s,	#0

main_111:
    lsl	w21,	w16,	#12
    adrp	x5, :got:B
    movz	w9,	#0
    ldr	x5, [x5, #:got_lo12:B]
    add	x6,	x5,	x21

main_115:
    cmp	w9,	w25
    bge	main_124

main_119:
    lsl	w26,	w9,	#2
    add	w9,	w9,	#1
    add	x24,	x6,	x26
    ldr	s17,	[x24]

    fadd	s0,	s0,	s17
    b	main_115

main_124:
    add	w16,	w16,	#1
    cmp	w16,	w25
    blt	main_111

main_129:
    bl	putfloat
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


