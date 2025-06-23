.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global cnt
.align	2
cnt:
    .zero	1600080


.text

.globl main
main:
main_0:
    movz	fp,	#20432
    movk	fp,	#18,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w25,	#6804
    movz	w1,	#0
    movz	fp,	#6820
    movk	w25,	#6,	lsl #16
    movk	fp,	#6,	lsl #16
    mov	x2,	x25
    add	x0,	sp,	fp
    bl	memset
    mov	x2,	x25
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    mov	x2,	x25
    movz	w1,	#0
    movz	fp,	#13624
    movk	fp,	#12,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    bl	getch
    movz	w22,	#0
    mov	w28,	w0

main_5:
    cmp	w28,	#48
    blt	main_13

main_9:
    cmp	w28,	#57
    bgt	main_13

main_17:
    movz	w24,	#0

main_18:
    cmp	w28,	#48
    blt	main_31

main_22:
    cmp	w28,	#57
    bgt	main_31

main_24:
    lsl	w20,	w24,	#1
    add	w23,	w20,	w24,	lsl #3
    add	w21,	w28,	w23
    sub	w24,	w21,	#48
    bl	getch
    mov	w28,	w0
    b	main_18

main_31:
    movz	w16,	#0
    sub	w13,	w16,	w24
    cmp	w22,	#0
    movz	w15,	#0
    csel	w28,	w13,	w24,	ne
    cmp	w15,	w28
    beq	main_78

main_36:
    movz	w22,	#0

main_38:
    lsl	w23,	w22,	#2
    movz	fp,	#13624
    mov	x20,	x23
    movk	fp,	#12,	lsl #16
    add	x20,	sp,	x20
    add	x20,	x20,	fp
    bl	getch
    movz	w26,	#0
    mov	w5,	w0

main_42:
    cmp	w5,	#48
    blt	main_50

main_46:
    cmp	w5,	#57
    bgt	main_50

main_54:
    movz	w27,	#0

main_55:
    cmp	w5,	#48
    blt	main_68

main_59:
    cmp	w5,	#57
    bgt	main_68

main_61:
    lsl	w23,	w27,	#1
    add	w19,	w23,	w27,	lsl #3
    add	w21,	w5,	w19
    sub	w27,	w21,	#48
    bl	getch
    mov	w5,	w0
    b	main_55

main_68:
    movz	w6,	#0
    sub	w4,	w6,	w27
    cmp	w26,	#0
    movz	fp,	#6820
    lsl	w6,	w22,	#2
    csel	w12,	w4,	w27,	ne
    lsl	w8,	w22,	#2
    movk	fp,	#6,	lsl #16
    mov	x5,	x6
    str	w12,	[x20]

    add	w22,	w22,	#1
    mov	x7,	x8
    add	x5,	sp,	x5
    add	x7,	sp,	x7
    add	x5,	x5,	#16
    add	x7,	x7,	fp
    str	w12,	[x5]

    str	w12,	[x7]

    cmp	w22,	w28
    bne	main_38

main_78:
    movz	fp,	#13624
    movz	w22,	#0
    movk	fp,	#12,	lsl #16
    add	x3,	sp,	fp
    cmp	w22,	w28
    bge	main_107

main_81:
    movz	w0,	#0

main_83:
    add	w2,	w0,	#1
    cmp	w2,	w28
    bge	main_103

main_87:
    lsl	w1,	w0,	#2
    add	x4,	x3,	x1
    mov	w1,	w2

main_90:
    ldr	w22,	[x4]

    lsl	w20,	w1,	#2
    add	x25,	x3,	x20
    ldr	w21,	[x25]

    cmp	w22,	w21
    ble	main_98

main_96:
    str	w21,	[x4]

    str	w22,	[x25]


main_98:
    add	w1,	w1,	#1
    cmp	w1,	w28
    blt	main_90

main_103:
    cmp	w2,	w28
    bge	main_107

main_82:
    mov	w0,	w2
    b	main_83

main_107:
    add	x16,	sp,	#16
    movz	w8,	#0
    movz	w14,	#65436
    movk	w14,	#65535,	lsl #16

main_109:
    cmp	w8,	w28
    bge	main_122

