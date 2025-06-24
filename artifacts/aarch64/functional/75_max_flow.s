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
    sub	sp, sp, #160
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	w19,	w1
    str	w0,	[sp, #124]

    str	w2,	[sp, #96]

    ldr	w25,	[sp, #124]

    cmp	w25,	w19
    beq	dfs_92

dfs_5:
    ldr	w26,	[sp, #124]

    adrp	x17, :got:used
    movz	w12,	#1
    adrp	x22, :got:size
    lsl	w2,	w26,	#2
    ldr	x17, [x17, #:got_lo12:used]
    add	x15,	x17,	x2
    str	w12,	[x15]

    ldr	w27,	[sp, #124]

    ldr	x22, [x22, #:got_lo12:size]
    lsl	w5,	w27,	#2
    adrp	x27, :got:to
    add	x4,	x22,	x5
    ldr	w18,	[x4]

    adrp	x4, :got:cap
    str	w18,	[sp, #116]

    ldr	w28,	[sp, #124]

    ldr	w2,	[sp, #124]

    lsl	w5,	w28,	#3
    ldr	x27, [x27, #:got_lo12:to]
    add	w9,	w5,	w2,	lsl #5
    ldr	w3,	[sp, #124]

    ldr	w1,	[sp, #124]

    lsl	w2,	w3,	#3
    ldr	x4, [x4, #:got_lo12:cap]
    add	x25,	x27,	x9
    add	w1,	w2,	w1,	lsl #5
    add	x24,	x4,	x1
    movz	w4,	#0
    str	w4,	[sp, #112]


dfs_11:
    ldr	w3,	[sp, #112]

    ldr	w17,	[sp, #116]

    cmp	w3,	w17
    bge	dfs_93

dfs_14:
    ldr	w0,	[sp, #112]

    adrp	x5, :got:used
    lsl	w10,	w0,	#2
    add	x9,	x25,	x10
    ldr	w3,	[x9]

    str	w3,	[sp, #128]

    ldr	w4,	[sp, #128]

    ldr	x5, [x5, #:got_lo12:used]
    lsl	w13,	w4,	#2
    add	x11,	x5,	x13
    ldr	w6,	[x11]

    cmp	w6,	#0
    beq	dfs_22

dfs_20:
    ldr	w1,	[sp, #112]

    add	w11,	w1,	#1
    b	dfs_90

dfs_22:
    ldr	w16,	[sp, #112]

    movz	fp,	#100
    lsl	w12,	w16,	#2
    add	x20,	x24,	x12
    str	x20,	[sp, fp]

    movz	fp,	#100
    ldr	x21,	[sp, fp]

    ldr	w13,	[x21]

    cmp	w13,	#0
    bgt	dfs_28

dfs_26:
    ldr	w3,	[sp, #112]

    add	w11,	w3,	#1
    b	dfs_90

dfs_28:
    ldr	w16,	[sp, #96]

    cmp	w16,	w13
    ldr	w17,	[sp, #96]

    ldr	w7,	[sp, #128]

    csel	w28,	w17,	w13,	lt
    cmp	w7,	w19
    beq	dfs_73

dfs_32:
    movz	w1,	#1
    adrp	x4, :got:size
    adrp	x2, :got:to
    adrp	x5, :got:cap
    movz	w26,	#0
    str	w1,	[x11]

    ldr	w22,	[sp, #128]

    ldr	x4, [x4, #:got_lo12:size]
    lsl	w18,	w22,	#2
    add	x17,	x4,	x18
    ldr	w22,	[x17]

    ldr	w9,	[sp, #128]

    ldr	w11,	[sp, #128]

    lsl	w12,	w9,	#3
    ldr	x2, [x2, #:got_lo12:to]
    add	w7,	w12,	w11,	lsl #5
    add	x13,	x2,	x7
    str	x13,	[sp, #136]

    ldr	w11,	[sp, #128]

    ldr	w15,	[sp, #128]

    lsl	w13,	w11,	#3
    ldr	x5, [x5, #:got_lo12:cap]
    add	w10,	w13,	w15,	lsl #5
    add	x11,	x5,	x10
    str	x11,	[sp, #152]

    str	w26,	[sp, #120]


dfs_37:
    ldr	w9,	[sp, #120]

    cmp	w9,	w22
    bge	dfs_74

dfs_40:
    ldr	w10,	[sp, #120]

    ldr	x14,	[sp, #136]

    lsl	w15,	w10,	#2
    add	x13,	x14,	x15
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
    ldr	w11,	[sp, #120]

    add	w3,	w11,	#1
    b	dfs_71

dfs_48:
    ldr	w12,	[sp, #120]

    ldr	x14,	[sp, #152]

    lsl	w15,	w12,	#2
    add	x16,	x14,	x15
    str	x16,	[sp, #144]

    ldr	x17,	[sp, #144]

    ldr	w16,	[x17]

    cmp	w16,	#0
    bgt	dfs_54

dfs_52:
    ldr	w13,	[sp, #120]

    add	w3,	w13,	#1
    b	dfs_71

dfs_54:
    cmp	w28,	w16
    mov	w1,	w19
    ldr	w0,	[sp, #108]

    csel	w2,	w28,	w16,	lt
    bl	dfs
    cmp	w0,	#0
    ble	dfs_69

dfs_59:
    ldr	x20,	[sp, #144]

    adrp	x22, :got:rev
    ldr	w6,	[x20]

    ldr	x21,	[sp, #144]

    sub	w7,	w6,	w0
    str	w7,	[x21]

    ldr	w4,	[sp, #128]

    ldr	w16,	[sp, #128]

    lsl	w17,	w4,	#3
    ldr	x22, [x22, #:got_lo12:rev]
    add	w9,	w17,	w16,	lsl #5
    ldr	w18,	[sp, #120]

    lsl	w14,	w18,	#2
    add	x8,	x22,	x9
    add	x16,	x8,	x14
    ldr	w18,	[x16]

    lsl	w7,	w18,	#2
    adrp	x16, :got:cap
    ldr	w27,	[sp, #108]

    ldr	w2,	[sp, #108]

    lsl	w22,	w27,	#3
    ldr	x16, [x16, #:got_lo12:cap]
    add	w28,	w22,	w2,	lsl #5
    add	x23,	x16,	x28
    add	x13,	x23,	x7
    ldr	w2,	[x13]

    add	w3,	w2,	w0
    str	w3,	[x13]

    b	dfs_75

dfs_69:
    ldr	w15,	[sp, #120]

    add	w3,	w15,	#1

dfs_71:
    str	w3,	[sp, #120]

    b	dfs_37

dfs_74:
    movz	w0,	#0
    b	dfs_75

dfs_73:
    mov	w0,	w28

dfs_75:
    cmp	w0,	#0
    bgt	dfs_78

dfs_88:
    ldr	w4,	[sp, #112]

    add	w11,	w4,	#1

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

    ldr	w4,	[sp, #124]

    ldr	w10,	[sp, #124]

    lsl	w6,	w4,	#3
    ldr	x21, [x21, #:got_lo12:rev]
    add	w3,	w6,	w10,	lsl #5
    ldr	w16,	[sp, #112]

    lsl	w8,	w16,	#2
    add	x2,	x21,	x3
    add	x8,	x2,	x8
    ldr	w10,	[x8]

    lsl	w14,	w10,	#2
    ldr	w22,	[sp, #128]

    ldr	w20,	[sp, #128]

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
    
    add	sp, sp, #160
    ret


.globl main
main:
main_0:
    sub	sp, sp, #112
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w19,	w0
    movz	w9,	#0
    movz	w8,	#0
    movz	w11,	#0
    adrp	x10, :got:size
    movz	w5,	#0
    movz	w6,	#0
    movz	w7,	#0
    ldr	x10, [x10, #:got_lo12:size]
    add	x3,	x10,	#12
    add	x2,	x10,	#8
    add	x4,	x10,	#4
    str	w9,	[x10]

    add	x9,	x10,	#28
    str	w8,	[x4]

    add	x8,	x10,	#24
    add	x4,	x10,	#16
    str	w7,	[x2]

    movz	w2,	#0
    add	x7,	x10,	#20
    str	w6,	[x3]

    movz	w3,	#0
    str	w5,	[x4]

    movz	w4,	#0
    str	w4,	[x7]

    movz	w4,	#0
    str	w3,	[x8]

    add	x3,	x10,	#36
    str	w2,	[x9]

    add	x9,	x10,	#32
    str	w4,	[x9]

    str	w11,	[x3]


main_14:
    cmp	w19,	#0
    ble	main_41

main_17:
    bl	getint
    mov	w22,	w0
    bl	getint
    mov	w26,	w0
    bl	getint
    adrp	x14, :got:rev
    lsl	w8,	w22,	#3
    lsl	w9,	w22,	#3
    adrp	x4, :got:to
    lsl	w10,	w22,	#2
    adrp	x20, :got:size
    adrp	x16, :got:size
    movz	w27,	#0
    lsl	w15,	w26,	#3
    add	w7,	w8,	w22,	lsl #5
    ldr	x16, [x16, #:got_lo12:size]
    adrp	x8, :got:cap
    add	w12,	w15,	w26,	lsl #5
    add	x21,	x16,	x10
    str	x21,	[sp, #104]

    lsl	w21,	w26,	#3
    ldr	x23,	[sp, #104]

    ldr	w13,	[x23]

    str	w13,	[sp, #100]

    add	w13,	w21,	w26,	lsl #5
    ldr	x4, [x4, #:got_lo12:to]
    ldr	w23,	[sp, #100]

    add	x4,	x4,	x7
    lsl	w6,	w23,	#2
    add	x5,	x4,	x6
    adrp	x4, :got:to
    add	w6,	w9,	w22,	lsl #5
    adrp	x9, :got:cap
    str	w26,	[x5]

    ldr	x9, [x9, #:got_lo12:cap]
    ldr	w24,	[sp, #100]

    add	x5,	x9,	x6
    lsl	w11,	w24,	#2
    add	x10,	x5,	x11
    str	w0,	[x10]

    ldr	x14, [x14, #:got_lo12:rev]
    lsl	w10,	w22,	#3
    ldr	w25,	[sp, #100]

    add	w11,	w10,	w22,	lsl #5
    ldr	x20, [x20, #:got_lo12:size]
    lsl	w16,	w25,	#2
    add	x10,	x14,	x11
    lsl	w14,	w26,	#3
    add	x10,	x10,	x16
    lsl	w16,	w26,	#2
    add	x5,	x20,	x16
    ldr	w1,	[x5]

    lsl	w2,	w1,	#2
    str	w1,	[x10]

    lsl	w10,	w1,	#2
    ldr	x4, [x4, #:got_lo12:to]
    add	x13,	x4,	x13
    add	w4,	w14,	w26,	lsl #5
    adrp	x26, :got:rev
    add	x7,	x13,	x2
    lsl	w2,	w1,	#2
    sub	w1,	w19,	#1
    str	w22,	[x7]

    mov	w19,	w1
    ldr	x8, [x8, #:got_lo12:cap]
    add	x3,	x8,	x4
    add	x8,	x3,	x10
    str	w27,	[x8]

    ldr	x26, [x26, #:got_lo12:rev]
    ldr	w18,	[sp, #100]

    add	x12,	x26,	x12
    add	x27,	x12,	x2
    str	w18,	[x27]

    ldr	w26,	[sp, #100]

    ldr	x25,	[sp, #104]

    add	w4,	w26,	#1
    str	w4,	[x25]

    ldr	w24,	[x5]

    add	w25,	w24,	#1
    str	w25,	[x5]

    b	main_14

main_41:
    adrp	x5, :got:used
    movz	fp,	#92
    movz	w0,	#0
    ldr	x5, [x5, #:got_lo12:used]
    add	x12,	x5,	#28
    add	x25,	x5,	#24
    add	x22,	x5,	#20
    add	x15,	x5,	#16
    add	x16,	x5,	#12
    add	x4,	x5,	#32
    add	x19,	x5,	#8
    add	x18,	x5,	#4
    str	x5,	[sp, fp]

    movz	fp,	#76
    str	x18,	[sp, fp]

    movz	fp,	#36
    str	x19,	[sp, fp]

    movz	fp,	#28
    str	x16,	[sp, fp]

    movz	fp,	#68
    str	x15,	[sp, fp]

    movz	fp,	#52
    str	x22,	[sp, fp]

    movz	fp,	#44
    str	x25,	[sp, fp]

    movz	fp,	#60
    str	x12,	[sp, fp]

    add	x12,	x5,	#36
    movz	fp,	#20
    str	x4,	[sp, fp]

    movz	fp,	#84
    str	x12,	[sp, fp]

    str	w0,	[sp, #16]


main_53:
    movz	w1,	#0
    movz	fp,	#92
    movz	w0,	#0
    movz	w21,	#0
    movz	w2,	#0
    ldr	x26,	[sp, fp]

    movz	fp,	#76
    str	w1,	[x26]

    ldr	x22,	[sp, fp]

    movz	fp,	#36
    str	w0,	[x22]

    movz	w0,	#0
    ldr	x19,	[sp, fp]

    movz	fp,	#28
    str	w21,	[x19]

    movz	w21,	#0
    ldr	x1,	[sp, fp]

    movz	fp,	#68
    str	w2,	[x1]

    movz	w2,	#0
    movz	w1,	#0
    ldr	x19,	[sp, fp]

    movz	fp,	#52
    str	w1,	[x19]

    movz	w1,	#0
    ldr	x23,	[sp, fp]

    movz	fp,	#44
    str	w0,	[x23]

    ldr	x26,	[sp, fp]

    movz	fp,	#60
    str	w21,	[x26]

    ldr	x0,	[sp, fp]

    movz	fp,	#20
    str	w2,	[x0]

    movz	w0,	#0
    movz	w2,	#0
    ldr	x19,	[sp, fp]

    movk	w2,	#28672,	lsl #16
    movz	fp,	#84
    str	w1,	[x19]

    mov	w1,	w28
    ldr	x25,	[sp, fp]

    str	w0,	[x25]

    movz	w0,	#1
    bl	dfs
    cmp	w0,	#0
    beq	main_59

main_57:
    ldr	w9,	[sp, #16]

    add	w2,	w0,	w9
    str	w2,	[sp, #16]

    b	main_53

main_59:
    ldr	w0,	[sp, #16]

    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #112
    ret


