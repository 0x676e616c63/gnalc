.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global y
.align	2
y:
    .zero	12000000

.global v
.align	2
v:
    .zero	12000000


.text

.globl main
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
    movz	w1,	#0
    mov	x2,	x22
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
    add	x26,	sp,	fp
    mov	x0,	x26
    bl	getarray
    movz	w0,	#39
    bl	_sysy_starttime
    movz	w6,	#0
    adrp	x21, :got:v
    adrp	x4, :got:y
    movz	fp,	#13664
    add	x25,	sp,	#16
    ldr	x4, [x4, #:got_lo12:y]
    movk	fp,	#12,	lsl #16
    ldr	x21, [x21, #:got_lo12:v]
    add	x7,	sp,	fp

main_18:
    movz	w27,	#0

main_20:
    cmp	w27,	w24
    bge	main_26

main_23:
    lsl	w10,	w27,	#2
    movz	w23,	#0
    add	w27,	w27,	#1
    add	x14,	x25,	x10
    str	w23,	[x14]

    b	main_20

main_26:
    movz	w28,	#0
    cmp	w28,	w24
    bge	main_69

main_28:
    movz	w9,	#0

main_30:
    lsl	w15,	w9,	#2
    add	w27,	w9,	#1
    add	x14,	x7,	x15
    lsl	w0,	w27,	#2
    ldr	w15,	[x14]

    add	x28,	x7,	x0
    mov	w2,	w15
    ldr	w18,	[x28]


main_37:
    cmp	w2,	w18
    bge	main_49

main_40:
    lsl	w27,	w2,	#2
    lsl	w8,	w2,	#2
    add	w2,	w2,	#1
    add	x5,	x21,	x8
    add	x23,	x4,	x27
    ldr	w28,	[x23]

    lsl	w1,	w28,	#2
    add	x22,	x25,	x1
    ldr	w17,	[x22]

    ldr	w10,	[x5]

    add	w11,	w10,	w17
    str	w11,	[x22]

    b	main_37

main_49:
    lsl	w11,	w9,	#2
    add	x10,	x26,	x11
    ldr	w12,	[x10]

    sub	w10,	w12,	#1

main_53:
    cmp	w15,	w18
    bge	main_66

main_56:
    lsl	w17,	w15,	#2
    lsl	w28,	w15,	#2
    add	w15,	w15,	#1
    add	x27,	x21,	x28
    add	x16,	x4,	x17
    ldr	w19,	[x16]

    lsl	w22,	w19,	#2
    add	x8,	x25,	x22
    ldr	w1,	[x8]

    ldr	w0,	[x27]

    madd	w2,	w10,	w0,	w1

    str	w2,	[x8]

    b	main_53

main_66:
    add	w9,	w9,	#1
    cmp	w9,	w24
    blt	main_30

main_70:
    movz	w15,	#0
    b	main_71

main_69:
    movz	w15,	#0

main_71:
    cmp	w15,	w24
    bge	main_77

main_74:
    lsl	w11,	w15,	#2
    movz	w18,	#0
    add	w15,	w15,	#1
    add	x19,	x26,	x11
    str	w18,	[x19]

    b	main_71

main_77:
    movz	w20,	#0
    cmp	w20,	w24
    bge	main_122

main_79:
    movz	w10,	#0

main_81:
    lsl	w16,	w10,	#2
    add	w1,	w10,	#1
    add	x15,	x7,	x16
    lsl	w3,	w1,	#2
    ldr	w16,	[x15]

    add	x2,	x7,	x3
    mov	w19,	w16
    ldr	w27,	[x2]


main_88:
    cmp	w19,	w27
    bge	main_100

main_91:
    lsl	w8,	w19,	#2
    lsl	w15,	w19,	#2
    add	w19,	w19,	#1
    add	x14,	x21,	x15
    add	x5,	x4,	x8
    ldr	w9,	[x5]

    lsl	w12,	w9,	#2
    add	x0,	x26,	x12
    ldr	w9,	[x0]

    ldr	w17,	[x14]

    add	w18,	w17,	w9
    str	w18,	[x0]

    b	main_88

main_100:
    lsl	w17,	w10,	#2
    add	x15,	x25,	x17
    ldr	w18,	[x15]

    sub	w0,	w18,	#1

main_104:
    cmp	w16,	w27
    bge	main_117

main_107:
    lsl	w23,	w16,	#2
    lsl	w5,	w16,	#2
    add	w16,	w16,	#1
    add	x3,	x21,	x5
    add	x22,	x4,	x23
    ldr	w28,	[x22]

    lsl	w1,	w28,	#2
    add	x9,	x26,	x1
    ldr	w19,	[x9]

    ldr	w8,	[x3]

    madd	w11,	w0,	w8,	w19

    str	w11,	[x9]

    b	main_104

main_117:
    add	w10,	w10,	#1
    cmp	w10,	w24
    blt	main_81

main_122:
    add	w6,	w6,	#1
    cmp	w6,	#100
    blt	main_18

main_125:
    movz	w0,	#47
    bl	_sysy_stoptime
    mov	x1,	x25
    mov	w0,	w24
    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#20496
    movk	fp,	#18,	lsl #16
    add	sp, sp, fp
    ret


