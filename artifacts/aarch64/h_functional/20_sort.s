.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global cnt
.align	2
cnt:
.type cnt, %object
    .zero	1600080

.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    movz	fp,	#20432
    movk	fp,	#18,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w25,	#6804
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w25,	#6,	lsl #16
    mov	x2,	x25
    bl	memset
    mov	x2,	x25
    movz	w1,	#0
    movz	fp,	#6820
    movk	fp,	#6,	lsl #16
    add	x0,	sp,	fp
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
    ble	main_24

main_31:
    movz	w6,	#0
    sub	w9,	w6,	w24
    cmp	w22,	#0
    movz	w14,	#0
    csel	w21,	w9,	w24,	ne
    cmp	w14,	w21
    beq	main_78

main_36:
    movz	w19,	#0

main_38:
    lsl	w18,	w19,	#2
    movz	fp,	#13624
    mov	x22,	x18
    movk	fp,	#12,	lsl #16
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    bl	getch
    movz	w23,	#0
    mov	w27,	w0

main_42:
    cmp	w27,	#48
    blt	main_50

main_46:
    cmp	w27,	#57
    bgt	main_50

main_54:
    movz	w28,	#0

main_55:
    cmp	w27,	#48
    blt	main_68

main_59:
    cmp	w27,	#57
    ble	main_61

main_68:
    movz	w1,	#0
    sub	w20,	w1,	w28
    cmp	w23,	#0
    csel	w24,	w20,	w28,	ne
    lsl	w26,	w19,	#2
    movz	fp,	#6820
    lsl	w28,	w19,	#2
    str	w24,	[x22]

    mov	x25,	x26
    movk	fp,	#6,	lsl #16
    add	w19,	w19,	#1
    mov	x27,	x28
    add	x25,	sp,	x25
    add	x27,	sp,	x27
    add	x25,	x25,	fp
    add	x27,	x27,	#16
    str	w24,	[x25]

    str	w24,	[x27]

    cmp	w19,	w21
    bne	main_38
    b	main_78

main_61:
    lsl	w20,	w28,	#1
    add	w18,	w20,	w28,	lsl #3
    add	w18,	w27,	w18
    sub	w28,	w18,	#48
    bl	getch
    mov	w27,	w0
    b	main_55

main_50:
    cmp	w27,	#45
    movz	w24,	#1
    csel	w23,	w24,	w23,	eq
    bl	getch
    mov	w27,	w0
    b	main_42

main_78:
    movz	fp,	#13624
    movz	w23,	#0
    movk	fp,	#12,	lsl #16
    add	x14,	sp,	fp
    cmp	w23,	w21
    bge	main_107

main_81:
    movz	w0,	#0

main_83:
    add	w26,	w0,	#1
    cmp	w26,	w21
    bge	main_103

main_87:
    lsl	w0,	w0,	#2
    mov	w7,	w26
    add	x1,	x14,	x0

main_90:
    ldr	w20,	[x1]

    lsl	w18,	w7,	#2
    add	x24,	x14,	x18
    ldr	w19,	[x24]

    cmp	w20,	w19
    ble	main_98

main_96:
    str	w19,	[x1]

    str	w20,	[x24]


main_98:
    add	w7,	w7,	#1
    cmp	w7,	w21
    blt	main_90

main_103:
    cmp	w26,	w21
    bge	main_107

main_82:
    mov	w0,	w26
    b	main_83

main_107:
    movz	fp,	#6820
    movz	w17,	#0
    movz	w9,	#65436
    movk	fp,	#6,	lsl #16
    movk	w9,	#65535,	lsl #16
    add	x13,	sp,	fp

main_109:
    cmp	w17,	w21
    blt	main_113

main_122:
    movz	w26,	#0
    cmp	w26,	w9
    bgt	main_144

main_124:
    movz	w23,	#0
    movz	w6,	#0

