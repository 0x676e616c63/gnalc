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
    ldr	w5,	[x3]

    str	w5,	[sp, #120]

    ldr	w5,	[sp, #120]

    cmp	w2,	w5
    bgt	f_98

f_4:
    ldr	w5,	[sp, #104]

    adrp	x15, :got:ans
    lsl	w0,	w5,	#2
    ldr	x15, [x15, #:got_lo12:ans]
    add	x19,	x15,	x0
    str	x19,	[sp, #152]

    adrp	x19, :got:ans
    ldr	w6,	[sp, #104]

    add	w11,	w6,	#1
    str	w11,	[sp, #108]

    ldr	w12,	[sp, #108]

    ldr	x19, [x19, #:got_lo12:ans]
    lsl	w4,	w12,	#2
    add	x1,	x19,	x4
    str	x1,	[sp, #96]

    ldr	w13,	[sp, #108]

    add	w19,	w13,	#1
    movz	w13,	#1
    str	w13,	[sp, #112]


f_10:
    ldr	w15,	[sp, #112]

    adrp	x4, :got:row
    movz	fp,	#164
    lsl	w2,	w15,	#2
    ldr	x4, [x4, #:got_lo12:row]
    add	x2,	x4,	x2
    str	x2,	[sp, fp]

    movz	fp,	#164
    ldr	x3,	[sp, fp]

    ldr	w0,	[x3]

    cmp	w0,	#1
    beq	f_93

f_15:
    ldr	w2,	[sp, #104]

    adrp	x11, :got:line1
    ldr	w16,	[sp, #112]

    ldr	x11, [x11, #:got_lo12:line1]
    add	w2,	w16,	w2
    lsl	w4,	w2,	#2
    add	x21,	x11,	x4
    str	x21,	[sp, #144]

    ldr	x22,	[sp, #144]

    ldr	w6,	[x22]

    cmp	w6,	#0
    bne	f_93

f_20:
    ldr	w3,	[sp, #104]

    movz	fp,	#124
    ldr	w4,	[sp, #120]

    ldr	w18,	[sp, #112]

    add	w8,	w3,	w4
    sub	w9,	w8,	w18
    adrp	x18, :got:line2
    ldr	x18, [x18, #:got_lo12:line2]
    lsl	w11,	w9,	#2
    add	x26,	x18,	x11
    str	x26,	[sp, fp]

    movz	fp,	#124
    ldr	x27,	[sp, fp]

    ldr	w13,	[x27]

    cmp	w13,	#0
    bne	f_93

f_26:
    ldr	w20,	[sp, #112]

    ldr	x17,	[sp, #152]

    str	w20,	[x17]

    ldr	w4,	[sp, #104]

    ldr	w5,	[sp, #120]

    cmp	w4,	w5
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
    ldr	w6,	[sp, #120]

    cmp	w26,	w6
    bgt	f_43

f_34:
    lsl	w21,	w26,	#2
    adrp	x22, :got:ans
    ldr	x22, [x22, #:got_lo12:ans]
    add	x22,	x22,	x21
    ldr	w0,	[x22]

    bl	putint
    ldr	w7,	[sp, #120]

    cmp	w26,	w7
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
    movz	fp,	#164
    movz	w3,	#1
    movz	w2,	#1
    movz	w1,	#1
    ldr	x6,	[sp, fp]

    movz	fp,	#124
    str	w0,	[x6]

    ldr	x24,	[sp, #144]

    str	w3,	[x24]

    ldr	x0,	[sp, fp]

    str	w2,	[x0]

    ldr	w9,	[sp, #120]

    cmp	w1,	w9
    bgt	f_89

f_45:
    ldr	w11,	[sp, #108]

    movz	w12,	#1
    ldr	w9,	[sp, #120]

    add	w7,	w11,	w9
    str	w7,	[sp, #132]

    str	w12,	[sp, #116]


f_48:
    ldr	w25,	[sp, #116]

    adrp	x3, :got:row
    movz	fp,	#172
    lsl	w10,	w25,	#2
    ldr	x3, [x3, #:got_lo12:row]
    add	x15,	x3,	x10
    str	x15,	[sp, fp]

    movz	fp,	#172
    ldr	x16,	[sp, fp]

    ldr	w4,	[x16]

    cmp	w4,	#1
    beq	f_84

f_53:
    ldr	w1,	[sp, #108]

    adrp	x20, :got:line1
    ldr	w25,	[sp, #116]

    ldr	x20, [x20, #:got_lo12:line1]
    add	w6,	w25,	w1
    lsl	w8,	w6,	#2
    add	x28,	x20,	x8
    ldr	w18,	[x28]

    cmp	w18,	#0
    bne	f_84

f_58:
    ldr	w16,	[sp, #116]

    adrp	x20, :got:line2
    ldr	w8,	[sp, #132]

    ldr	x20, [x20, #:got_lo12:line2]
    sub	w3,	w8,	w16
    lsl	w0,	w3,	#2
    add	x10,	x20,	x0
    str	x10,	[sp, #136]

    ldr	x11,	[sp, #136]

    ldr	w2,	[x11]

    cmp	w2,	#0
    bne	f_84

f_63:
    ldr	x26,	[sp, #96]

    ldr	w16,	[sp, #116]

    str	w16,	[x26]

    ldr	w13,	[sp, #108]

    ldr	w2,	[sp, #120]

    cmp	w13,	w2
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
    ldr	w13,	[sp, #120]

    cmp	w21,	w13
    bgt	f_80

f_71:
    lsl	w22,	w21,	#2
    adrp	x0, :got:ans
    ldr	x0, [x0, #:got_lo12:ans]
    add	x20,	x0,	x22
    ldr	w0,	[x20]

    bl	putint
    ldr	w14,	[sp, #120]

    cmp	w21,	w14
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
    movz	fp,	#172
    movz	w22,	#1
    ldr	x26,	[sp, fp]

    str	w0,	[x26]

    movz	w0,	#1
    str	w22,	[x28]

    ldr	x23,	[sp, #136]

    str	w0,	[x23]

    mov	w0,	w19
    bl	f
    movz	w14,	#0
    movz	w15,	#0
    movz	fp,	#172
    movz	w16,	#0
    ldr	x12,	[sp, fp]

    str	w16,	[x12]

    str	w15,	[x28]

    ldr	x15,	[sp, #136]

    str	w14,	[x15]


f_84:
    ldr	w0,	[sp, #116]

    ldr	w13,	[sp, #120]

    add	w18,	w0,	#1
    cmp	w18,	w13
    bgt	f_89

f_47:
    str	w18,	[sp, #116]

    b	f_48

f_89:
    movz	w15,	#0
    movz	fp,	#164
    movz	w14,	#0
    movz	w13,	#0
    ldr	x6,	[sp, fp]

    movz	fp,	#124
    str	w15,	[x6]

    ldr	x25,	[sp, #144]

    str	w14,	[x25]

    ldr	x1,	[sp, fp]

    str	w13,	[x1]


f_93:
    ldr	w20,	[sp, #112]

    ldr	w14,	[sp, #120]

    add	w20,	w20,	#1
    cmp	w20,	w14
    bgt	f_98

f_9:
    str	w20,	[sp, #112]

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


