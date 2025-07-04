.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global y
.align	2
y:
.type y, %object
    .zero	12000000

.global v
.align	2
v:
.type v, %object
    .zero	12000000

.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    movz	fp,	#20496
    movk	fp,	#18,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w22,	#6824
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w22,	#6,	lsl #16
    mov	x2,	x22
    bl	memset
    mov	x2,	x22
    movz	w1,	#0
    movz	fp,	#6840
    movk	fp,	#6,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    mov	x2,	x22
    movz	w1,	#0
    movz	fp,	#13664
    movk	fp,	#12,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    movz	fp,	#13664
    movk	fp,	#12,	lsl #16
    add	x0,	sp,	fp
    bl	getarray
    sub	w24,	w0,	#1
    adrp	x0, :got:y
    ldr	x0, [x0, #:got_lo12:y]
    bl	getarray
    adrp	x0, :got:v
    ldr	x0, [x0, #:got_lo12:v]
    bl	getarray
    movz	fp,	#6840
    movk	fp,	#6,	lsl #16
    add	x25,	sp,	fp
    mov	x0,	x25
    bl	getarray
    movz	w0,	#39
    bl	_sysy_starttime
    adrp	x21, :got:v
    movz	w6,	#0
    adrp	x0, :got:y
    movz	fp,	#13664
    add	x19,	sp,	#16
    ldr	x0, [x0, #:got_lo12:y]
    movk	fp,	#12,	lsl #16
    ldr	x21, [x21, #:got_lo12:v]
    add	x12,	sp,	fp

main_18:
    movz	w27,	#0

main_20:
    cmp	w27,	w24
    blt	main_23

main_26:
    movz	w26,	#0
    cmp	w26,	w24
    bge	main_69

main_28:
    movz	w4,	#0

main_30:
    lsl	w11,	w4,	#2
    add	w22,	w4,	#1
    add	x10,	x12,	x11
    lsl	w26,	w22,	#2
    ldr	w15,	[x10]

    add	x23,	x12,	x26
    mov	w10,	w15
    ldr	w14,	[x23]


main_37:
    cmp	w10,	w14
    blt	main_40

main_49:
    lsl	w18,	w4,	#2
    add	x17,	x25,	x18
    ldr	w20,	[x17]

    sub	w23,	w20,	#1

main_53:
    cmp	w15,	w14
    blt	main_56

main_66:
    add	w4,	w4,	#1
    cmp	w4,	w24
    blt	main_30

main_70:
    movz	w2,	#0
    b	main_71

main_56:
    lsl	w1,	w15,	#2
    lsl	w9,	w15,	#2
    add	w15,	w15,	#1
    add	x8,	x21,	x9
    add	x28,	x0,	x1
    ldr	w2,	[x28]

    lsl	w5,	w2,	#2
    add	x11,	x19,	x5
    ldr	w7,	[x11]

    ldr	w10,	[x8]

    madd	w13,	w23,	w10,	w7

    str	w13,	[x11]

    b	main_53

main_40:
    lsl	w23,	w10,	#2
    lsl	w3,	w10,	#2
    add	w10,	w10,	#1
    add	x2,	x21,	x3
    add	x22,	x0,	x23
    ldr	w26,	[x22]

    lsl	w28,	w26,	#2
    add	x28,	x19,	x28
    ldr	w20,	[x28]

    ldr	w5,	[x2]

    add	w7,	w5,	w20
    str	w7,	[x28]

    b	main_37

main_69:
    movz	w2,	#0

main_71:
    cmp	w2,	w24
    blt	main_74

main_77:
    movz	w16,	#0
    cmp	w16,	w24
    bge	main_122

main_79:
    movz	w5,	#0

main_81:
    lsl	w9,	w5,	#2
    add	w22,	w5,	#1
    add	x8,	x12,	x9
    lsl	w26,	w22,	#2
    ldr	w20,	[x8]

    add	x23,	x12,	x26
    mov	w14,	w20
    ldr	w16,	[x23]


main_88:
    cmp	w14,	w16
    blt	main_91

main_100:
    lsl	w22,	w5,	#2
    add	x18,	x19,	x22
    ldr	w23,	[x18]

    sub	w14,	w23,	#1

main_104:
    cmp	w20,	w16
    blt	main_107

main_117:
    add	w5,	w5,	#1
    cmp	w5,	w24
    blt	main_81
    b	main_122

main_107:
    lsl	w3,	w20,	#2
    lsl	w11,	w20,	#2
    add	w20,	w20,	#1
    add	x10,	x21,	x11
    add	x2,	x0,	x3
    ldr	w4,	[x2]

    lsl	w8,	w4,	#2
    add	x3,	x25,	x8
    ldr	w23,	[x3]

    ldr	w13,	[x10]

    madd	w15,	w14,	w13,	w23

    str	w15,	[x3]

    b	main_104

main_91:
    lsl	w1,	w14,	#2
    lsl	w9,	w14,	#2
    add	w14,	w14,	#1
    add	x8,	x21,	x9
    add	x28,	x0,	x1
    ldr	w2,	[x28]

    lsl	w4,	w2,	#2
    add	x1,	x25,	x4
    ldr	w7,	[x1]

    ldr	w10,	[x8]

    add	w11,	w10,	w7
    str	w11,	[x1]

    b	main_88

main_122:
    add	w6,	w6,	#1
    cmp	w6,	#100
    blt	main_18

main_125:
    movz	w0,	#47
    bl	_sysy_stoptime
    mov	x1,	x19
    mov	w0,	w24
    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#20496
    movk	fp,	#18,	lsl #16
    add	sp, sp, fp
    ret


main_74:
    lsl	w7,	w2,	#2
    add	w2,	w2,	#1
    add	x17,	x25,	x7
    movz	w7,	#0
    str	w7,	[x17]

    b	main_71

main_23:
    lsl	w9,	w27,	#2
    add	w27,	w27,	#1
    add	x20,	x19,	x9
    movz	w9,	#0
    str	w9,	[x20]

    b	main_20

