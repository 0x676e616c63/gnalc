.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global A
.align	2
A:
    .zero	7840000


.text

.globl main
main:
main_0:
    movz	fp,	#16816
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#5600
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    movz	w2,	#5600
    movz	w1,	#0
    movz	fp,	#5616
    add	x0,	sp,	fp
    bl	memset
    movz	w2,	#5600
    movz	w1,	#0
    movz	fp,	#11216
    add	x0,	sp,	fp
    bl	memset
    adrp	x0, :got:A
    ldr	x0, [x0, #:got_lo12:A]
    bl	getarray
    movz	fp,	#11216
    add	x0,	sp,	fp
    bl	getarray
    movz	fp,	#5616
    add	x21,	sp,	fp
    mov	x0,	x21
    bl	getarray
    add	x0,	sp,	#16
    bl	getarray
    movz	w0,	#68
    bl	_sysy_starttime
    add	x5,	sp,	#16
    movz	w26,	#0
    adrp	x10, :got:A
    movz	fp,	#11216
    ldr	x10, [x10, #:got_lo12:A]
    add	x8,	sp,	fp
    movz	fp,	#5616
    add	x25,	sp,	fp

main_17:
    movz	w15,	#0
    cmp	x15,	x26
    bge	main_49

main_20:
    movz	w16,	#5600
    movz	w0,	#0
    madd	x6,	x26,	x16,	x10


main_23:
    lsl	x15,	x0,	#2
    movz	w28,	#0
    add	x20,	x6,	x15
    ldr	w19,	[x20]


main_27:
    cmp	x28,	x0
    bge	main_40

main_31:
    lsl	x16,	x28,	#2
    movz	w7,	#5600
    lsl	x24,	x0,	#2
    add	x15,	x6,	x16
    madd	x3,	x28,	x7,	x10

    add	w28,	w28,	#1
    add	x23,	x3,	x24
    ldr	w9,	[x15]

    ldr	w27,	[x23]

    msub	w19,	w27,	w9,	w19

    b	main_27

main_40:
    movz	w12,	#5600
    lsl	x7,	x0,	#2
    madd	x4,	x0,	x12,	x10

    add	w0,	w0,	#1
    add	x4,	x4,	x7
    ldr	w9,	[x4]

    sdiv	w19,	w19,	w9
    str	w19,	[x20]

    cmp	w0,	w26
    blt	main_23

main_49:
    cmp	x26,	#1400
    bge	main_76

main_51:
    movz	w1,	#5600
    mov	w23,	w26
    madd	x19,	x26,	x1,	x10


main_54:
    lsl	w28,	w23,	#2
    movz	w13,	#0
    add	x24,	x19,	x28
    ldr	w4,	[x24]


main_58:
    cmp	x13,	x26
    bge	main_71

main_62:
    lsl	x7,	x13,	#2
    movz	w0,	#5600
    lsl	w15,	w23,	#2
    add	x6,	x19,	x7
    madd	x0,	x13,	x0,	x10

    add	w13,	w13,	#1
    add	x14,	x0,	x15
    ldr	w3,	[x6]

    ldr	w16,	[x14]

    msub	w4,	w16,	w3,	w4

    b	main_58

main_71:
    str	w4,	[x24]

    add	w23,	w23,	#1
    cmp	w23,	#1400
    blt	main_54

main_76:
    add	w26,	w26,	#1
    cmp	w26,	#1400
    blt	main_17

main_79:
    movz	w4,	#0

main_81:
    lsl	x13,	x4,	#2
    movz	w16,	#5600
    movz	w28,	#0
    add	x12,	x8,	x13
    madd	x22,	x4,	x16,	x10

    ldr	w13,	[x12]


main_86:
    cmp	w28,	w4
    bge	main_98

main_90:
    lsl	w26,	w28,	#2
    lsl	w1,	w28,	#2
    add	w28,	w28,	#1
    add	x0,	x5,	x1
    add	x24,	x22,	x26
    ldr	w12,	[x24]

    ldr	w2,	[x0]

    msub	w13,	w2,	w12,	w13

    b	main_86

main_98:
    lsl	x16,	x4,	#2
    add	w4,	w4,	#1
    add	x15,	x5,	x16
    str	w13,	[x15]

    cmp	w4,	#1400
    blt	main_81

main_102:
    movz	w16,	#1399

main_104:
    lsl	x13,	x16,	#2
    add	w2,	w16,	#1
    movz	w3,	#5600
    add	x12,	x5,	x13
    madd	x1,	x16,	x3,	x10

    ldr	w17,	[x12]


main_110:
    cmp	w2,	#1400
    bge	main_122

main_114:
    lsl	w0,	w2,	#2
    lsl	w4,	w2,	#2
    add	w2,	w2,	#1
    add	x3,	x25,	x4
    add	x28,	x1,	x0
    ldr	w7,	[x28]

    ldr	w6,	[x3]

    msub	w17,	w6,	w7,	w17

    b	main_110

main_122:
    lsl	x27,	x16,	#2
    lsl	x0,	x16,	#2
    sub	w16,	w16,	#1
    add	x28,	x1,	x0
    add	x14,	x25,	x27
    ldr	w1,	[x28]

    sdiv	w8,	w17,	w1
    str	w8,	[x14]

    cmp	w16,	#0
    bge	main_104

main_129:
    movz	w0,	#71
    bl	_sysy_stoptime
    mov	x1,	x21
    movz	w0,	#1400
    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#16816
    add	sp, sp, fp
    ret


