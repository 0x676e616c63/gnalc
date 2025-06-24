.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global size
.align	2
size:
    .zero	40

.global to
.align	2
to:
    .zero	400

.global cap
.align	2
cap:
    .zero	400

.global rev
.align	2
rev:
    .zero	400

.global used
.align	2
used:
    .zero	40


.text

.globl dfs
dfs:
dfs_3:
    sub	sp, sp, #176
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	w26,	w2
    mov	w21,	w1
    str	w0,	[sp, #124]

    ldr	w25,	[sp, #124]

    cmp	w25,	w21
    beq	dfs_92

dfs_5:
    ldr	w27,	[sp, #124]

    adrp	x22, :got:used
    movz	w4,	#1
    movz	fp,	#140
    movz	w25,	#0
    lsl	w14,	w27,	#2
    ldr	x22, [x22, #:got_lo12:used]
    adrp	x27, :got:size
    add	x18,	x22,	x14
    str	w4,	[x18]

    adrp	x4, :got:cap
    ldr	w28,	[sp, #124]

    ldr	x27, [x27, #:got_lo12:size]
    lsl	w17,	w28,	#2
    add	x16,	x27,	x17
    ldr	w0,	[x16]

    str	w0,	[sp, #132]

    ldr	w1,	[sp, #124]

    ldr	w24,	[sp, #124]

    lsl	w0,	w1,	#3
    add	w24,	w0,	w24,	lsl #5
    adrp	x0, :got:to
    ldr	x0, [x0, #:got_lo12:to]
    add	x19,	x0,	x24
    str	x19,	[sp, fp]

    ldr	w1,	[sp, #124]

    ldr	w27,	[sp, #124]

    lsl	w2,	w1,	#3
    ldr	x4, [x4, #:got_lo12:cap]
    add	w0,	w2,	w27,	lsl #5
    add	x22,	x4,	x0
    str	x22,	[sp, #96]

    str	w25,	[sp, #116]


dfs_11:
    ldr	w4,	[sp, #116]

    ldr	w1,	[sp, #132]

    cmp	w4,	w1
    bge	dfs_93

dfs_14:
    ldr	w4,	[sp, #116]

    movz	fp,	#140
    adrp	x16, :got:used
    lsl	w6,	w4,	#2
    ldr	x20,	[sp, fp]

    add	x5,	x20,	x6
    ldr	w6,	[x5]

    str	w6,	[sp, #128]

    ldr	w7,	[sp, #128]

    ldr	x16, [x16, #:got_lo12:used]
    lsl	w9,	w7,	#2
    add	x3,	x16,	x9
    ldr	w17,	[x3]

    cmp	w17,	#0
    beq	dfs_22

dfs_20:
    ldr	w5,	[sp, #116]

    add	w3,	w5,	#1
    b	dfs_90

dfs_22:
    ldr	w0,	[sp, #116]

    lsl	w25,	w0,	#2
    ldr	x0,	[sp, #96]

    add	x23,	x0,	x25
    str	x23,	[sp, #104]

    ldr	x24,	[sp, #104]

    ldr	w27,	[x24]

    cmp	w27,	#0
    bgt	dfs_28

dfs_26:
    ldr	w7,	[sp, #116]

    add	w3,	w7,	#1
    b	dfs_90

dfs_28:
    cmp	w26,	w27
    ldr	w18,	[sp, #128]

    csel	w22,	w26,	w27,	lt
    cmp	w18,	w21
    beq	dfs_73

dfs_32:
    movz	w8,	#1
    adrp	x28, :got:size
    adrp	x9, :got:to
    movz	fp,	#156
    movz	w6,	#0
    str	w8,	[x3]

    ldr	w4,	[sp, #128]

    ldr	x28, [x28, #:got_lo12:size]
    lsl	w3,	w4,	#2
    add	x2,	x28,	x3
    ldr	w28,	[x2]

    ldr	w18,	[sp, #128]

    ldr	w8,	[sp, #128]

    lsl	w27,	w18,	#3
    ldr	x9, [x9, #:got_lo12:to]
    add	w5,	w27,	w8,	lsl #5
    add	x19,	x9,	x5
    adrp	x5, :got:cap
    ldr	w9,	[sp, #128]

    ldr	w11,	[sp, #128]

    lsl	w13,	w9,	#3
    ldr	x5, [x5, #:got_lo12:cap]
    add	w10,	w13,	w11,	lsl #5
    add	x9,	x5,	x10
    str	x9,	[sp, fp]

    str	w6,	[sp, #120]


dfs_37:
    ldr	w7,	[sp, #120]

    cmp	w7,	w28
    bge	dfs_74

dfs_40:
    ldr	w8,	[sp, #120]

    lsl	w14,	w8,	#2
    add	x13,	x19,	x14
    ldr	w13,	[x13]

    str	w13,	[sp, #112]

    ldr	w14,	[sp, #112]

    lsl	w9,	w14,	#2
    adrp	x14, :got:used
    ldr	x14, [x14, #:got_lo12:used]
    add	x8,	x14,	x9
    ldr	w11,	[x8]

    cmp	w11,	#0
    beq	dfs_48

dfs_46:
    ldr	w9,	[sp, #120]

    add	w14,	w9,	#1
    b	dfs_71

dfs_48:
    ldr	w10,	[sp, #120]

    movz	fp,	#156
    lsl	w15,	w10,	#2
    ldr	x12,	[sp, fp]

    movz	fp,	#148
    add	x0,	x12,	x15
    str	x0,	[sp, fp]

    movz	fp,	#148
    ldr	x1,	[sp, fp]

    ldr	w16,	[x1]

    cmp	w16,	#0
    bgt	dfs_54

dfs_52:
    ldr	w11,	[sp, #120]

    add	w14,	w11,	#1
    b	dfs_71

dfs_54:
    cmp	w22,	w16
    mov	w1,	w21
    ldr	w0,	[sp, #112]

    csel	w2,	w22,	w16,	lt
    bl	dfs
    cmp	w0,	#0
    ble	dfs_69

dfs_59:
    movz	fp,	#148
    adrp	x10, :got:rev
    ldr	x3,	[sp, fp]

    movz	fp,	#148
    ldr	w11,	[x3]

    adrp	x3, :got:cap
    sub	w13,	w11,	w0
    ldr	x4,	[sp, fp]

    str	w13,	[x4]

    ldr	w11,	[sp, #128]

    ldr	w2,	[sp, #128]

    lsl	w16,	w11,	#3
    ldr	x10, [x10, #:got_lo12:rev]
    add	w14,	w16,	w2,	lsl #5
    ldr	w4,	[sp, #120]

    lsl	w19,	w4,	#2
    add	x13,	x10,	x14
    add	x7,	x13,	x19
    ldr	w9,	[x7]

    lsl	w16,	w9,	#2
    ldr	w7,	[sp, #112]

    ldr	w27,	[sp, #112]

    lsl	w19,	w7,	#3
    ldr	x3, [x3, #:got_lo12:cap]
    add	w13,	w19,	w27,	lsl #5
    add	x12,	x3,	x13
    add	x22,	x12,	x16
    ldr	w15,	[x22]

    add	w16,	w15,	w0
    str	w16,	[x22]

    b	dfs_75

dfs_69:
    ldr	w13,	[sp, #120]

    add	w14,	w13,	#1

dfs_71:
    str	w14,	[sp, #120]

    b	dfs_37

dfs_74:
    movz	w0,	#0
    b	dfs_75

dfs_73:
    mov	w0,	w22

dfs_75:
    cmp	w0,	#0
    bgt	dfs_78

dfs_88:
    ldr	w8,	[sp, #116]

    add	w3,	w8,	#1

dfs_90:
    str	w3,	[sp, #116]

    b	dfs_11

dfs_78:
    ldr	x22,	[sp, #104]

    adrp	x21, :got:rev
    adrp	x27, :got:cap
    ldr	w15,	[x22]

    ldr	x23,	[sp, #104]

    sub	w16,	w15,	w0
    str	w16,	[x23]

    ldr	w2,	[sp, #124]

    ldr	w8,	[sp, #124]

    lsl	w6,	w2,	#3
    ldr	x21, [x21, #:got_lo12:rev]
    add	w3,	w6,	w8,	lsl #5
    ldr	w14,	[sp, #116]

    lsl	w8,	w14,	#2
    add	x2,	x21,	x3
    add	x8,	x2,	x8
    ldr	w10,	[x8]

    lsl	w14,	w10,	#2
    ldr	w20,	[sp, #128]

    ldr	w18,	[sp, #128]

    lsl	w16,	w20,	#3
    ldr	x27, [x27, #:got_lo12:cap]
    add	w9,	w16,	w18,	lsl #5
    add	x8,	x27,	x9
    add	x14,	x8,	x14
    ldr	w13,	[x14]

    add	w16,	w13,	w0
    str	w16,	[x14]

    b	dfs_94

dfs_93:
    movz	w0,	#0
    b	dfs_94

dfs_92:
    mov	w0,	w26

dfs_94:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #176
    ret


.globl main
main:
main_0:
    sub	sp, sp, #112
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w23,	w0
    bl	getint
    mov	w19,	w0
    movz	w6,	#0
    movz	w7,	#0
    movz	w5,	#0
    adrp	x10, :got:size
    movz	w1,	#0
    ldr	x10, [x10, #:got_lo12:size]
    add	x9,	x10,	#32
    add	x8,	x10,	#28
    add	x3,	x10,	#12
    add	x2,	x10,	#8
    add	x4,	x10,	#4
    str	w7,	[x10]

    add	x7,	x10,	#20
    str	w6,	[x4]

    add	x6,	x10,	#16
    movz	w4,	#0
    str	w5,	[x2]

    movz	w2,	#0
    str	w4,	[x3]

    movz	w4,	#0
    movz	w3,	#0
    str	w3,	[x6]

    add	x3,	x10,	#36
    str	w2,	[x7]

    movz	w2,	#0
    add	x7,	x10,	#24
    str	w4,	[x7]

    str	w2,	[x8]

    str	w1,	[x9]

    movz	w9,	#0
    str	w9,	[x3]


main_14:
    cmp	w19,	#0
    ble	main_41

main_17:
    bl	getint
    mov	w21,	w0
    bl	getint
    mov	w26,	w0
    bl	getint
    movz	fp,	#84
    adrp	x15, :got:rev
    sub	w1,	w19,	#1
    adrp	x5, :got:to
    lsl	w20,	w26,	#3
    lsl	w10,	w21,	#2
    adrp	x22, :got:size
    lsl	w7,	w21,	#3
    adrp	x16, :got:size
    lsl	w13,	w26,	#3
    mov	w19,	w1
    add	w14,	w20,	w26,	lsl #5
    ldr	x16, [x16, #:got_lo12:size]
    add	x8,	x16,	x10
    adrp	x10, :got:cap
    str	x8,	[sp, fp]

    lsl	w8,	w21,	#3
    movz	fp,	#84
    ldr	x9,	[sp, fp]

    movz	fp,	#84
    ldr	w4,	[x9]

    lsl	w17,	w4,	#2
    lsl	w12,	w4,	#2
    ldr	x5, [x5, #:got_lo12:to]
    add	w9,	w7,	w21,	lsl #5
    lsl	w7,	w4,	#2
    add	x6,	x5,	x9
    lsl	w9,	w21,	#3
    add	x6,	x6,	x7
    add	w7,	w8,	w21,	lsl #5
    str	w26,	[x6]

    ldr	x10, [x10, #:got_lo12:cap]
    add	x6,	x10,	x7
    adrp	x7, :got:to
    add	x11,	x6,	x12
    add	w6,	w13,	w26,	lsl #5
    add	w12,	w9,	w21,	lsl #5
    str	w0,	[x11]

    ldr	x15, [x15, #:got_lo12:rev]
    ldr	x22, [x22, #:got_lo12:size]
    add	x11,	x15,	x12
    add	x11,	x11,	x17
    lsl	w17,	w26,	#2
    add	x5,	x22,	x17
    movz	w22,	#0
    ldr	w18,	[x5]

    lsl	w2,	w18,	#2
    str	w18,	[x11]

    lsl	w11,	w18,	#2
    ldr	x7, [x7, #:got_lo12:to]
    add	x14,	x7,	x14
    add	x9,	x14,	x2
    lsl	w14,	w26,	#3
    str	w21,	[x9]

    add	w13,	w14,	w26,	lsl #5
    adrp	x9, :got:cap
    adrp	x26, :got:rev
    ldr	x9, [x9, #:got_lo12:cap]
    add	x3,	x9,	x6
    add	x9,	x3,	x11
    lsl	w3,	w18,	#2
    str	w22,	[x9]

    ldr	x26, [x26, #:got_lo12:rev]
    add	x13,	x26,	x13
    add	x27,	x13,	x3
    str	w4,	[x27]

    ldr	x12,	[sp, fp]

    add	w4,	w4,	#1
    str	w4,	[x12]

    ldr	w24,	[x5]

    add	w25,	w24,	#1
    str	w25,	[x5]

    b	main_14

main_41:
    adrp	x24, :got:used
    movz	fp,	#92
    movz	w27,	#0
    ldr	x24, [x24, #:got_lo12:used]
    add	x28,	x24,	#28
    add	x8,	x24,	#24
    add	x16,	x24,	#20
    add	x12,	x24,	#36
    add	x2,	x24,	#16
    add	x10,	x24,	#12
    add	x13,	x24,	#32
    add	x11,	x24,	#8
    add	x5,	x24,	#4
    str	x24,	[sp, fp]

    movz	fp,	#60
    str	x5,	[sp, fp]

    movz	fp,	#68
    str	x11,	[sp, fp]

    movz	fp,	#100
    str	x10,	[sp, fp]

    movz	fp,	#52
    str	x2,	[sp, fp]

    movz	fp,	#36
    str	x16,	[sp, fp]

    movz	fp,	#76
    str	x8,	[sp, fp]

    movz	fp,	#44
    str	x28,	[sp, #16]

    str	x13,	[sp, #24]

    str	x12,	[sp, fp]

    str	w27,	[sp, #32]


main_53:
    movz	w21,	#0
    movz	fp,	#92
    movz	w2,	#0
    movz	w1,	#0
    ldr	x0,	[sp, fp]

    movz	fp,	#60
    str	w21,	[x0]

    movz	w21,	#0
    ldr	x22,	[sp, fp]

    movz	fp,	#68
    str	w2,	[x22]

    movz	w2,	#0
    ldr	x0,	[sp, fp]

    movz	fp,	#100
    str	w1,	[x0]

    movz	w1,	#0
    movz	w0,	#0
    ldr	x25,	[sp, fp]

    movz	fp,	#52
    str	w0,	[x25]

    movz	w0,	#0
    ldr	x18,	[sp, fp]

    movz	fp,	#36
    str	w21,	[x18]

    movz	w21,	#0
    ldr	x18,	[sp, fp]

    movz	fp,	#76
    str	w2,	[x18]

    movz	w2,	#0
    ldr	x26,	[sp, fp]

    movz	fp,	#44
    str	w1,	[x26]

    ldr	x1,	[sp, #16]

    str	w0,	[x1]

    mov	w1,	w23
    movz	w0,	#1
    ldr	x28,	[sp, #24]

    str	w21,	[x28]

    ldr	x21,	[sp, fp]

    str	w2,	[x21]

    movz	w2,	#0
    movk	w2,	#28672,	lsl #16
    bl	dfs
    cmp	w0,	#0
    beq	main_59

main_57:
    ldr	w7,	[sp, #32]

    add	w0,	w0,	w7
    str	w0,	[sp, #32]

    b	main_53

main_59:
    ldr	w0,	[sp, #32]

    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #112
    ret


