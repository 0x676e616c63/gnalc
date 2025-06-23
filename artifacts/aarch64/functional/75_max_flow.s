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
    
    mov	w23,	w2
    mov	w25,	w1
    str	w0,	[sp, #116]

    ldr	w26,	[sp, #116]

    cmp	w26,	w25
    beq	dfs_92

dfs_5:
    ldr	w27,	[sp, #116]

    adrp	x20, :got:used
    movz	w4,	#1
    adrp	x5, :got:to
    movz	fp,	#164
    lsl	w14,	w27,	#2
    ldr	x20, [x20, #:got_lo12:used]
    adrp	x27, :got:size
    add	x18,	x20,	x14
    str	w4,	[x18]

    ldr	w0,	[sp, #116]

    ldr	x27, [x27, #:got_lo12:size]
    lsl	w17,	w0,	#2
    add	x16,	x27,	x17
    ldr	w19,	[x16]

    ldr	w21,	[sp, #116]

    ldr	w8,	[sp, #116]

    lsl	w9,	w21,	#3
    ldr	x5, [x5, #:got_lo12:to]
    add	w3,	w9,	w8,	lsl #5
    add	x5,	x5,	x3
    str	x5,	[sp, fp]

    ldr	w9,	[sp, #116]

    ldr	w3,	[sp, #116]

    lsl	w27,	w9,	#3
    add	w6,	w27,	w3,	lsl #5
    movz	w27,	#0
    adrp	x3, :got:cap
    ldr	x3, [x3, #:got_lo12:cap]
    add	x20,	x3,	x6
    str	x20,	[sp, #152]

    str	w27,	[sp, #108]


dfs_11:
    ldr	w9,	[sp, #108]

    cmp	w9,	w19
    bge	dfs_93

dfs_14:
    ldr	w10,	[sp, #108]

    movz	fp,	#164
    lsl	w1,	w10,	#2
    ldr	x22,	[sp, fp]

    add	x0,	x22,	x1
    ldr	w14,	[x0]

    str	w14,	[sp, #120]

    adrp	x14, :got:used
    ldr	w15,	[sp, #120]

    ldr	x14, [x14, #:got_lo12:used]
    lsl	w4,	w15,	#2
    add	x3,	x14,	x4
    ldr	w15,	[x3]

    cmp	w15,	#0
    beq	dfs_22

dfs_20:
    ldr	w11,	[sp, #108]

    add	w3,	w11,	#1
    b	dfs_90

dfs_22:
    ldr	w0,	[sp, #108]

    movz	fp,	#124
    ldr	x21,	[sp, #152]

    lsl	w20,	w0,	#2
    add	x14,	x21,	x20
    str	x14,	[sp, fp]

    movz	fp,	#124
    ldr	x15,	[sp, fp]

    ldr	w21,	[x15]

    cmp	w21,	#0
    bgt	dfs_28

dfs_26:
    ldr	w13,	[sp, #108]

    add	w3,	w13,	#1
    b	dfs_90

dfs_28:
    cmp	w23,	w21
    ldr	w8,	[sp, #120]

    csel	w27,	w23,	w21,	lt
    cmp	w8,	w25
    beq	dfs_73

dfs_32:
    movz	w8,	#1
    adrp	x10, :got:to
    str	w8,	[x3]

    ldr	w6,	[sp, #120]

    lsl	w3,	w6,	#2
    adrp	x6, :got:size
    ldr	x6, [x6, #:got_lo12:size]
    add	x2,	x6,	x3
    ldr	w24,	[x2]

    str	w24,	[sp, #160]

    ldr	w8,	[sp, #120]

    ldr	w4,	[sp, #120]

    lsl	w13,	w8,	#3
    ldr	x10, [x10, #:got_lo12:to]
    add	w1,	w13,	w4,	lsl #5
    adrp	x13, :got:cap
    add	x11,	x10,	x1
    str	x11,	[sp, #136]

    ldr	w10,	[sp, #120]

    ldr	w6,	[sp, #120]

    lsl	w14,	w10,	#3
    ldr	x13, [x13, #:got_lo12:cap]
    add	w4,	w14,	w6,	lsl #5
    movz	w6,	#0
    add	x10,	x13,	x4
    str	x10,	[sp, #96]

    str	w6,	[sp, #112]


dfs_37:
    ldr	w7,	[sp, #112]

    ldr	w14,	[sp, #160]

    cmp	w7,	w14
    bge	dfs_74

dfs_40:
    ldr	w8,	[sp, #112]

    ldr	x12,	[sp, #136]

    lsl	w15,	w8,	#2
    add	x13,	x12,	x15
    ldr	w13,	[x13]

    str	w13,	[sp, #104]

    ldr	w14,	[sp, #104]

    lsl	w9,	w14,	#2
    adrp	x14, :got:used
    ldr	x14, [x14, #:got_lo12:used]
    add	x8,	x14,	x9
    ldr	w11,	[x8]

    cmp	w11,	#0
    beq	dfs_48

dfs_46:
    ldr	w9,	[sp, #112]

    add	w14,	w9,	#1
    b	dfs_71

dfs_48:
    ldr	w10,	[sp, #112]

    ldr	x4,	[sp, #96]

    lsl	w15,	w10,	#2
    add	x14,	x4,	x15
    str	x14,	[sp, #144]

    ldr	x15,	[sp, #144]

    ldr	w16,	[x15]

    cmp	w16,	#0
    bgt	dfs_54

dfs_52:
    ldr	w11,	[sp, #112]

    add	w14,	w11,	#1
    b	dfs_71

dfs_54:
    cmp	w27,	w16
    mov	w1,	w25
    ldr	w0,	[sp, #104]

    csel	w2,	w27,	w16,	lt
    bl	dfs
    cmp	w0,	#0
    ble	dfs_69

dfs_59:
    ldr	x17,	[sp, #144]

    adrp	x3, :got:cap
    ldr	w13,	[x17]

    ldr	x18,	[sp, #144]

    sub	w14,	w13,	w0
    str	w14,	[x18]

    ldr	w13,	[sp, #120]

    ldr	w17,	[sp, #120]

    lsl	w10,	w13,	#3
    add	w16,	w10,	w17,	lsl #5
    adrp	x10, :got:rev
    ldr	x10, [x10, #:got_lo12:rev]
    ldr	w14,	[sp, #112]

    add	x15,	x10,	x16
    lsl	w24,	w14,	#2
    add	x11,	x15,	x24
    ldr	w13,	[x11]

    ldr	w21,	[sp, #104]

    ldr	w16,	[sp, #104]

    lsl	w11,	w21,	#3
    ldr	x3, [x3, #:got_lo12:cap]
    lsl	w21,	w13,	#2
    add	w17,	w11,	w16,	lsl #5
    add	x16,	x3,	x17
    add	x5,	x16,	x21
    ldr	w21,	[x5]

    add	w22,	w21,	w0
    str	w22,	[x5]

    b	dfs_75

dfs_69:
    ldr	w13,	[sp, #112]

    add	w14,	w13,	#1

dfs_71:
    str	w14,	[sp, #112]

    b	dfs_37

dfs_74:
    movz	w0,	#0
    b	dfs_75

dfs_73:
    mov	w0,	w27

dfs_75:
    cmp	w0,	#0
    bgt	dfs_78

dfs_88:
    ldr	w14,	[sp, #108]

    add	w3,	w14,	#1

dfs_90:
    str	w3,	[sp, #108]

    b	dfs_11

dfs_78:
    movz	fp,	#124
    adrp	x21, :got:rev
    adrp	x27, :got:cap
    ldr	x19,	[sp, fp]

    movz	fp,	#124
    ldr	w15,	[x19]

    sub	w16,	w15,	w0
    ldr	x20,	[sp, fp]

    str	w16,	[x20]

    ldr	w2,	[sp, #116]

    ldr	w8,	[sp, #116]

    lsl	w6,	w2,	#3
    ldr	x21, [x21, #:got_lo12:rev]
    add	w3,	w6,	w8,	lsl #5
    ldr	w14,	[sp, #108]

    lsl	w8,	w14,	#2
    add	x2,	x21,	x3
    add	x8,	x2,	x8
    ldr	w10,	[x8]

    lsl	w14,	w10,	#2
    ldr	w20,	[sp, #120]

    ldr	w18,	[sp, #120]

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
    mov	w0,	w23

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
    movz	w9,	#0
    movz	w7,	#0
    movz	w8,	#0
    adrp	x10, :got:size
    movz	w12,	#0
    movz	w6,	#0
    movz	w5,	#0
    ldr	x10, [x10, #:got_lo12:size]
    add	x11,	x10,	#32
    add	x3,	x10,	#12
    add	x2,	x10,	#8
    add	x4,	x10,	#4
    str	w12,	[x10]

    movz	w12,	#0
    str	w9,	[x4]

    add	x9,	x10,	#28
    add	x4,	x10,	#16
    str	w8,	[x2]

    movz	w2,	#0
    add	x8,	x10,	#24
    str	w7,	[x3]

    movz	w3,	#0
    add	x7,	x10,	#20
    str	w6,	[x4]

    movz	w4,	#0
    str	w5,	[x7]

    str	w4,	[x8]

    str	w3,	[x9]

    add	x3,	x10,	#36
    str	w2,	[x11]

    str	w12,	[x3]


main_14:
    cmp	w19,	#0
    ble	main_41

main_17:
    bl	getint
    mov	w21,	w0
    bl	getint
    mov	w26,	w0
    bl	getint
    lsl	w10,	w21,	#2
    lsl	w15,	w26,	#3
    adrp	x4, :got:to
    lsl	w9,	w21,	#3
    adrp	x16, :got:size
    adrp	x14, :got:rev
    movz	w1,	#0
    adrp	x8, :got:cap
    add	w7,	w9,	w21,	lsl #5
    ldr	x16, [x16, #:got_lo12:size]
    adrp	x9, :got:cap
    add	x18,	x16,	x10
    lsl	w10,	w21,	#3
    str	x18,	[sp, #32]

    ldr	x20,	[sp, #32]

    ldr	w11,	[x20]

    str	w11,	[sp, #88]

    ldr	x4, [x4, #:got_lo12:to]
    ldr	w20,	[sp, #88]

    add	x4,	x4,	x7
    lsl	w6,	w20,	#2
    adrp	x20, :got:size
    add	x5,	x4,	x6
    adrp	x4, :got:to
    add	w6,	w10,	w21,	lsl #5
    str	w26,	[x5]

    ldr	x9, [x9, #:got_lo12:cap]
    ldr	w22,	[sp, #88]

    add	x5,	x9,	x6
    lsl	w11,	w22,	#2
    add	x10,	x5,	x11
    lsl	w11,	w21,	#3
    str	w0,	[x10]

    add	w11,	w11,	w21,	lsl #5
    ldr	x14, [x14, #:got_lo12:rev]
    ldr	w24,	[sp, #88]

    add	x10,	x14,	x11
    ldr	x20, [x20, #:got_lo12:size]
    lsl	w16,	w24,	#2
    lsl	w24,	w26,	#3
    add	x9,	x10,	x16
    add	w13,	w24,	w26,	lsl #5
    lsl	w16,	w26,	#2
    add	x6,	x20,	x16
    lsl	w16,	w26,	#3
    ldr	w11,	[x6]

    add	w12,	w16,	w26,	lsl #5
    lsl	w2,	w11,	#2
    lsl	w10,	w11,	#2
    str	w11,	[x9]

    ldr	x4, [x4, #:got_lo12:to]
    add	x13,	x4,	x13
    add	w4,	w15,	w26,	lsl #5
    adrp	x26, :got:rev
    add	x7,	x13,	x2
    lsl	w2,	w11,	#2
    str	w21,	[x7]

    ldr	x8, [x8, #:got_lo12:cap]
    add	x3,	x8,	x4
    add	x9,	x3,	x10
    str	w1,	[x9]

    ldr	x26, [x26, #:got_lo12:rev]
    ldr	w17,	[sp, #88]

    add	x12,	x26,	x12
    add	x1,	x12,	x2
    str	w17,	[x1]

    sub	w1,	w19,	#1
    ldr	w25,	[sp, #88]

    mov	w19,	w1
    ldr	x24,	[sp, #32]

    add	w4,	w25,	#1
    str	w4,	[x24]

    ldr	w24,	[x6]

    add	w25,	w24,	#1
    str	w25,	[x6]

    b	main_14

main_41:
    adrp	x15, :got:used
    movz	w8,	#0
    ldr	x15, [x15, #:got_lo12:used]
    add	x24,	x15,	#28
    add	x18,	x15,	#36
    add	x12,	x15,	#12
    add	x19,	x15,	#32
    add	x4,	x15,	#8
    add	x9,	x15,	#20
    add	x16,	x15,	#4
    mov	x21,	x15
    str	x16,	[sp, #64]

    add	x16,	x15,	#24
    str	x4,	[sp, #96]

    str	x12,	[sp, #80]

    add	x12,	x15,	#16
    str	x12,	[sp, #48]

    str	x9,	[sp, #56]

    str	x16,	[sp, #40]

    str	x24,	[sp, #24]

    str	x19,	[sp, #16]

    str	x18,	[sp, #72]

    str	w8,	[sp, #92]


main_53:
    movz	w2,	#0
    movz	w1,	#0
    movz	w0,	#0
    movz	w24,	#0
    str	w2,	[x21]

    ldr	x2,	[sp, #64]

    str	w1,	[x2]

    movz	w1,	#0
    movz	w2,	#0
    ldr	x19,	[sp, #96]

    str	w0,	[x19]

    movz	w0,	#0
    ldr	x20,	[sp, #80]

    str	w24,	[x20]

    ldr	x27,	[sp, #48]

    str	w2,	[x27]

    movz	w2,	#0
    ldr	x24,	[sp, #56]

    str	w1,	[x24]

    movz	w1,	#0
    movz	w24,	#0
    ldr	x26,	[sp, #40]

    str	w0,	[x26]

    ldr	x18,	[sp, #24]

    str	w24,	[x18]

    ldr	x0,	[sp, #16]

    str	w2,	[x0]

    movz	w0,	#1
    movz	w2,	#0
    ldr	x20,	[sp, #72]

    movk	w2,	#28672,	lsl #16
    str	w1,	[x20]

    mov	w1,	w23
    bl	dfs
    cmp	w0,	#0
    beq	main_59

main_57:
    ldr	w9,	[sp, #92]

    add	w10,	w0,	w9
    str	w10,	[sp, #92]

    b	main_53

main_59:
    ldr	w0,	[sp, #92]

    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #112
    ret


