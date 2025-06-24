.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global array
.align	2
array:
    .zero	440


.text

.globl findfa
findfa:
findfa_1:
    sub	sp, sp, #48
    stp	x22, x24, [sp, #0]
    stp	x28, fp, [sp, #16]
    str	lr, [sp, 32]

    adrp	x3, :got:array
    lsl	w24,	w0,	#2
    ldr	x3, [x3, #:got_lo12:array]
    add	x22,	x3,	x24
    ldr	w4,	[x22]

    cmp	w4,	w0
    beq	findfa_15

findfa_5:
    lsl	w0,	w4,	#2
    adrp	x8, :got:array
    ldr	x8, [x8, #:got_lo12:array]
    add	x28,	x8,	x0
    ldr	w0,	[x28]

    cmp	w0,	w4
    beq	findfa_11

findfa_9:
    bl	findfa
    str	w0,	[x28]

    b	findfa_12

findfa_11:
    mov	w0,	w4

findfa_12:
    str	w0,	[x22]


findfa_15:
    ldp	x22, x24, [sp, #0]
    ldp	x28, fp, [sp, #16]
    ldr	lr, [sp, 32]

    add	sp, sp, #48
    ret


.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    movz	w25,	#1
    adrp	x17, :got:array
    adrp	x22, :got:array
    ldr	x22, [x22, #:got_lo12:array]
    ldr	x17, [x17, #:got_lo12:array]
    add	x19,	x17,	#68

main_3:
    movz	w23,	#65535
    movk	w23,	#65535,	lsl #16
    cmp	w25,	#16
    bge	main_25

main_6:
    lsl	w5,	w25,	#2
    adrp	x15, :got:array
    add	w16,	w25,	#1
    adrp	x6, :got:array
    ldr	x15, [x15, #:got_lo12:array]
    add	x13,	x15,	x5
    add	w21,	w16,	#1
    lsl	w20,	w16,	#2
    adrp	x15, :got:array
    str	w23,	[x13]

    add	w28,	w21,	#1
    lsl	w26,	w21,	#2
    ldr	x15, [x15, #:got_lo12:array]
    add	x13,	x15,	x20
    add	w5,	w28,	#1
    lsl	w2,	w28,	#2
    adrp	x20, :got:array
    str	w23,	[x13]

    add	w10,	w5,	#1
    lsl	w7,	w5,	#2
    ldr	x20, [x20, #:got_lo12:array]
    add	x17,	x20,	x26
    add	w14,	w10,	#1
    lsl	w11,	w10,	#2
    adrp	x26, :got:array
    adrp	x10, :got:array
    str	w23,	[x17]

    add	w18,	w14,	#1
    lsl	w15,	w14,	#2
    ldr	x26, [x26, #:got_lo12:array]
    adrp	x14, :got:array
    add	x24,	x26,	x2
    add	w25,	w18,	#1
    lsl	w20,	w18,	#2
    adrp	x2, :got:array
    str	w23,	[x24]

    ldr	x2, [x2, #:got_lo12:array]
    add	x28,	x2,	x7
    str	w23,	[x28]

    ldr	x6, [x6, #:got_lo12:array]
    add	x4,	x6,	x11
    str	w23,	[x4]

    ldr	x10, [x10, #:got_lo12:array]
    add	x8,	x10,	x15
    str	w23,	[x8]

    ldr	x14, [x14, #:got_lo12:array]
    add	x12,	x14,	x20
    str	w23,	[x12]

    b	main_3

main_25:
    lsl	w14,	w25,	#2
    adrp	x27, :got:array
    add	w25,	w25,	#1
    ldr	x27, [x27, #:got_lo12:array]
    add	x24,	x27,	x14
    str	w23,	[x24]

    cmp	w25,	#17
    ble	main_25

main_30:
    movz	w26,	#0
    movz	w21,	#0

main_32:
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w24,	w0
    cmp	w21,	#0
    bne	main_147

main_38:
    sub	w2,	w28,	#1
    adrp	x14, :got:array
    ldr	x14, [x14, #:got_lo12:array]
    lsl	w3,	w2,	#2
    add	w20,	w24,	w3
    lsl	w6,	w20,	#2
    add	x12,	x14,	x6
    str	w20,	[x12]

    cmp	w28,	#1
    bne	main_52

main_44:
    movz	w18,	#0
    mov	w0,	w20
    str	w18,	[x22]

    bl	findfa
    mov	w27,	w0
    movz	w0,	#0
    bl	findfa
    cmp	w27,	w0
    beq	main_52

main_48:
    lsl	w14,	w27,	#2
    adrp	x1, :got:array
    ldr	x1, [x1, #:got_lo12:array]
    add	x25,	x1,	x14
    str	w0,	[x25]


main_52:
    cmp	w28,	#4
    bne	main_62

main_54:
    movz	w0,	#17
    str	w0,	[x19]

    mov	w0,	w20
    bl	findfa
    mov	w25,	w0
    movz	w0,	#17
    bl	findfa
    cmp	w25,	w0
    beq	main_62

main_58:
    lsl	w1,	w25,	#2
    adrp	x8, :got:array
    ldr	x8, [x8, #:got_lo12:array]
    add	x6,	x8,	x1
    str	w0,	[x6]


main_62:
    cmp	w24,	#4
    bge	main_78

main_64:
    add	w27,	w20,	#1
    adrp	x7, :got:array
    ldr	x7, [x7, #:got_lo12:array]
    lsl	w11,	w27,	#2
    add	x5,	x7,	x11
    ldr	w8,	[x5]

    cmp	w8,	w23
    beq	main_78

main_69:
    mov	w0,	w20
    bl	findfa
    mov	w25,	w0
    mov	w0,	w27
    bl	findfa
    cmp	w25,	w0
    beq	main_78

main_73:
    lsl	w15,	w25,	#2
    adrp	x1, :got:array
    ldr	x1, [x1, #:got_lo12:array]
    add	x25,	x1,	x15
    str	w0,	[x25]


main_78:
    cmp	w24,	#1
    ble	main_94

main_80:
    sub	w24,	w20,	#1
    adrp	x6, :got:array
    ldr	x6, [x6, #:got_lo12:array]
    lsl	w27,	w24,	#2
    add	x4,	x6,	x27
    ldr	w7,	[x4]

    cmp	w7,	w23
    beq	main_94

main_85:
    mov	w0,	w20
    bl	findfa
    mov	w27,	w0
    mov	w0,	w24
    bl	findfa
    cmp	w27,	w0
    beq	main_94

main_89:
    lsl	w14,	w27,	#2
    adrp	x5, :got:array
    ldr	x5, [x5, #:got_lo12:array]
    add	x3,	x5,	x14
    str	w0,	[x3]


main_94:
    cmp	w28,	#4
    bge	main_110

main_96:
    add	w24,	w20,	#4
    adrp	x25, :got:array
    ldr	x25, [x25, #:got_lo12:array]
    lsl	w13,	w24,	#2
    add	x17,	x25,	x13
    ldr	w27,	[x17]

    cmp	w27,	w23
    beq	main_110

main_101:
    mov	w0,	w20
    bl	findfa
    mov	w25,	w0
    mov	w0,	w24
    bl	findfa
    cmp	w25,	w0
    beq	main_110

main_105:
    lsl	w6,	w25,	#2
    adrp	x18, :got:array
    ldr	x18, [x18, #:got_lo12:array]
    add	x16,	x18,	x6
    str	w0,	[x16]


main_110:
    cmp	w28,	#1
    ble	main_126

main_112:
    sub	w25,	w20,	#4
    adrp	x2, :got:array
    ldr	x2, [x2, #:got_lo12:array]
    lsl	w12,	w25,	#2
    add	x28,	x2,	x12
    ldr	w3,	[x28]

    cmp	w3,	w23
    beq	main_126

main_117:
    mov	w0,	w20
    bl	findfa
    mov	w28,	w0
    mov	w0,	w25
    bl	findfa
    cmp	w28,	w0
    beq	main_126

main_121:
    lsl	w11,	w28,	#2
    adrp	x28, :got:array
    ldr	x28, [x28, #:got_lo12:array]
    add	x25,	x28,	x11
    str	w0,	[x25]


main_126:
    ldr	w1,	[x22]

    cmp	w1,	w23
    beq	main_138

main_129:
    ldr	w3,	[x19]

    cmp	w3,	w23
    beq	main_140

main_132:
    movz	w0,	#0
    bl	findfa
    mov	w28,	w0
    movz	w0,	#17
    bl	findfa
    cmp	w28,	w0
    bne	main_142

main_136:
    add	w26,	w26,	#1
    mov	w0,	w26
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w21,	#1
    b	main_149

main_142:
    add	w26,	w26,	#1
    b	main_149

main_140:
    add	w26,	w26,	#1
    b	main_149

main_138:
    add	w26,	w26,	#1
    b	main_149

main_147:
    add	w26,	w26,	#1

main_149:
    cmp	w26,	#10
    blt	main_32

main_153:
    cmp	w21,	#0
    bne	main_157

main_155:
    mov	w0,	w23
    bl	putint
    movz	w0,	#10
    bl	putch

main_157:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


