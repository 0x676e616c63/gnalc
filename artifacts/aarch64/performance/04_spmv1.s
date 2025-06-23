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
    add	x26,	sp,	fp
    mov	x0,	x26
    bl	getarray
    movz	w0,	#39
    bl	_sysy_starttime
    movz	w6,	#0
    movz	fp,	#13664
    adrp	x3, :got:v
    adrp	x14, :got:y
    add	x25,	sp,	#16
    movk	fp,	#12,	lsl #16
    ldr	x14, [x14, #:got_lo12:y]
    add	x11,	sp,	fp
    ldr	x3, [x3, #:got_lo12:v]

main_18:
    movz	w27,	#0

main_20:
    cmp	w27,	w24
    bge	main_26

main_23:
    lsl	w9,	w27,	#2
    movz	w23,	#0
    add	w27,	w27,	#1
    add	x15,	x25,	x9
    str	w23,	[x15]

    b	main_20

main_26:
    movz	w28,	#0
    cmp	w28,	w24
    bge	main_69

main_28:
    movz	w9,	#0

main_30:
    lsl	w16,	w9,	#2
    add	w27,	w9,	#1
    add	x15,	x11,	x16
    lsl	w0,	w27,	#2
    ldr	w15,	[x15]

    add	x28,	x11,	x0
    mov	w2,	w15
    ldr	w19,	[x28]


main_37:
    cmp	w2,	w19
    bge	main_49

main_40:
    lsl	w27,	w2,	#2
    lsl	w7,	w2,	#2
    add	w2,	w2,	#1
    add	x5,	x3,	x7
    add	x23,	x14,	x27
    ldr	w28,	[x23]

    lsl	w1,	w28,	#2
    add	x22,	x25,	x1
    ldr	w18,	[x22]

    ldr	w8,	[x5]

    add	w10,	w8,	w18
    str	w10,	[x22]

    b	main_37

main_49:
    lsl	w10,	w9,	#2
    add	x8,	x26,	x10
    ldr	w12,	[x8]

    sub	w8,	w12,	#1

main_53:
    cmp	w15,	w19
    bge	main_66

main_56:
    lsl	w18,	w15,	#2
    lsl	w28,	w15,	#2
    add	w15,	w15,	#1
    add	x27,	x3,	x28
    add	x17,	x14,	x18
    ldr	w20,	[x17]

    lsl	w22,	w20,	#2
    add	x7,	x25,	x22
    ldr	w1,	[x7]

    ldr	w0,	[x27]

    madd	w2,	w8,	w0,	w1

    str	w2,	[x7]

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
    lsl	w10,	w15,	#2
    movz	w18,	#0
    add	w15,	w15,	#1
    add	x20,	x26,	x10
    str	w18,	[x20]

    b	main_71

main_77:
    movz	w20,	#0
    cmp	w20,	w24
    bge	main_122

main_79:
    movz	w10,	#0

main_81:
    lsl	w17,	w10,	#2
    add	w1,	w10,	#1
    add	x16,	x11,	x17
    lsl	w4,	w1,	#2
    ldr	w16,	[x16]

    add	x2,	x11,	x4
    mov	w19,	w16
    ldr	w27,	[x2]


main_88:
    cmp	w19,	w27
    bge	main_100

main_91:
    lsl	w7,	w19,	#2
    lsl	w17,	w19,	#2
    add	w19,	w19,	#1
    add	x15,	x3,	x17
    add	x5,	x14,	x7
    ldr	w8,	[x5]

    lsl	w12,	w8,	#2
    add	x0,	x26,	x12
    ldr	w8,	[x0]

    ldr	w18,	[x15]

    add	w20,	w18,	w8
    str	w20,	[x0]

    b	main_88

main_100:
    lsl	w18,	w10,	#2
    add	x17,	x25,	x18
    ldr	w19,	[x17]

    sub	w0,	w19,	#1

main_104:
    cmp	w16,	w27
    bge	main_117

main_107:
    lsl	w23,	w16,	#2
    lsl	w5,	w16,	#2
    add	w16,	w16,	#1
    add	x4,	x3,	x5
    add	x22,	x14,	x23
    ldr	w28,	[x22]

    lsl	w1,	w28,	#2
    add	x8,	x26,	x1
    ldr	w20,	[x8]

    ldr	w7,	[x4]

    madd	w9,	w0,	w7,	w20

    str	w9,	[x8]

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


