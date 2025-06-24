.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global ans
.align	2
ans:
    .zero	200

.global sum
.align	2
sum:
    .zero	4

.global n
.align	2
n:
    .zero	4

.global row
.align	2
row:
    .zero	200

.global line1
.align	2
line1:
    .zero	200

.global line2
.align	2
line2:
    .zero	400


.text

.globl f
f:
f_1:
    sub	sp, sp, #192
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	w2,	#1
    adrp	x3, :got:n
    str	w0,	[sp, #104]

    ldr	x3, [x3, #:got_lo12:n]
    ldr	w7,	[x3]

    str	w7,	[sp, #120]

    ldr	w7,	[sp, #120]

    cmp	w2,	w7
    bgt	f_98

f_4:
    ldr	w7,	[sp, #104]

    adrp	x15, :got:ans
    adrp	x19, :got:ans
    lsl	w0,	w7,	#2
    ldr	x15, [x15, #:got_lo12:ans]
    add	x27,	x15,	x0
    str	x27,	[sp, #136]

    ldr	w8,	[sp, #104]

    add	w13,	w8,	#1
    str	w13,	[sp, #108]

    ldr	w14,	[sp, #108]

    ldr	x19, [x19, #:got_lo12:ans]
    lsl	w4,	w14,	#2
    add	x6,	x19,	x4
    str	x6,	[sp, #168]

    ldr	w15,	[sp, #108]

    add	w19,	w15,	#1
    movz	w15,	#1
    str	w15,	[sp, #112]


f_10:
    ldr	w17,	[sp, #112]

    adrp	x4, :got:row
    lsl	w2,	w17,	#2
    ldr	x4, [x4, #:got_lo12:row]
    add	x7,	x4,	x2
    str	x7,	[sp, #144]

    ldr	x8,	[sp, #144]

    ldr	w0,	[x8]

    cmp	w0,	#1
    beq	f_93

f_15:
    ldr	w4,	[sp, #104]

    adrp	x11, :got:line1
    ldr	w18,	[sp, #112]

    ldr	x11, [x11, #:got_lo12:line1]
    add	w2,	w18,	w4
    lsl	w4,	w2,	#2
    add	x28,	x11,	x4
    str	x28,	[sp, #160]

    ldr	x0,	[sp, #160]

    ldr	w6,	[x0]

    cmp	w6,	#0
    bne	f_93

f_20:
    ldr	w5,	[sp, #104]

    adrp	x18, :got:line2
    movz	fp,	#124
    ldr	w6,	[sp, #120]

    ldr	w21,	[sp, #112]

    add	w8,	w5,	w6
    ldr	x18, [x18, #:got_lo12:line2]
    sub	w9,	w8,	w21
    lsl	w11,	w9,	#2
    add	x20,	x18,	x11
    str	x20,	[sp, fp]

    movz	fp,	#124
    ldr	x21,	[sp, fp]

    ldr	w13,	[x21]

    cmp	w13,	#0
    bne	f_93

f_26:
    ldr	w22,	[sp, #112]

    ldr	x26,	[sp, #136]

    str	w22,	[x26]

    ldr	w6,	[sp, #104]

    ldr	w7,	[sp, #120]

    cmp	w6,	w7
    bne	f_43

f_28:
    adrp	x17, :got:sum
    adrp	x4, :got:sum
    movz	w2,	#1
    ldr	x17, [x17, #:got_lo12:sum]
    mov	w26,	w2
    ldr	w16,	[x17]

    ldr	x4, [x4, #:got_lo12:sum]
    add	w18,	w16,	#1
    str	w18,	[x4]


f_31:
    ldr	w8,	[sp, #120]

    cmp	w26,	w8
    bgt	f_43

f_34:
    lsl	w21,	w26,	#2
    adrp	x22, :got:ans
    ldr	x22, [x22, #:got_lo12:ans]
    add	x22,	x22,	x21
    ldr	w0,	[x22]

    bl	putint
    ldr	w9,	[sp, #120]

    cmp	w26,	w9
    beq	f_38

f_39:
    movz	w0,	#32
    bl	putch
    add	w2,	w26,	#1
    mov	w26,	w2
    b	f_31

f_38:
    movz	w0,	#10
    bl	putch

f_43:
    movz	w0,	#1
    ldr	x11,	[sp, #144]

    movz	w3,	#1
    movz	fp,	#124
    movz	w1,	#1
    str	w0,	[x11]

    ldr	x2,	[sp, #160]

    str	w3,	[x2]

    ldr	x23,	[sp, fp]

    movz	w2,	#1
    str	w2,	[x23]

    ldr	w11,	[sp, #120]

    cmp	w1,	w11
    bgt	f_89

f_45:
    ldr	w13,	[sp, #108]

    movz	w14,	#1
    ldr	w11,	[sp, #120]

    str	w14,	[sp, #116]

    add	w20,	w13,	w11

f_48:
    ldr	w28,	[sp, #116]

    adrp	x13, :got:row
    lsl	w2,	w28,	#2
    ldr	x13, [x13, #:got_lo12:row]
    add	x18,	x13,	x2
    str	x18,	[sp, #176]

    ldr	x21,	[sp, #176]

    ldr	w12,	[x21]

    cmp	w12,	#1
    beq	f_84

f_53:
    ldr	w12,	[sp, #108]

    adrp	x11, :got:line1
    ldr	w16,	[sp, #116]

    ldr	x11, [x11, #:got_lo12:line1]
    add	w14,	w16,	w12
    lsl	w16,	w14,	#2
    add	x13,	x11,	x16
    str	x13,	[sp, #96]

    ldr	x14,	[sp, #96]

    ldr	w18,	[x14]

    cmp	w18,	#0
    bne	f_84

f_58:
    ldr	w17,	[sp, #116]

    adrp	x21, :got:line2
    sub	w3,	w20,	w17
    ldr	x21, [x21, #:got_lo12:line2]
    lsl	w0,	w3,	#2
    add	x12,	x21,	x0
    str	x12,	[sp, #152]

    ldr	x13,	[sp, #152]

    ldr	w2,	[x13]

    cmp	w2,	#0
    bne	f_84

f_63:
    ldr	w21,	[sp, #116]

    ldr	x5,	[sp, #168]

    str	w21,	[x5]

    ldr	w15,	[sp, #108]

    ldr	w4,	[sp, #120]

    cmp	w15,	w4
    bne	f_80

f_65:
    adrp	x6, :got:sum
    adrp	x3, :got:sum
    movz	w22,	#1
    ldr	x6, [x6, #:got_lo12:sum]
    mov	w21,	w22
    ldr	w5,	[x6]

    ldr	x3, [x3, #:got_lo12:sum]
    add	w7,	w5,	#1
    str	w7,	[x3]


f_68:
    ldr	w15,	[sp, #120]

    cmp	w21,	w15
    bgt	f_80

f_71:
    lsl	w26,	w21,	#2
    adrp	x0, :got:ans
    ldr	x0, [x0, #:got_lo12:ans]
    add	x22,	x0,	x26
    ldr	w0,	[x22]

    bl	putint
    ldr	w16,	[sp, #120]

    cmp	w21,	w16
    beq	f_75

f_76:
    movz	w0,	#32
    bl	putch
    add	w22,	w21,	#1
    mov	w21,	w22
    b	f_68

f_75:
    movz	w0,	#10
    bl	putch

f_80:
    movz	w0,	#1
    ldr	x28,	[sp, #176]

    movz	w22,	#1
    str	w0,	[x28]

    movz	w0,	#1
    ldr	x24,	[sp, #96]

    str	w22,	[x24]

    ldr	x26,	[sp, #152]

    str	w0,	[x26]

    mov	w0,	w19
    bl	f
    movz	w15,	#0
    ldr	x14,	[sp, #176]

    movz	w16,	#0
    str	w16,	[x14]

    movz	w14,	#0
    ldr	x18,	[sp, #96]

    str	w15,	[x18]

    ldr	x17,	[sp, #152]

    str	w14,	[x17]


f_84:
    ldr	w1,	[sp, #116]

    ldr	w7,	[sp, #120]

    add	w26,	w1,	#1
    cmp	w26,	w7
    bgt	f_89

f_47:
    str	w26,	[sp, #116]

    b	f_48

f_89:
    movz	w15,	#0
    ldr	x11,	[sp, #144]

    movz	w14,	#0
    movz	w13,	#0
    movz	fp,	#124
    str	w15,	[x11]

    ldr	x3,	[sp, #160]

    str	w14,	[x3]

    ldr	x24,	[sp, fp]

    str	w13,	[x24]


f_93:
    ldr	w23,	[sp, #112]

    ldr	w16,	[sp, #120]

    add	w23,	w23,	#1
    cmp	w23,	w16
    bgt	f_98

f_9:
    str	w23,	[sp, #112]

    b	f_10

f_98:
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
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w21,	w0

main_2:
    cmp	w21,	#0
    ble	main_8

main_5:
    bl	getint
    adrp	x25, :got:n
    ldr	x25, [x25, #:got_lo12:n]
    str	w0,	[x25]

    movz	w0,	#1
    bl	f
    sub	w21,	w21,	#1
    b	main_2

main_8:
    adrp	x7, :got:sum
    ldr	x7, [x7, #:got_lo12:sum]
    ldr	w0,	[x7]

    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