main_113:
    lsl	w7,	w8,	#2
    adrp	x12, :got:cnt
    add	x6,	x16,	x7
    ldr	w26,	[x6]

    ldr	x12, [x12, #:got_lo12:cnt]
    lsl	w20,	w26,	#2
    add	x9,	x12,	x20
    ldr	w13,	[x9]

    add	w15,	w13,	#1
    str	w15,	[x9]

    cmp	w26,	w14
    add	w8,	w8,	#1
    csel	w14,	w26,	w14,	gt
    b	main_109

main_122:
    movz	w27,	#0
    cmp	w27,	w14
    bgt	main_144

main_124:
    movz	w10,	#0
    movz	w6,	#0

main_126:
    lsl	w23,	w10,	#2
    adrp	x2, :got:cnt
    ldr	x2, [x2, #:got_lo12:cnt]
    add	x0,	x2,	x23
    ldr	w21,	[x0]


main_131:
    cmp	w21,	#0
    beq	main_139

main_135:
    lsl	w0,	w6,	#2
    sub	w21,	w21,	#1
    add	w6,	w6,	#1
    add	x27,	x16,	x0
    str	w10,	[x27]

    b	main_131

main_139:
    add	w10,	w10,	#1
    cmp	w10,	w14
    ble	main_126

main_144:
    movz	fp,	#6820
    movz	w2,	#0
    movk	fp,	#6,	lsl #16
    add	x25,	sp,	fp
    cmp	w2,	w28
    bge	main_171

main_147:
    movz	w14,	#0

main_149:
    add	w24,	w14,	#1
    mov	w9,	w14

main_152:
    cmp	w24,	w28
    bge	main_164

main_156:
    lsl	w10,	w24,	#2
    lsl	w13,	w9,	#2
    add	x8,	x25,	x10
    add	x12,	x25,	x13
    ldr	w27,	[x8]

    ldr	w15,	[x12]

    cmp	w27,	w15
    csel	w9,	w24,	w9,	lt
    add	w24,	w24,	#1
    b	main_152

main_164:
    lsl	w12,	w14,	#2
    lsl	w26,	w9,	#2
    add	w14,	w14,	#1
    add	x6,	x25,	x12
    add	x13,	x25,	x26
    ldr	w23,	[x6]

    ldr	w27,	[x13]

    str	w27,	[x6]

    str	w23,	[x13]

    cmp	w14,	w28
    blt	main_149

main_172:
    movz	w17,	#0
    b	main_173

main_171:
    movz	w17,	#0

main_173:
    sub	w2,	w28,	w17
    cmp	w2,	#0
    beq	main_188

main_177:
    lsl	w5,	w17,	#2
    lsl	w8,	w17,	#2
    movz	fp,	#13624
    lsl	w12,	w17,	#2
    mov	x21,	x5
    mov	x7,	x8
    movk	fp,	#12,	lsl #16
    add	w17,	w17,	#1
    add	x21,	sp,	x21
    add	x7,	sp,	x7
    add	x21,	x21,	#16
    add	x7,	x7,	fp
    movz	fp,	#6820
    movk	fp,	#6,	lsl #16
    ldr	w14,	[x21]

    ldr	w27,	[x7]

    sub	w19,	w14,	w27
    str	w19,	[x21]

    mov	x21,	x12
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w13,	[x21]

    sub	w14,	w13,	w19
    sub	w15,	w14,	w27
    str	w15,	[x21]

    b	main_173

main_188:
    movz	w18,	#0

main_190:
    sub	w17,	w18,	w28
    cmp	w17,	#0
    beq	main_203

main_194:
    lsl	w21,	w18,	#2
    mov	x20,	x21
    add	x20,	sp,	x20
    add	x20,	x20,	#16
    ldr	w22,	[x20]

    cmp	w22,	#0
    bne	main_204

main_198:
    lsl	w25,	w18,	#2
    movz	fp,	#6820
    add	w18,	w18,	#1
    mov	x24,	x25
    movk	fp,	#6,	lsl #16
    add	x24,	sp,	x24
    add	x24,	x24,	fp
    ldr	w26,	[x24]

    cmp	w26,	#0
    beq	main_190

main_205:
    movz	w0,	#2
    b	main_206

main_204:
    movz	w0,	#1
    b	main_206

main_203:
    movz	w0,	#65413
    movk	w0,	#65535,	lsl #16

main_206:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#20432
    movk	fp,	#18,	lsl #16
    add	sp, sp, fp
    ret


main_50:
    cmp	w5,	#45
    movz	w19,	#1
    csel	w26,	w19,	w26,	eq
    bl	getch
    mov	w5,	w0
    b	main_42

main_13:
    cmp	w28,	#45
    movz	w20,	#1
    csel	w22,	w20,	w22,	eq
    bl	getch
    mov	w28,	w0
    b	main_5

