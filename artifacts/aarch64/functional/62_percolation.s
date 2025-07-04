.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global array
.align	2
array:
.type array, %object
    .zero	440

.data

.text

.globl findfa
.align 2
.p2align 4,,11
.type findfa, %function
findfa:
findfa_1:
    sub	sp, sp, #48
    stp	x23, x24, [sp, #0]
    stp	x26, x28, [sp, #16]
    stp	fp, lr, [sp, #32]
    
    adrp	x3, :got:array
    lsl	w24,	w0,	#2
    ldr	x3, [x3, #:got_lo12:array]
    add	x23,	x3,	x24
    ldr	w26,	[x23]

    cmp	w26,	w0
    beq	findfa_15

findfa_5:
    lsl	w0,	w26,	#2
    adrp	x7, :got:array
    ldr	x7, [x7, #:got_lo12:array]
    add	x28,	x7,	x0
    ldr	w0,	[x28]

    cmp	w0,	w26
    beq	findfa_12

findfa_9:
    bl	findfa
    mov	w26,	w0
    str	w26,	[x28]


findfa_12:
    str	w26,	[x23]

    mov	w0,	w26

findfa_15:
    ldp	x23, x24, [sp, #0]
    ldp	x26, x28, [sp, #16]
    ldp	fp, lr, [sp, #32]
    
    add	sp, sp, #48
    ret


.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    movz	w25,	#1
    adrp	x17, :got:array
    adrp	x24, :got:array
    ldr	x24, [x24, #:got_lo12:array]
    ldr	x17, [x17, #:got_lo12:array]
    add	x21,	x17,	#68

main_3:
    movz	w19,	#65535
    movk	w19,	#65535,	lsl #16
    cmp	w25,	#16
    blt	main_6

main_25:
    lsl	w5,	w25,	#2
    adrp	x15, :got:array
    add	w25,	w25,	#1
    ldr	x15, [x15, #:got_lo12:array]
    add	x13,	x15,	x5
    str	w19,	[x13]

    cmp	w25,	#17
    ble	main_25

main_30:
    movz	w28,	#0
    movz	w25,	#0

main_32:
    bl	getint
    mov	w22,	w0
    bl	getint
    mov	w26,	w0
    cmp	w25,	#0
    beq	main_38

main_147:
    add	w28,	w28,	#1
    b	main_149

main_38:
    sub	w13,	w22,	#1
    adrp	x3, :got:array
    ldr	x3, [x3, #:got_lo12:array]
    lsl	w14,	w13,	#2
    add	w27,	w26,	w14
    lsl	w14,	w27,	#2
    add	x1,	x3,	x14
    str	w27,	[x1]

    cmp	w22,	#1
    bne	main_52

main_44:
    movz	w18,	#0
    mov	w0,	w27
    str	w18,	[x24]

    bl	findfa
    mov	w20,	w0
    movz	w0,	#0
    bl	findfa
    cmp	w20,	w0
    beq	main_52

main_48:
    lsl	w1,	w20,	#2
    adrp	x10, :got:array
    ldr	x10, [x10, #:got_lo12:array]
    add	x8,	x10,	x1
    str	w0,	[x8]


main_52:
    cmp	w22,	#4
    bne	main_62

main_54:
    movz	w0,	#17
    str	w0,	[x21]

    mov	w0,	w27
    bl	findfa
    mov	w23,	w0
    movz	w0,	#17
    bl	findfa
    cmp	w23,	w0
    beq	main_62

main_58:
    lsl	w8,	w23,	#2
    adrp	x17, :got:array
    ldr	x17, [x17, #:got_lo12:array]
    add	x15,	x17,	x8
    str	w0,	[x15]


main_62:
    cmp	w26,	#4
    bge	main_78

main_64:
    add	w23,	w27,	#1
    adrp	x14, :got:array
    ldr	x14, [x14, #:got_lo12:array]
    lsl	w16,	w23,	#2
    add	x12,	x14,	x16
    ldr	w15,	[x12]

    cmp	w15,	w19
    beq	main_78

main_69:
    mov	w0,	w27
    bl	findfa
    mov	w20,	w0
    mov	w0,	w23
    bl	findfa
    cmp	w20,	w0
    beq	main_78

main_73:
    lsl	w2,	w20,	#2
    adrp	x10, :got:array
    ldr	x10, [x10, #:got_lo12:array]
    add	x8,	x10,	x2
    str	w0,	[x8]


main_78:
    cmp	w26,	#1
    ble	main_94

main_80:
    sub	w26,	w27,	#1
    adrp	x15, :got:array
    ldr	x15, [x15, #:got_lo12:array]
    lsl	w7,	w26,	#2
    add	x13,	x15,	x7
    ldr	w16,	[x13]

    cmp	w16,	w19
    beq	main_94

main_85:
    mov	w0,	w27
    bl	findfa
    mov	w23,	w0
    mov	w0,	w26
    bl	findfa
    cmp	w23,	w0
    beq	main_94

main_89:
    lsl	w2,	w23,	#2
    adrp	x16, :got:array
    ldr	x16, [x16, #:got_lo12:array]
    add	x14,	x16,	x2
    str	w0,	[x14]


main_94:
    cmp	w22,	#4
    bge	main_110

main_96:
    add	w26,	w27,	#4
    adrp	x8, :got:array
    ldr	x8, [x8, #:got_lo12:array]
    lsl	w1,	w26,	#2
    add	x6,	x8,	x1
    ldr	w9,	[x6]

    cmp	w9,	w19
    beq	main_110

main_101:
    mov	w0,	w27
    bl	findfa
    mov	w23,	w0
    mov	w0,	w26
    bl	findfa
    cmp	w23,	w0
    beq	main_110

main_105:
    lsl	w16,	w23,	#2
    adrp	x8, :got:array
    ldr	x8, [x8, #:got_lo12:array]
    add	x6,	x8,	x16
    str	w0,	[x6]


main_110:
    cmp	w22,	#1
    ble	main_126

main_112:
    sub	w20,	w27,	#4
    adrp	x13, :got:array
    ldr	x13, [x13, #:got_lo12:array]
    lsl	w26,	w20,	#2
    add	x11,	x13,	x26
    ldr	w14,	[x11]

    cmp	w14,	w19
    beq	main_126

main_117:
    mov	w0,	w27
    bl	findfa
    mov	w26,	w0
    mov	w0,	w20
    bl	findfa
    cmp	w26,	w0
    beq	main_126

main_121:
    lsl	w2,	w26,	#2
    adrp	x15, :got:array
    ldr	x15, [x15, #:got_lo12:array]
    add	x13,	x15,	x2
    str	w0,	[x13]


main_126:
    ldr	w16,	[x24]

    cmp	w16,	w19
    bne	main_129

main_138:
    add	w28,	w28,	#1
    b	main_149

main_129:
    ldr	w20,	[x21]

    cmp	w20,	w19
    bne	main_132

main_140:
    add	w28,	w28,	#1
    b	main_149

main_132:
    movz	w0,	#0
    bl	findfa
    mov	w20,	w0
    movz	w0,	#17
    bl	findfa
    cmp	w20,	w0
    beq	main_136

main_142:
    add	w28,	w28,	#1
    b	main_149

main_136:
    add	w28,	w28,	#1
    mov	w0,	w28
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w25,	#1

main_149:
    cmp	w28,	#10
    blt	main_32

main_153:
    cmp	w25,	#0
    bne	main_157

main_155:
    mov	w0,	w19
    bl	putint
    movz	w0,	#10
    bl	putch

main_157:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_6:
    lsl	w7,	w25,	#2
    adrp	x13, :got:array
    add	w26,	w25,	#1
    adrp	x9, :got:array
    ldr	x13, [x13, #:got_lo12:array]
    add	x11,	x13,	x7
    add	w2,	w26,	#1
    lsl	w17,	w26,	#2
    adrp	x13, :got:array
    str	w19,	[x11]

    add	w6,	w2,	#1
    lsl	w23,	w2,	#2
    ldr	x9, [x9, #:got_lo12:array]
    add	x7,	x9,	x17
    lsl	w28,	w6,	#2
    adrp	x17, :got:array
    str	w19,	[x7]

    ldr	x13, [x13, #:got_lo12:array]
    add	x11,	x13,	x23
    adrp	x23, :got:array
    str	w19,	[x11]

    add	w11,	w6,	#1
    ldr	x17, [x17, #:got_lo12:array]
    add	x15,	x17,	x28
    adrp	x28, :got:array
    lsl	w4,	w11,	#2
    str	w19,	[x15]

    add	w15,	w11,	#1
    ldr	x23, [x23, #:got_lo12:array]
    add	x20,	x23,	x4
    adrp	x4, :got:array
    lsl	w8,	w15,	#2
    add	w23,	w15,	#1
    str	w19,	[x20]

    ldr	x28, [x28, #:got_lo12:array]
    lsl	w13,	w23,	#2
    add	x26,	x28,	x8
    adrp	x8, :got:array
    add	w28,	w23,	#1
    str	w19,	[x26]

    add	w25,	w28,	#1
    lsl	w17,	w28,	#2
    ldr	x4, [x4, #:got_lo12:array]
    add	x2,	x4,	x13
    str	w19,	[x2]

    ldr	x8, [x8, #:got_lo12:array]
    add	x6,	x8,	x17
    str	w19,	[x6]

    b	main_3