main_126:
    lsl	w7,	w23,	#2
    adrp	x17, :got:cnt
    ldr	x17, [x17, #:got_lo12:cnt]
    add	x15,	x17,	x7
    ldr	w22,	[x15]


main_131:
    cmp	w22,	#0
    bne	main_135

main_139:
    add	w23,	w23,	#1
    cmp	w23,	w9
    ble	main_126
    b	main_144

main_135:
    lsl	w16,	w6,	#2
    sub	w22,	w22,	#1
    add	w6,	w6,	#1
    add	x15,	x13,	x16
    str	w23,	[x15]

    b	main_131

main_144:
    add	x3,	sp,	#16
    movz	w0,	#0
    cmp	w0,	w21
    bge	main_171

main_147:
    movz	w23,	#0

main_149:
    add	w10,	w23,	#1
    mov	w15,	w23

main_152:
    cmp	w10,	w21
    blt	main_156

main_164:
    lsl	w17,	w23,	#2
    lsl	w4,	w15,	#2
    add	w23,	w23,	#1
    add	x9,	x3,	x17
    add	x19,	x3,	x4
    ldr	w28,	[x9]

    ldr	w5,	[x19]

    str	w5,	[x9]

    str	w28,	[x19]

    cmp	w23,	w21
    blt	main_149

main_172:
    movz	w26,	#0
    b	main_173

main_156:
    lsl	w5,	w10,	#2
    lsl	w8,	w15,	#2
    add	x4,	x3,	x5
    add	x7,	x3,	x8
    ldr	w24,	[x4]

    ldr	w9,	[x7]

    cmp	w24,	w9
    csel	w15,	w10,	w15,	lt
    add	w10,	w10,	#1
    b	main_152

main_171:
    movz	w26,	#0

main_173:
    sub	w17,	w21,	w26
    cmp	w17,	#0
    bne	main_177

main_188:
    movz	w27,	#0

main_190:
    sub	w19,	w27,	w21
    cmp	w19,	#0
    bne	main_194

main_203:
    movz	w0,	#65413
    movk	w0,	#65535,	lsl #16
    b	main_206

main_194:
    lsl	w23,	w27,	#2
    movz	fp,	#6820
    mov	x22,	x23
    movk	fp,	#6,	lsl #16
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    ldr	w24,	[x22]

    cmp	w24,	#0
    beq	main_198

main_204:
    movz	w0,	#1
    b	main_206

main_198:
    lsl	w28,	w27,	#2
    add	w27,	w27,	#1
    mov	x26,	x28
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    ldr	w0,	[x26]

    cmp	w0,	#0
    beq	main_190

main_205:
    movz	w0,	#2

main_206:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#20432
    movk	fp,	#18,	lsl #16
    add	sp, sp, fp
    ret


main_177:
    lsl	w4,	w26,	#2
    movz	fp,	#6820
    lsl	w7,	w26,	#2
    lsl	w11,	w26,	#2
    mov	x19,	x4
    movk	fp,	#6,	lsl #16
    mov	x6,	x7
    add	w26,	w26,	#1
    add	x19,	sp,	x19
    add	x6,	sp,	x6
    add	x19,	x19,	fp
    movz	fp,	#13624
    movk	fp,	#12,	lsl #16
    ldr	w13,	[x19]

    add	x6,	x6,	fp
    ldr	w27,	[x6]

    sub	w17,	w13,	w27
    str	w17,	[x19]

    mov	x19,	x11
    add	x19,	sp,	x19
    add	x19,	x19,	#16
    ldr	w12,	[x19]

    sub	w13,	w12,	w17
    sub	w14,	w13,	w27
    str	w14,	[x19]

    b	main_173

main_113:
    lsl	w18,	w17,	#2
    adrp	x23, :got:cnt
    add	x16,	x13,	x18
    ldr	w20,	[x16]

    ldr	x23, [x23, #:got_lo12:cnt]
    lsl	w2,	w20,	#2
    add	x26,	x23,	x2
    ldr	w24,	[x26]

    add	w25,	w24,	#1
    str	w25,	[x26]

    cmp	w20,	w9
    add	w17,	w17,	#1
    csel	w9,	w20,	w9,	gt
    b	main_109

main_24:
    lsl	w21,	w24,	#1
    add	w18,	w21,	w24,	lsl #3
    add	w25,	w28,	w18
    sub	w24,	w25,	#48
    bl	getch
    mov	w28,	w0
    b	main_18

main_13:
    cmp	w28,	#45
    movz	w20,	#1
    csel	w22,	w20,	w22,	eq
    bl	getch
    mov	w28,	w0
    b	main_5

