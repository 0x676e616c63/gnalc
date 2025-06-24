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
    movz	w1,	#0
    movz	w2,	#5600
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
    movz	w26,	#0
    add	x1,	sp,	#16
    adrp	x0, :got:A
    movz	fp,	#11216
    ldr	x0, [x0, #:got_lo12:A]
    add	x7,	sp,	fp
    movz	fp,	#5616
    add	x10,	sp,	fp

main_17:
    movz	w16,	#0
    cmp	x16,	x26
    bge	main_49

main_20:
    movz	w17,	#5600
    movz	w2,	#0
    madd	x8,	x26,	x17,	x0


main_23:
    lsl	x16,	x2,	#2
    movz	w28,	#0
    add	x22,	x8,	x16
    ldr	w20,	[x22]


main_27:
    cmp	x28,	x2
    bge	main_40

main_31:
    lsl	x17,	x28,	#2
    movz	w9,	#5600
    lsl	x25,	x2,	#2
    add	x16,	x8,	x17
    madd	x5,	x28,	x9,	x0

    add	w28,	w28,	#1
    add	x24,	x5,	x25
    ldr	w11,	[x16]

    ldr	w27,	[x24]

    msub	w20,	w27,	w11,	w20

    b	main_27

main_40:
    movz	w13,	#5600
    lsl	x9,	x2,	#2
    madd	x6,	x2,	x13,	x0

    add	w2,	w2,	#1
    add	x6,	x6,	x9
    ldr	w11,	[x6]

    sdiv	w20,	w20,	w11
    str	w20,	[x22]

    cmp	w2,	w26
    blt	main_23

main_49:
    cmp	x26,	#1400
    bge	main_76

main_51:
    movz	w3,	#5600
    mov	w23,	w26
    madd	x20,	x26,	x3,	x0


main_54:
    lsl	w28,	w23,	#2
    movz	w14,	#0
    add	x25,	x20,	x28
    ldr	w6,	[x25]


main_58:
    cmp	x14,	x26
    bge	main_71

main_62:
    lsl	x9,	x14,	#2
    movz	w2,	#5600
    lsl	w16,	w23,	#2
    add	x8,	x20,	x9
    madd	x2,	x14,	x2,	x0

    add	w14,	w14,	#1
    add	x15,	x2,	x16
    ldr	w5,	[x8]

    ldr	w17,	[x15]

    msub	w6,	w17,	w5,	w6

    b	main_58

main_71:
    str	w6,	[x25]

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
    lsl	x14,	x4,	#2
    movz	w16,	#5600
    movz	w28,	#0
    add	x13,	x7,	x14
    madd	x23,	x4,	x16,	x0

    ldr	w13,	[x13]


main_86:
    cmp	w28,	w4
    bge	main_98

main_90:
    lsl	w26,	w28,	#2
    lsl	w3,	w28,	#2
    add	w28,	w28,	#1
    add	x2,	x1,	x3
    add	x25,	x23,	x26
    ldr	w14,	[x25]

    ldr	w5,	[x2]

    msub	w13,	w5,	w14,	w13

    b	main_86

main_98:
    lsl	x17,	x4,	#2
    add	w4,	w4,	#1
    add	x16,	x1,	x17
    str	w13,	[x16]

    cmp	w4,	#1400
    blt	main_81

main_102:
    movz	w16,	#1399

main_104:
    lsl	x14,	x16,	#2
    add	w2,	w16,	#1
    movz	w3,	#5600
    add	x13,	x1,	x14
    madd	x4,	x16,	x3,	x0

    ldr	w17,	[x13]


main_110:
    cmp	w2,	#1400
    bge	main_122

main_114:
    lsl	w3,	w2,	#2
    lsl	w6,	w2,	#2
    add	w2,	w2,	#1
    add	x5,	x10,	x6
    add	x28,	x4,	x3
    ldr	w8,	[x28]

    ldr	w7,	[x5]

    msub	w17,	w7,	w8,	w17

    b	main_110

main_122:
    lsl	x27,	x16,	#2
    lsl	x2,	x16,	#2
    sub	w16,	w16,	#1
    add	x28,	x4,	x2
    add	x15,	x10,	x27
    ldr	w3,	[x28]

    sdiv	w9,	w17,	w3
    str	w9,	[x15]

    cmp	w16,	#0
    bge	main_104

main_129:
    movz	w0,	#70
    bl	_sysy_stoptime
    mov	x1,	x21
    movz	w0,	#1400
    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#16816
    add	sp, sp, fp
    ret


