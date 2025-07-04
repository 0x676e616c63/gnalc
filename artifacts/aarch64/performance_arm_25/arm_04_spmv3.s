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
    movz	w1,	#0
    mov	x2,	x22
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
    sub	w28,	w0,	#1
    adrp	x0, :got:y
    ldr	x0, [x0, #:got_lo12:y]
    bl	getarray
    adrp	x0, :got:v
    ldr	x0, [x0, #:got_lo12:v]
    bl	getarray
    movz	fp,	#6840
    movk	fp,	#6,	lsl #16
    add	x23,	sp,	fp
    mov	x0,	x23
    bl	getarray
    movz	w0,	#39
    bl	_sysy_starttime
    adrp	x4, :got:v
    adrp	x3, :got:y
    movz	w6,	#0
    movz	fp,	#13664
    add	x24,	sp,	#16
    ldr	x3, [x3, #:got_lo12:y]
    movk	fp,	#12,	lsl #16
    ldr	x4, [x4, #:got_lo12:v]
    add	x17,	sp,	fp

main_18:
    movz	w27,	#0

main_20:
    cmp	w27,	w28
    blt	main_23

main_26:
    movz	w25,	#0
    cmp	w25,	w28
    bge	main_69

main_28:
    movz	w5,	#0

main_30:
    lsl	w12,	w5,	#2
    add	w21,	w5,	#1
    add	x11,	x17,	x12
    lsl	w25,	w21,	#2
    ldr	w15,	[x11]

    add	x22,	x17,	x25
    mov	w10,	w15
    ldr	w14,	[x22]


main_37:
    cmp	w10,	w14
    blt	main_40

main_49:
    lsl	w19,	w5,	#2
    add	x18,	x23,	x19
    ldr	w20,	[x18]

    sub	w22,	w20,	#1

main_53:
    cmp	w15,	w14
    blt	main_56

main_66:
    add	w5,	w5,	#1
    cmp	w5,	w28
    blt	main_30

main_70:
    movz	w2,	#0
    b	main_71

main_56:
    lsl	w0,	w15,	#2
    lsl	w10,	w15,	#2
    add	w15,	w15,	#1
    add	x9,	x4,	x10
    add	x27,	x3,	x0
    ldr	w1,	[x27]

    lsl	w7,	w1,	#2
    add	x12,	x24,	x7
    ldr	w8,	[x12]

    ldr	w11,	[x9]

    madd	w13,	w22,	w11,	w8

    str	w13,	[x12]

    b	main_53

main_40:
    lsl	w22,	w10,	#2
    lsl	w2,	w10,	#2
    add	w10,	w10,	#1
    add	x1,	x4,	x2
    add	x21,	x3,	x22
    ldr	w25,	[x21]

    lsl	w27,	w25,	#2
    add	x27,	x24,	x27
    ldr	w20,	[x27]

    ldr	w7,	[x1]

    add	w8,	w7,	w20
    str	w8,	[x27]

    b	main_37

main_69:
    movz	w2,	#0

main_71:
    cmp	w2,	w28
    blt	main_74

main_77:
    movz	w16,	#0
    cmp	w16,	w28
    bge	main_122

main_79:
    movz	w5,	#0

main_81:
    lsl	w10,	w5,	#2
    add	w21,	w5,	#1
    add	x9,	x17,	x10
    lsl	w25,	w21,	#2
    ldr	w19,	[x9]

    add	x22,	x17,	x25
    mov	w14,	w19
    ldr	w16,	[x22]


main_88:
    cmp	w14,	w16
    blt	main_91

main_100:
    lsl	w21,	w5,	#2
    add	x20,	x24,	x21
    ldr	w22,	[x20]

    sub	w14,	w22,	#1

main_104:
    cmp	w19,	w16
    blt	main_107

main_117:
    add	w5,	w5,	#1
    cmp	w5,	w28
    blt	main_81
    b	main_122

main_107:
    lsl	w2,	w19,	#2
    lsl	w12,	w19,	#2
    add	w19,	w19,	#1
    add	x11,	x4,	x12
    add	x1,	x3,	x2
    ldr	w7,	[x1]

    lsl	w9,	w7,	#2
    add	x2,	x23,	x9
    ldr	w22,	[x2]

    ldr	w13,	[x11]

    madd	w15,	w14,	w13,	w22

    str	w15,	[x2]

    b	main_104

main_91:
    lsl	w0,	w14,	#2
    lsl	w10,	w14,	#2
    add	w14,	w14,	#1
    add	x9,	x4,	x10
    add	x27,	x3,	x0
    ldr	w1,	[x27]

    lsl	w7,	w1,	#2
    add	x0,	x23,	x7
    ldr	w8,	[x0]

    ldr	w11,	[x9]

    add	w12,	w11,	w8
    str	w12,	[x0]

    b	main_88

main_122:
    add	w6,	w6,	#1
    cmp	w6,	#100
    blt	main_18

main_125:
    movz	w0,	#47
    bl	_sysy_stoptime
    mov	x1,	x24
    mov	w0,	w28
    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#20496
    movk	fp,	#18,	lsl #16
    add	sp, sp, fp
    ret


main_74:
    lsl	w8,	w2,	#2
    movz	w7,	#0
    add	w2,	w2,	#1
    add	x18,	x23,	x8
    str	w7,	[x18]

    b	main_71

main_23:
    lsl	w10,	w27,	#2
    movz	w9,	#0
    add	w27,	w27,	#1
    add	x20,	x24,	x10
    str	w9,	[x20]

    b	main_20

