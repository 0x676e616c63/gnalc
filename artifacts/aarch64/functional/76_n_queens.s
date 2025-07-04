.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global ans
.align	2
ans:
.type ans, %object
    .zero	200

.global sum
.align	2
sum:
.type sum, %object
    .zero	4

.global n
.align	2
n:
.type n, %object
    .zero	4

.global row
.align	2
row:
.type row, %object
    .zero	200

.global line1
.align	2
line1:
.type line1, %object
    .zero	200

.global line2
.align	2
line2:
.type line2, %object
    .zero	400

.data

.text

.globl f
.align 2
.p2align 4,,11
.type f, %function
f:
f_1:
    sub	sp, sp, #192
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	w8,	#1
    adrp	x12, :got:n
    str	w0,	[sp, #96]

    ldr	x12, [x12, #:got_lo12:n]
    ldr	w5,	[x12]

    str	w5,	[sp, #116]

    ldr	w3,	[sp, #116]

    cmp	w8,	w3
    bgt	f_98

f_4:
    ldr	w5,	[sp, #96]

    adrp	x16, :got:ans
    lsl	w6,	w5,	#2
    ldr	x16, [x16, #:got_lo12:ans]
    add	x5,	x16,	x6
    str	x5,	[sp, #136]

    ldr	w6,	[sp, #96]

    add	w11,	w6,	#1
    str	w11,	[sp, #104]

    adrp	x11, :got:ans
    ldr	w12,	[sp, #104]

    ldr	x11, [x11, #:got_lo12:ans]
    lsl	w4,	w12,	#2
    add	x20,	x11,	x4
    str	x20,	[sp, #176]

    ldr	w13,	[sp, #104]

    add	w22,	w13,	#1
    movz	w13,	#1
    str	w13,	[sp, #108]


f_10:
    ldr	w15,	[sp, #108]

    adrp	x23, :got:row
    movz	fp,	#124
    lsl	w0,	w15,	#2
    ldr	x23, [x23, #:got_lo12:row]
    add	x21,	x23,	x0
    str	x21,	[sp, fp]

    movz	fp,	#124
    ldr	x23,	[sp, fp]

    ldr	w0,	[x23]

    cmp	w0,	#1
    beq	f_93

f_15:
    ldr	w3,	[sp, #96]

    adrp	x5, :got:line1
    ldr	w16,	[sp, #108]

    ldr	x5, [x5, #:got_lo12:line1]
    add	w2,	w16,	w3
    lsl	w10,	w2,	#2
    add	x27,	x5,	x10
    str	x27,	[sp, #168]

    ldr	x28,	[sp, #168]

    ldr	w10,	[x28]

    cmp	w10,	#0
    bne	f_93

f_20:
    ldr	w4,	[sp, #96]

    adrp	x16, :got:line2
    ldr	w5,	[sp, #116]

    ldr	w17,	[sp, #108]

    add	w12,	w4,	w5
    ldr	x16, [x16, #:got_lo12:line2]
    sub	w13,	w12,	w17
    lsl	w6,	w13,	#2
    add	x16,	x16,	x6
    str	x16,	[sp, #152]

    ldr	x17,	[sp, #152]

    ldr	w8,	[x17]

    cmp	w8,	#0
    bne	f_93

f_26:
    ldr	w18,	[sp, #108]

    ldr	x5,	[sp, #136]

    str	w18,	[x5]

    ldr	w5,	[sp, #96]

    ldr	w6,	[sp, #116]

    cmp	w5,	w6
    bne	f_43

f_28:
    adrp	x12, :got:sum
    adrp	x14, :got:sum
    movz	w27,	#1
    ldr	x12, [x12, #:got_lo12:sum]
    mov	w25,	w27
    ldr	w11,	[x12]

    ldr	x14, [x14, #:got_lo12:sum]
    add	w28,	w11,	#1
    str	w28,	[x14]


f_31:
    ldr	w6,	[sp, #116]

    cmp	w25,	w6
    bgt	f_43

f_34:
    lsl	w23,	w25,	#2
    adrp	x0, :got:ans
    ldr	x0, [x0, #:got_lo12:ans]
    add	x19,	x0,	x23
    ldr	w0,	[x19]

    bl	putint
    ldr	w7,	[sp, #116]

    cmp	w25,	w7
    bne	f_39

f_38:
    movz	w0,	#10
    bl	putch

f_43:
    movz	w7,	#1
    movz	fp,	#124
    movz	w6,	#1
    movz	w5,	#1
    movz	w4,	#1
    ldr	x25,	[sp, fp]

    str	w7,	[x25]

    ldr	x1,	[sp, #168]

    str	w6,	[x1]

    ldr	x20,	[sp, #152]

    str	w5,	[x20]

    ldr	w9,	[sp, #116]

    cmp	w4,	w9
    bgt	f_89

f_45:
    ldr	w10,	[sp, #104]

    movz	w12,	#1
    ldr	w9,	[sp, #116]

    add	w26,	w10,	w9
    str	w26,	[sp, #100]

    str	w12,	[sp, #112]


f_48:
    ldr	w24,	[sp, #112]

    adrp	x2, :got:row
    lsl	w11,	w24,	#2
    ldr	x2, [x2, #:got_lo12:row]
    add	x26,	x2,	x11
    ldr	w11,	[x26]

    cmp	w11,	#1
    beq	f_84

f_53:
    ldr	w11,	[sp, #104]

    adrp	x16, :got:line1
    ldr	w25,	[sp, #112]

    ldr	x16, [x16, #:got_lo12:line1]
    add	w13,	w25,	w11
    lsl	w9,	w13,	#2
    add	x12,	x16,	x9
    str	x12,	[sp, #160]

    ldr	x13,	[sp, #160]

    ldr	w11,	[x13]

    cmp	w11,	#0
    bne	f_84

f_58:
    ldr	w27,	[sp, #100]

    adrp	x16, :got:line2
    ldr	w25,	[sp, #112]

    ldr	x16, [x16, #:got_lo12:line2]
    sub	w13,	w27,	w25
    lsl	w1,	w13,	#2
    add	x7,	x16,	x1
    str	x7,	[sp, #144]

    ldr	x8,	[sp, #144]

    ldr	w3,	[x8]

    cmp	w3,	#0
    bne	f_84

f_63:
    ldr	w27,	[sp, #112]

    ldr	x10,	[sp, #176]

    str	w27,	[x10]

    ldr	w12,	[sp, #104]

    ldr	w10,	[sp, #116]

    cmp	w12,	w10
    bne	f_80

f_65:
    adrp	x7, :got:sum
    adrp	x9, :got:sum
    ldr	x7, [x7, #:got_lo12:sum]
    ldr	w6,	[x7]

    movz	w7,	#1
    ldr	x9, [x9, #:got_lo12:sum]
    add	w1,	w6,	#1
    mov	w19,	w7
    str	w1,	[x9]


f_68:
    ldr	w11,	[sp, #116]

    cmp	w19,	w11
    bgt	f_80

f_71:
    lsl	w0,	w19,	#2
    adrp	x18, :got:ans
    ldr	x18, [x18, #:got_lo12:ans]
    add	x25,	x18,	x0
    ldr	w0,	[x25]

    bl	putint
    ldr	w12,	[sp, #116]

    cmp	w19,	w12
    bne	f_76

f_75:
    movz	w0,	#10
    bl	putch

f_80:
    movz	w0,	#1
    movz	w19,	#1
    str	w0,	[x26]

    ldr	x21,	[sp, #160]

    movz	w0,	#1
    str	w0,	[x21]

    mov	w0,	w22
    ldr	x27,	[sp, #144]

    str	w19,	[x27]

    bl	f
    movz	w1,	#0
    movz	w0,	#0
    movz	w9,	#0
    str	w9,	[x26]

    ldr	x16,	[sp, #160]

    str	w0,	[x16]

    ldr	x11,	[sp, #144]

    str	w1,	[x11]


f_84:
    ldr	w28,	[sp, #112]

    ldr	w13,	[sp, #116]

    add	w18,	w28,	#1
    cmp	w18,	w13
    ble	f_47

f_89:
    movz	w27,	#0
    movz	fp,	#124
    movz	w2,	#0
    movz	w18,	#0
    ldr	x25,	[sp, fp]

    str	w27,	[x25]

    ldr	x3,	[sp, #168]

    str	w2,	[x3]

    ldr	x21,	[sp, #152]

    str	w18,	[x21]


f_93:
    ldr	w19,	[sp, #108]

    ldr	w14,	[sp, #116]

    add	w19,	w19,	#1
    cmp	w19,	w14
    ble	f_9

f_98:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #192
    ret


f_9:
    str	w19,	[sp, #108]

    b	f_10

f_47:
    str	w18,	[sp, #112]

    b	f_48

f_76:
    movz	w0,	#32
    bl	putch
    add	w0,	w19,	#1
    mov	w19,	w0
    b	f_68

f_39:
    movz	w0,	#32
    bl	putch
    add	w25,	w25,	#1
    b	f_31

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w21,	w0

main_2:
    cmp	w21,	#0
    bgt	main_5

main_8:
    adrp	x4, :got:sum
    ldr	x4, [x4, #:got_lo12:sum]
    ldr	w0,	[x4]

    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_5:
    bl	getint
    adrp	x27, :got:n
    ldr	x27, [x27, #:got_lo12:n]
    str	w0,	[x27]

    movz	w0,	#1
    bl	f
    sub	w21,	w21,	#1
    b	main_2

