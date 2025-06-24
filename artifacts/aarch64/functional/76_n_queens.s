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
    sub	sp, sp, #176
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	w8,	#1
    adrp	x12, :got:n
    str	w0,	[sp, #104]

    ldr	x12, [x12, #:got_lo12:n]
    ldr	w7,	[x12]

    str	w7,	[sp, #120]

    ldr	w5,	[sp, #120]

    cmp	w8,	w5
    bgt	f_98

f_4:
    ldr	w7,	[sp, #104]

    adrp	x16, :got:ans
    movz	fp,	#148
    adrp	x11, :got:ans
    lsl	w6,	w7,	#2
    ldr	x16, [x16, #:got_lo12:ans]
    add	x22,	x16,	x6
    movz	w6,	#1
    str	x22,	[sp, fp]

    movz	fp,	#124
    ldr	w8,	[sp, #104]

    add	w13,	w8,	#1
    str	w13,	[sp, #108]

    ldr	w14,	[sp, #108]

    ldr	x11, [x11, #:got_lo12:ans]
    lsl	w4,	w14,	#2
    add	x28,	x11,	x4
    str	x28,	[sp, fp]

    ldr	w15,	[sp, #108]

    str	w6,	[sp, #112]

    add	w28,	w15,	#1

f_10:
    ldr	w17,	[sp, #112]

    adrp	x25, :got:row
    movz	fp,	#140
    lsl	w2,	w17,	#2
    ldr	x25, [x25, #:got_lo12:row]
    add	x0,	x25,	x2
    str	x0,	[sp, fp]

    movz	fp,	#140
    ldr	x1,	[sp, fp]

    ldr	w0,	[x1]

    cmp	w0,	#1
    beq	f_93

f_15:
    ldr	w5,	[sp, #104]

    movz	fp,	#164
    ldr	w18,	[sp, #112]

    add	w2,	w18,	w5
    adrp	x5, :got:line1
    ldr	x5, [x5, #:got_lo12:line1]
    lsl	w10,	w2,	#2
    add	x5,	x5,	x10
    str	x5,	[sp, fp]

    movz	fp,	#164
    ldr	x6,	[sp, fp]

    ldr	w10,	[x6]

    cmp	w10,	#0
    bne	f_93

f_20:
    ldr	w6,	[sp, #104]

    adrp	x16, :got:line2
    ldr	w7,	[sp, #120]

    ldr	w19,	[sp, #112]

    add	w12,	w6,	w7
    ldr	x16, [x16, #:got_lo12:line2]
    sub	w13,	w12,	w19
    lsl	w6,	w13,	#2
    add	x25,	x16,	x6
    str	x25,	[sp, #96]

    ldr	x26,	[sp, #96]

    ldr	w17,	[x26]

    cmp	w17,	#0
    bne	f_93

f_26:
    ldr	w20,	[sp, #112]

    movz	fp,	#148
    ldr	x21,	[sp, fp]

    str	w20,	[x21]

    ldr	w7,	[sp, #104]

    ldr	w8,	[sp, #120]

    cmp	w7,	w8
    bne	f_43

f_28:
    adrp	x27, :got:sum
    adrp	x3, :got:sum
    ldr	x27, [x27, #:got_lo12:sum]
    ldr	w26,	[x27]

    movz	w27,	#1
    ldr	x3, [x3, #:got_lo12:sum]
    add	w14,	w26,	#1
    mov	w19,	w27
    str	w14,	[x3]


f_31:
    ldr	w8,	[sp, #120]

    cmp	w19,	w8
    bgt	f_43

f_34:
    lsl	w0,	w19,	#2
    adrp	x27, :got:ans
    ldr	x27, [x27, #:got_lo12:ans]
    add	x25,	x27,	x0
    ldr	w0,	[x25]

    bl	putint
    ldr	w9,	[sp, #120]

    cmp	w19,	w9
    beq	f_38

f_39:
    movz	w0,	#32
    bl	putch
    add	w27,	w19,	#1
    mov	w19,	w27
    b	f_31

f_38:
    movz	w0,	#10
    bl	putch

f_43:
    movz	w14,	#1
    movz	fp,	#140
    movz	w13,	#1
    movz	w12,	#1
    movz	w11,	#1
    ldr	x3,	[sp, fp]

    movz	fp,	#164
    str	w14,	[x3]

    ldr	x8,	[sp, fp]

    str	w13,	[x8]

    ldr	x26,	[sp, #96]

    str	w12,	[x26]

    ldr	w10,	[sp, #120]

    cmp	w11,	w10
    bgt	f_89

f_45:
    ldr	w12,	[sp, #108]

    movz	w26,	#1
    ldr	w11,	[sp, #120]

    add	w22,	w12,	w11
    str	w22,	[sp, #136]

    str	w26,	[sp, #116]


f_48:
    ldr	w25,	[sp, #116]

    adrp	x3, :got:row
    lsl	w12,	w25,	#2
    ldr	x3, [x3, #:got_lo12:row]
    add	x21,	x3,	x12
    ldr	w12,	[x21]

    cmp	w12,	#1
    beq	f_84

f_53:
    ldr	w13,	[sp, #108]

    adrp	x17, :got:line1
    ldr	w26,	[sp, #116]

    ldr	x17, [x17, #:got_lo12:line1]
    add	w14,	w26,	w13
    lsl	w10,	w14,	#2
    add	x26,	x17,	x10
    ldr	w12,	[x26]

    cmp	w12,	#0
    bne	f_84

f_58:
    ldr	w27,	[sp, #116]

    adrp	x17, :got:line2
    movz	fp,	#156
    ldr	w0,	[sp, #136]

    ldr	x17, [x17, #:got_lo12:line2]
    sub	w14,	w0,	w27
    lsl	w2,	w14,	#2
    add	x4,	x17,	x2
    str	x4,	[sp, fp]

    movz	fp,	#156
    ldr	x5,	[sp, fp]

    ldr	w4,	[x5]

    cmp	w4,	#0
    bne	f_84

f_63:
    ldr	w0,	[sp, #116]

    movz	fp,	#124
    ldr	x4,	[sp, fp]

    str	w0,	[x4]

    ldr	w14,	[sp, #108]

    ldr	w12,	[sp, #120]

    cmp	w14,	w12
    bne	f_80

f_65:
    adrp	x8, :got:sum
    adrp	x10, :got:sum
    ldr	x8, [x8, #:got_lo12:sum]
    ldr	w7,	[x8]

    movz	w8,	#1
    ldr	x10, [x10, #:got_lo12:sum]
    add	w2,	w7,	#1
    mov	w25,	w8
    str	w2,	[x10]


f_68:
    ldr	w13,	[sp, #120]

    cmp	w25,	w13
    bgt	f_80

f_71:
    lsl	w0,	w25,	#2
    adrp	x18, :got:ans
    ldr	x18, [x18, #:got_lo12:ans]
    add	x0,	x18,	x0
    ldr	w0,	[x0]

    bl	putint
    ldr	w14,	[sp, #120]

    cmp	w25,	w14
    beq	f_75

f_76:
    movz	w0,	#32
    bl	putch
    add	w17,	w25,	#1
    mov	w25,	w17
    b	f_68

f_75:
    movz	w0,	#10
    bl	putch

f_80:
    movz	w19,	#1
    movz	w24,	#1
    movz	w0,	#1
    movz	fp,	#156
    str	w19,	[x21]

    str	w24,	[x26]

    ldr	x20,	[sp, fp]

    str	w0,	[x20]

    mov	w0,	w28
    bl	f
    movz	fp,	#156
    movz	w3,	#0
    movz	w1,	#0
    movz	w11,	#0
    str	w11,	[x21]

    str	w1,	[x26]

    ldr	x15,	[sp, fp]

    str	w3,	[x15]


f_84:
    ldr	w1,	[sp, #116]

    ldr	w16,	[sp, #120]

    add	w4,	w1,	#1
    cmp	w4,	w16
    bgt	f_89

f_47:
    str	w4,	[sp, #116]

    b	f_48

f_89:
    movz	w5,	#0
    movz	fp,	#140
    movz	w26,	#0
    movz	w13,	#0
    ldr	x4,	[sp, fp]

    movz	fp,	#164
    str	w5,	[x4]

    ldr	x9,	[sp, fp]

    str	w26,	[x9]

    ldr	x27,	[sp, #96]

    str	w13,	[x27]


f_93:
    ldr	w21,	[sp, #112]

    ldr	w17,	[sp, #120]

    add	w12,	w21,	#1
    cmp	w12,	w17
    bgt	f_98

f_9:
    str	w12,	[sp, #112]

    b	f_10

f_98:
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


