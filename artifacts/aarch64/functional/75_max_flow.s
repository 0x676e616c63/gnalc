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
    sub	sp, sp, #192
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	w19,	w1
    str	w0,	[sp, #128]

    str	w2,	[sp, #96]

    ldr	w25,	[sp, #128]

    cmp	w25,	w19
    beq	dfs_92

dfs_5:
    ldr	w26,	[sp, #128]

    adrp	x17, :got:used
    movz	w12,	#1
    adrp	x21, :got:size
    adrp	x0, :got:to
    lsl	w2,	w26,	#2
    ldr	x17, [x17, #:got_lo12:used]
    add	x15,	x17,	x2
    str	w12,	[x15]

    ldr	w27,	[sp, #128]

    ldr	x21, [x21, #:got_lo12:size]
    lsl	w5,	w27,	#2
    add	x4,	x21,	x5
    ldr	w7,	[x4]

    movz	w4,	#0
    str	w7,	[sp, #164]

    ldr	w1,	[sp, #128]

    ldr	w25,	[sp, #128]

    lsl	w28,	w1,	#3
    ldr	x0, [x0, #:got_lo12:to]
    add	w23,	w28,	w25,	lsl #5
    add	x18,	x0,	x23
    str	x18,	[sp, #120]

    ldr	w3,	[sp, #128]

    ldr	w28,	[sp, #128]

    lsl	w1,	w3,	#3
    adrp	x3, :got:cap
    add	w28,	w1,	w28,	lsl #5
    ldr	x3, [x3, #:got_lo12:cap]
    add	x27,	x3,	x28
    str	x27,	[sp, #136]

    str	w4,	[sp, #112]


dfs_11:
    ldr	w5,	[sp, #112]

    ldr	w13,	[sp, #164]

    cmp	w5,	w13
    bge	dfs_93

dfs_14:
    ldr	w6,	[sp, #112]

    adrp	x16, :got:used
    ldr	x20,	[sp, #120]

    lsl	w6,	w6,	#2
    add	x5,	x20,	x6
    ldr	w8,	[x5]

    str	w8,	[sp, #132]

    ldr	w9,	[sp, #132]

    ldr	x16, [x16, #:got_lo12:used]
    lsl	w9,	w9,	#2
    add	x3,	x16,	x9
    ldr	w17,	[x3]

    cmp	w17,	#0
    beq	dfs_22

dfs_20:
    ldr	w7,	[sp, #112]

    add	w11,	w7,	#1
    b	dfs_90

dfs_22:
    ldr	w2,	[sp, #112]

    movz	fp,	#100
    ldr	x28,	[sp, #136]

    lsl	w24,	w2,	#2
    add	x22,	x28,	x24
    str	x22,	[sp, fp]

    movz	fp,	#100
    ldr	x23,	[sp, fp]

    ldr	w25,	[x23]

    cmp	w25,	#0
    bgt	dfs_28

dfs_26:
    ldr	w9,	[sp, #112]

    add	w11,	w9,	#1
    b	dfs_90

dfs_28:
    ldr	w0,	[sp, #96]

    cmp	w0,	w25
    ldr	w1,	[sp, #96]

    ldr	w23,	[sp, #132]

    csel	w26,	w1,	w25,	lt
    cmp	w23,	w19
    beq	dfs_73

dfs_32:
    movz	w28,	#1
    adrp	x25, :got:size
    adrp	x8, :got:to
    movz	fp,	#156
    adrp	x5, :got:cap
    str	w28,	[x3]

    ldr	w6,	[sp, #132]

    ldr	x25, [x25, #:got_lo12:size]
    lsl	w3,	w6,	#2
    add	x2,	x25,	x3
    ldr	w17,	[x2]

    str	w17,	[sp, #168]

    ldr	w23,	[sp, #132]

    ldr	w10,	[sp, #132]

    lsl	w24,	w23,	#3
    ldr	x8, [x8, #:got_lo12:to]
    add	w28,	w24,	w10,	lsl #5
    movz	w24,	#0
    add	x14,	x8,	x28
    str	x14,	[sp, fp]

    movz	fp,	#172
    ldr	w11,	[sp, #132]

    ldr	w15,	[sp, #132]

    lsl	w13,	w11,	#3
    ldr	x5, [x5, #:got_lo12:cap]
    add	w10,	w13,	w15,	lsl #5
    add	x21,	x5,	x10
    str	x21,	[sp, fp]

    str	w24,	[sp, #116]


dfs_37:
    ldr	w9,	[sp, #116]

    ldr	w15,	[sp, #168]

    cmp	w9,	w15
    bge	dfs_74

dfs_40:
    ldr	w10,	[sp, #116]

    movz	fp,	#156
    lsl	w14,	w10,	#2
    ldr	x11,	[sp, fp]

    add	x13,	x11,	x14
    adrp	x14, :got:used
    ldr	w15,	[x13]

    str	w15,	[sp, #108]

    ldr	w16,	[sp, #108]

    ldr	x14, [x14, #:got_lo12:used]
    lsl	w9,	w16,	#2
    add	x8,	x14,	x9
    ldr	w11,	[x8]

    cmp	w11,	#0
    beq	dfs_48

dfs_46:
    ldr	w11,	[sp, #116]

    add	w3,	w11,	#1
    b	dfs_71

dfs_48:
    ldr	w12,	[sp, #116]

    movz	fp,	#172
    lsl	w15,	w12,	#2
    ldr	x18,	[sp, fp]

    movz	fp,	#148
    add	x6,	x18,	x15
    str	x6,	[sp, fp]

    movz	fp,	#148
    ldr	x7,	[sp, fp]

    ldr	w16,	[x7]

    cmp	w16,	#0
    bgt	dfs_54

dfs_52:
    ldr	w13,	[sp, #116]

    add	w3,	w13,	#1
    b	dfs_71

dfs_54:
    cmp	w26,	w16
    mov	w1,	w19
    ldr	w0,	[sp, #108]

    csel	w2,	w26,	w16,	lt
    bl	dfs
    cmp	w0,	#0
    ble	dfs_69

dfs_59:
    movz	fp,	#148
    adrp	x1, :got:cap
    ldr	x9,	[sp, fp]

    movz	fp,	#148
    ldr	w11,	[x9]

    sub	w13,	w11,	w0
    ldr	x10,	[sp, fp]

    str	w13,	[x10]

    adrp	x10, :got:rev
    ldr	w13,	[sp, #132]

    ldr	w2,	[sp, #132]

    lsl	w16,	w13,	#3
    ldr	x10, [x10, #:got_lo12:rev]
    add	w14,	w16,	w2,	lsl #5
    ldr	w3,	[sp, #116]

    lsl	w20,	w3,	#2
    add	x13,	x10,	x14
    add	x7,	x13,	x20
    ldr	w9,	[x7]

    lsl	w16,	w9,	#2
    ldr	w11,	[sp, #108]

    ldr	w28,	[sp, #108]

    lsl	w20,	w11,	#3
    ldr	x1, [x1, #:got_lo12:cap]
    add	w13,	w20,	w28,	lsl #5
    add	x12,	x1,	x13
    add	x21,	x12,	x16
    ldr	w15,	[x21]

    add	w16,	w15,	w0
    str	w16,	[x21]

    b	dfs_75

dfs_69:
    ldr	w15,	[sp, #116]

    add	w3,	w15,	#1

dfs_71:
    str	w3,	[sp, #116]

    b	dfs_37

dfs_74:
    movz	w0,	#0
    b	dfs_75

dfs_73:
    mov	w0,	w26

dfs_75:
    cmp	w0,	#0
    bgt	dfs_78

dfs_88:
    ldr	w10,	[sp, #112]

    add	w11,	w10,	#1

dfs_90:
    str	w11,	[sp, #112]

    b	dfs_11

dfs_78:
    movz	fp,	#100
    adrp	x21, :got:rev
    adrp	x27, :got:cap
    ldr	x24,	[sp, fp]

    movz	fp,	#100
    ldr	w15,	[x24]

    sub	w16,	w15,	w0
    ldr	x25,	[sp, fp]

    str	w16,	[x25]

    ldr	w4,	[sp, #128]

    ldr	w10,	[sp, #128]

    lsl	w6,	w4,	#3
    ldr	x21, [x21, #:got_lo12:rev]
    add	w3,	w6,	w10,	lsl #5
    ldr	w16,	[sp, #112]

    lsl	w8,	w16,	#2
    add	x2,	x21,	x3
    add	x8,	x2,	x8
    ldr	w10,	[x8]

    lsl	w14,	w10,	#2
    ldr	w22,	[sp, #132]

    ldr	w20,	[sp, #132]

    lsl	w16,	w22,	#3
    ldr	x27, [x27, #:got_lo12:cap]
    add	w9,	w16,	w20,	lsl #5
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
    ldr	w0,	[sp, #96]


dfs_94:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #192
    ret


.globl main
main:
main_0:
    sub	sp, sp, #96
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w24,	w0
    bl	getint
    mov	w25,	w0
    movz	w17,	#0
    movz	w18,	#0
    movz	w20,	#0
    adrp	x10, :got:size
    movz	w16,	#0
    movz	w13,	#0
    movz	w15,	#0
    movz	w12,	#0
    movz	w19,	#0
    movz	w14,	#0
    ldr	x10, [x10, #:got_lo12:size]
    add	x8,	x10,	#32
    add	x7,	x10,	#28
    add	x6,	x10,	#24
    add	x5,	x10,	#20
    add	x3,	x10,	#12
    add	x2,	x10,	#8
    add	x4,	x10,	#4
    str	w20,	[x10]

    movz	w20,	#0
    str	w19,	[x4]

    add	x4,	x10,	#16
    str	w18,	[x2]

    str	w17,	[x3]

    add	x3,	x10,	#36
    str	w16,	[x4]

    str	w15,	[x5]

    str	w14,	[x6]

    str	w13,	[x7]

    str	w12,	[x8]

    str	w20,	[x3]


main_14:
    cmp	w25,	#0
    ble	main_41

main_17:
    bl	getint
    mov	w20,	w0
    bl	getint
    mov	w26,	w0
    bl	getint
    lsl	w1,	w26,	#3
    lsl	w22,	w20,	#3
    adrp	x5, :got:to
    sub	w25,	w25,	#1
    lsl	w10,	w20,	#2
    lsl	w19,	w20,	#3
    adrp	x27, :got:rev
    adrp	x16, :got:size
    lsl	w8,	w26,	#3
    lsl	w21,	w20,	#3
    add	w11,	w19,	w20,	lsl #5
    ldr	x16, [x16, #:got_lo12:size]
    add	w14,	w8,	w26,	lsl #5
    add	x3,	x16,	x10
    adrp	x16, :got:rev
    ldr	w9,	[x3]

    lsl	w18,	w9,	#2
    lsl	w13,	w9,	#2
    lsl	w7,	w9,	#2
    ldr	x5, [x5, #:got_lo12:to]
    add	x10,	x5,	x11
    adrp	x11, :got:cap
    add	x6,	x10,	x7
    lsl	w10,	w26,	#3
    add	w7,	w21,	w20,	lsl #5
    str	w26,	[x6]

    add	w15,	w10,	w26,	lsl #5
    ldr	x11, [x11, #:got_lo12:cap]
    adrp	x10, :got:to
    add	x6,	x11,	x7
    add	x12,	x6,	x13
    add	w6,	w1,	w26,	lsl #5
    add	w13,	w22,	w20,	lsl #5
    adrp	x22, :got:size
    str	w0,	[x12]

    ldr	x16, [x16, #:got_lo12:rev]
    ldr	x22, [x22, #:got_lo12:size]
    add	x12,	x16,	x13
    add	x11,	x12,	x18
    lsl	w18,	w26,	#2
    add	x5,	x22,	x18
    ldr	w22,	[x5]

    lsl	w7,	w22,	#2
    lsl	w2,	w22,	#2
    lsl	w12,	w22,	#2
    str	w22,	[x11]

    ldr	x10, [x10, #:got_lo12:to]
    add	x15,	x10,	x15
    adrp	x10, :got:cap
    add	x11,	x15,	x2
    str	w20,	[x11]

    ldr	x10, [x10, #:got_lo12:cap]
    add	x4,	x10,	x6
    movz	w6,	#0
    add	x12,	x4,	x12
    str	w6,	[x12]

    add	w6,	w9,	#1
    ldr	x27, [x27, #:got_lo12:rev]
    add	x14,	x27,	x14
    add	x28,	x14,	x7
    str	w9,	[x28]

    str	w6,	[x3]

    ldr	w22,	[x5]

    add	w23,	w22,	#1
    str	w23,	[x5]

    b	main_14

main_41:
    adrp	x6, :got:used
    movz	fp,	#84
    movz	w9,	#0
    ldr	x6, [x6, #:got_lo12:used]
    add	x0,	x6,	#28
    add	x21,	x6,	#24
    add	x3,	x6,	#20
    add	x25,	x6,	#36
    add	x13,	x6,	#16
    add	x26,	x6,	#12
    add	x10,	x6,	#32
    add	x7,	x6,	#8
    add	x16,	x6,	#4
    str	x6,	[sp, fp]

    movz	fp,	#52
    str	x16,	[sp, fp]

    movz	fp,	#68
    str	x7,	[sp, fp]

    movz	fp,	#44
    str	x13,	[sp, fp]

    movz	fp,	#60
    str	x3,	[sp, fp]

    movz	fp,	#76
    str	x21,	[sp, fp]

    movz	fp,	#28
    str	x0,	[sp, fp]

    movz	fp,	#36
    str	x10,	[sp, fp]

    movz	fp,	#20
    str	x25,	[sp, fp]

    str	w9,	[sp, #16]


main_53:
    movz	w2,	#0
    movz	fp,	#84
    movz	w1,	#0
    movz	w0,	#0
    movz	w21,	#0
    ldr	x28,	[sp, fp]

    movz	fp,	#52
    str	w2,	[x28]

    ldr	x2,	[sp, fp]

    movz	fp,	#68
    str	w1,	[x2]

    movz	w1,	#0
    movz	w2,	#0
    ldr	x19,	[sp, fp]

    movz	fp,	#44
    str	w0,	[x19]

    str	w21,	[x26]

    movz	w21,	#0
    ldr	x27,	[sp, fp]

    movz	fp,	#60
    str	w2,	[x27]

    movz	w2,	#0
    ldr	x0,	[sp, fp]

    movz	fp,	#76
    str	w1,	[x0]

    movz	w1,	#0
    movz	w0,	#0
    ldr	x18,	[sp, fp]

    movz	fp,	#28
    str	w0,	[x18]

    movz	w0,	#1
    ldr	x25,	[sp, fp]

    movz	fp,	#36
    str	w21,	[x25]

    ldr	x22,	[sp, fp]

    movz	fp,	#20
    str	w2,	[x22]

    movz	w2,	#0
    ldr	x21,	[sp, fp]

    movk	w2,	#28672,	lsl #16
    str	w1,	[x21]

    mov	w1,	w24
    bl	dfs
    cmp	w0,	#0
    beq	main_59

main_57:
    ldr	w17,	[sp, #16]

    add	w11,	w0,	w17
    str	w11,	[sp, #16]

    b	main_53

main_59:
    ldr	w0,	[sp, #16]

    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #96
    ret


