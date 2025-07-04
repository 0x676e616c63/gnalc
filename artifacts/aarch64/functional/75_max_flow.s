.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global size
.align	2
size:
.type size, %object
    .zero	40

.global to
.align	2
to:
.type to, %object
    .zero	400

.global cap
.align	2
cap:
.type cap, %object
    .zero	400

.global rev
.align	2
rev:
.type rev, %object
    .zero	400

.global used
.align	2
used:
.type used, %object
    .zero	40

.data

.text

.globl dfs
.align 2
.p2align 4,,11
.type dfs, %function
dfs:
dfs_3:
    sub	sp, sp, #160
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    mov	w27,	w2
    mov	w25,	w1
    str	w0,	[sp, #120]

    ldr	w23,	[sp, #120]

    cmp	w23,	w25
    bne	dfs_5

dfs_92:
    mov	w0,	w27
    b	dfs_94

dfs_5:
    ldr	w24,	[sp, #120]

    adrp	x3, :got:used
    movz	w12,	#1
    adrp	x6, :got:size
    adrp	x10, :got:to
    movz	fp,	#100
    lsl	w16,	w24,	#2
    ldr	x3, [x3, #:got_lo12:used]
    add	x15,	x3,	x16
    str	w12,	[x15]

    ldr	w26,	[sp, #120]

    ldr	x6, [x6, #:got_lo12:size]
    lsl	w19,	w26,	#2
    add	x4,	x6,	x19
    ldr	w20,	[x4]

    str	w20,	[sp, #96]

    ldr	w28,	[sp, #120]

    ldr	w0,	[sp, #120]

    lsl	w6,	w28,	#3
    ldr	x10, [x10, #:got_lo12:to]
    add	w23,	w6,	w0,	lsl #5
    add	x22,	x10,	x23
    str	x22,	[sp, fp]

    movz	w22,	#0
    ldr	w1,	[sp, #120]

    ldr	w2,	[sp, #120]

    lsl	w3,	w1,	#3
    adrp	x1, :got:cap
    add	w3,	w3,	w2,	lsl #5
    ldr	x1, [x1, #:got_lo12:cap]
    add	x19,	x1,	x3
    str	x19,	[sp, #128]

    str	w22,	[sp, #112]


dfs_11:
    ldr	w21,	[sp, #96]

    ldr	w24,	[sp, #112]

    cmp	w24,	w21
    blt	dfs_14

dfs_93:
    movz	w0,	#0
    b	dfs_94

dfs_14:
    ldr	w4,	[sp, #112]

    movz	fp,	#100
    adrp	x10, :got:used
    lsl	w6,	w4,	#2
    ldr	x19,	[sp, fp]

    add	x5,	x19,	x6
    ldr	w6,	[x5]

    str	w6,	[sp, #124]

    ldr	w7,	[sp, #124]

    ldr	x10, [x10, #:got_lo12:used]
    lsl	w15,	w7,	#2
    add	x8,	x10,	x15
    ldr	w11,	[x8]

    cmp	w11,	#0
    bne	dfs_20

dfs_24:
    ldr	w5,	[sp, #112]

    movz	fp,	#148
    ldr	x3,	[sp, #128]

    lsl	w14,	w5,	#2
    add	x21,	x3,	x14
    str	x21,	[sp, fp]

    movz	fp,	#148
    ldr	x22,	[sp, fp]

    ldr	w19,	[x22]

    cmp	w19,	#0
    ble	dfs_28

dfs_30:
    cmp	w27,	w19
    ldr	w3,	[sp, #124]

    csel	w22,	w27,	w19,	lt
    cmp	w3,	w25
    bne	dfs_34

dfs_75:
    mov	w0,	w22
    b	dfs_77

dfs_34:
    movz	w6,	#1
    adrp	x17, :got:size
    adrp	x3, :got:cap
    str	w6,	[x8]

    ldr	w4,	[sp, #124]

    ldr	x17, [x17, #:got_lo12:size]
    lsl	w1,	w4,	#2
    add	x15,	x17,	x1
    ldr	w19,	[x15]

    ldr	w5,	[sp, #124]

    ldr	w6,	[sp, #124]

    lsl	w13,	w5,	#3
    add	w26,	w13,	w6,	lsl #5
    adrp	x6, :got:to
    ldr	x6, [x6, #:got_lo12:to]
    ldr	w7,	[sp, #124]

    add	x20,	x6,	x26
    ldr	w8,	[sp, #124]

    lsl	w15,	w7,	#3
    movz	w6,	#0
    ldr	x3, [x3, #:got_lo12:cap]
    add	w10,	w15,	w8,	lsl #5
    str	w6,	[sp, #116]

    add	x26,	x3,	x10

dfs_39:
    ldr	w7,	[sp, #116]

    cmp	w7,	w19
    blt	dfs_42

dfs_76:
    movz	w0,	#0
    b	dfs_77

dfs_42:
    ldr	w8,	[sp, #116]

    lsl	w12,	w8,	#2
    add	x11,	x20,	x12
    ldr	w16,	[x11]

    str	w16,	[sp, #108]

    adrp	x16, :got:used
    ldr	w17,	[sp, #108]

    ldr	x16, [x16, #:got_lo12:used]
    lsl	w7,	w17,	#2
    add	x14,	x16,	x7
    ldr	w17,	[x14]

    cmp	w17,	#0
    bne	dfs_48

dfs_52:
    ldr	w9,	[sp, #116]

    movz	fp,	#140
    lsl	w0,	w9,	#2
    add	x6,	x26,	x0
    str	x6,	[sp, fp]

    movz	fp,	#140
    ldr	x7,	[sp, fp]

    ldr	w13,	[x7]

    cmp	w13,	#0
    ble	dfs_56

dfs_58:
    cmp	w22,	w13
    mov	w1,	w25
    ldr	w0,	[sp, #108]

    csel	w2,	w22,	w13,	lt
    bl	dfs
    cmp	w0,	#0
    bgt	dfs_63

dfs_73:
    ldr	w10,	[sp, #116]

    add	w14,	w10,	#1
    b	dfs_50

dfs_63:
    movz	fp,	#140
    ldr	x3,	[sp, fp]

    movz	fp,	#140
    ldr	w8,	[x3]

    adrp	x3, :got:rev
    sub	w9,	w8,	w0
    ldr	x19,	[sp, fp]

    str	w9,	[x19]

    adrp	x9, :got:cap
    ldr	w10,	[sp, #124]

    ldr	w11,	[sp, #124]

    lsl	w7,	w10,	#3
    ldr	x3, [x3, #:got_lo12:rev]
    add	w13,	w7,	w11,	lsl #5
    ldr	w12,	[sp, #116]

    lsl	w5,	w12,	#2
    add	x13,	x3,	x13
    add	x4,	x13,	x5
    ldr	w14,	[x4]

    lsl	w11,	w14,	#2
    ldr	w20,	[sp, #108]

    ldr	w21,	[sp, #108]

    lsl	w2,	w20,	#3
    ldr	x9, [x9, #:got_lo12:cap]
    add	w19,	w2,	w21,	lsl #5
    add	x18,	x9,	x19
    add	x18,	x18,	x11
    ldr	w12,	[x18]

    add	w13,	w12,	w0
    str	w13,	[x18]


dfs_77:
    cmp	w0,	#0
    ble	dfs_90

dfs_80:
    movz	fp,	#148
    adrp	x8, :got:cap
    ldr	x25,	[sp, fp]

    movz	fp,	#148
    ldr	w22,	[x25]

    sub	w24,	w22,	w0
    ldr	x2,	[sp, fp]

    str	w24,	[x2]

    ldr	w1,	[sp, #120]

    ldr	w2,	[sp, #120]

    lsl	w13,	w1,	#3
    add	w28,	w13,	w2,	lsl #5
    adrp	x2, :got:rev
    ldr	x2, [x2, #:got_lo12:rev]
    ldr	w5,	[sp, #112]

    add	x28,	x2,	x28
    lsl	w4,	w5,	#2
    add	x3,	x28,	x4
    ldr	w10,	[x3]

    lsl	w10,	w10,	#2
    ldr	w14,	[sp, #124]

    ldr	w15,	[sp, #124]

    lsl	w13,	w14,	#3
    ldr	x8, [x8, #:got_lo12:cap]
    add	w4,	w13,	w15,	lsl #5
    add	x3,	x8,	x4
    add	x25,	x3,	x10
    ldr	w11,	[x25]

    add	w12,	w11,	w0
    str	w12,	[x25]


dfs_94:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #160
    ret


dfs_90:
    ldr	w7,	[sp, #112]

    add	w4,	w7,	#1
    b	dfs_22

dfs_56:
    ldr	w12,	[sp, #116]

    add	w14,	w12,	#1
    b	dfs_50

dfs_48:
    ldr	w13,	[sp, #116]

    add	w14,	w13,	#1

dfs_50:
    str	w14,	[sp, #116]

    b	dfs_39

dfs_28:
    ldr	w8,	[sp, #112]

    add	w4,	w8,	#1
    b	dfs_22

dfs_20:
    ldr	w9,	[sp, #112]

    add	w4,	w9,	#1

dfs_22:
    str	w4,	[sp, #112]

    b	dfs_11

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #96
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w23,	w0
    bl	getint
    mov	w25,	w0
    movz	w2,	#0
    movz	w3,	#0
    movz	w4,	#0
    movz	w26,	#0
    adrp	x10, :got:size
    movz	w1,	#0
    movz	w24,	#0
    ldr	x10, [x10, #:got_lo12:size]
    add	x8,	x10,	#32
    add	x7,	x10,	#24
    add	x6,	x10,	#20
    add	x5,	x10,	#4
    str	w4,	[x10]

    add	x4,	x10,	#8
    str	w3,	[x5]

    add	x5,	x10,	#16
    add	x3,	x10,	#12
    str	w2,	[x4]

    movz	w2,	#0
    movz	w4,	#0
    str	w4,	[x3]

    movz	w3,	#0
    str	w3,	[x5]

    add	x3,	x10,	#36
    str	w2,	[x6]

    movz	w6,	#0
    str	w1,	[x7]

    add	x7,	x10,	#28
    str	w26,	[x7]

    str	w24,	[x8]

    str	w6,	[x3]


main_14:
    cmp	w25,	#0
    bgt	main_17

main_41:
    adrp	x20, :got:used
    movz	fp,	#76
    movz	w24,	#0
    ldr	x20, [x20, #:got_lo12:used]
    add	x7,	x20,	#32
    add	x6,	x20,	#36
    add	x10,	x20,	#28
    add	x13,	x20,	#20
    add	x22,	x20,	#16
    add	x12,	x20,	#12
    add	x1,	x20,	#24
    add	x19,	x20,	#8
    add	x27,	x20,	#4
    str	x20,	[sp, fp]

    movz	fp,	#60
    str	x27,	[sp, #32]

    str	x12,	[sp, #24]

    str	x13,	[sp, #16]

    str	x1,	[sp, fp]

    movz	fp,	#52
    str	x10,	[sp, #40]

    str	x7,	[sp, fp]

    movz	fp,	#68
    str	x6,	[sp, fp]

    str	w24,	[sp, #48]


main_53:
    movz	w1,	#0
    movz	fp,	#76
    movz	w0,	#0
    movz	w21,	#0
    movz	w2,	#0
    ldr	x26,	[sp, fp]

    movz	fp,	#60
    str	w1,	[x26]

    movz	w1,	#0
    ldr	x26,	[sp, #32]

    str	w0,	[x26]

    movz	w0,	#0
    str	w21,	[x19]

    ldr	x24,	[sp, #24]

    str	w2,	[x24]

    str	w1,	[x22]

    ldr	x21,	[sp, #16]

    str	w0,	[x21]

    movz	w0,	#0
    ldr	x2,	[sp, fp]

    movz	w21,	#0
    movz	fp,	#52
    str	w21,	[x2]

    ldr	x1,	[sp, #40]

    movz	w2,	#0
    str	w2,	[x1]

    movz	w2,	#0
    ldr	x27,	[sp, fp]

    movz	w1,	#0
    movk	w2,	#28672,	lsl #16
    movz	fp,	#68
    str	w1,	[x27]

    mov	w1,	w23
    ldr	x28,	[sp, fp]

    str	w0,	[x28]

    movz	w0,	#1
    bl	dfs
    cmp	w0,	#0
    bne	main_57

main_59:
    ldr	w0,	[sp, #48]

    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #96
    ret


main_57:
    ldr	w24,	[sp, #48]

    add	w27,	w0,	w24
    str	w27,	[sp, #48]

    b	main_53

main_17:
    bl	getint
    mov	w27,	w0
    bl	getint
    mov	w26,	w0
    bl	getint
    lsl	w10,	w26,	#2
    adrp	x7, :got:size
    lsl	w3,	w27,	#3
    sub	w25,	w25,	#1
    lsl	w2,	w27,	#2
    adrp	x1, :got:to
    adrp	x12, :got:size
    lsl	w13,	w26,	#3
    adrp	x19, :got:to
    movz	w6,	#0
    ldr	x7, [x7, #:got_lo12:size]
    add	w21,	w3,	w27,	lsl #5
    add	x15,	x7,	x2
    adrp	x2, :got:cap
    ldr	w18,	[x15]

    lsl	w9,	w18,	#2
    lsl	w5,	w18,	#2
    ldr	x1, [x1, #:got_lo12:to]
    add	x20,	x1,	x21
    add	x4,	x20,	x5
    lsl	w5,	w27,	#3
    str	w26,	[x4]

    add	w5,	w5,	w27,	lsl #5
    ldr	x2, [x2, #:got_lo12:cap]
    lsl	w4,	w27,	#3
    add	w8,	w4,	w27,	lsl #5
    lsl	w4,	w18,	#2
    add	x7,	x2,	x8
    add	x3,	x7,	x4
    adrp	x7, :got:rev
    str	w0,	[x3]

    ldr	x7, [x7, #:got_lo12:rev]
    ldr	x12, [x12, #:got_lo12:size]
    add	x4,	x7,	x5
    add	x28,	x12,	x10
    lsl	w7,	w26,	#3
    add	w5,	w13,	w26,	lsl #5
    add	x2,	x4,	x9
    adrp	x13, :got:rev
    ldr	w1,	[x28]

    lsl	w21,	w1,	#2
    str	w1,	[x2]

    ldr	x19, [x19, #:got_lo12:to]
    add	x4,	x19,	x5
    lsl	w19,	w1,	#2
    adrp	x5, :got:cap
    add	x20,	x4,	x21
    add	w21,	w18,	#1
    str	w27,	[x20]

    ldr	x5, [x5, #:got_lo12:cap]
    add	w27,	w7,	w26,	lsl #5
    lsl	w7,	w1,	#2
    add	x24,	x5,	x27
    add	x8,	x24,	x7
    str	w6,	[x8]

    ldr	x13, [x13, #:got_lo12:rev]
    lsl	w8,	w26,	#3
    add	w3,	w8,	w26,	lsl #5
    add	x2,	x13,	x3
    add	x16,	x2,	x19
    str	w18,	[x16]

    str	w21,	[x15]

    ldr	w10,	[x28]

    add	w11,	w10,	#1
    str	w11,	[x28]

    b	main_14

