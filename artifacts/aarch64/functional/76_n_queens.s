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

    str	w7,	[sp, #128]

    ldr	w5,	[sp, #128]

    cmp	w8,	w5
    bgt	f_98

f_4:
    ldr	w7,	[sp, #104]

    adrp	x16, :got:ans
    adrp	x11, :got:ans
    lsl	w6,	w7,	#2
    ldr	x16, [x16, #:got_lo12:ans]
    add	x27,	x16,	x6
    movz	w6,	#1
    str	x27,	[sp, #144]

    ldr	w8,	[sp, #104]

    add	w13,	w8,	#1
    str	w13,	[sp, #108]

    ldr	w14,	[sp, #108]

    ldr	x11, [x11, #:got_lo12:ans]
    lsl	w4,	w14,	#2
    add	x1,	x11,	x4
    str	x1,	[sp, #168]

    ldr	w15,	[sp, #108]

    str	w6,	[sp, #112]

    add	w19,	w15,	#1

f_10:
    ldr	w17,	[sp, #112]

    adrp	x26, :got:row
    lsl	w2,	w17,	#2
    ldr	x26, [x26, #:got_lo12:row]
    add	x12,	x26,	x2
    str	x12,	[sp, #160]

    ldr	x13,	[sp, #160]

    ldr	w0,	[x13]

    cmp	w0,	#1
    beq	f_93

f_15:
    ldr	w5,	[sp, #104]

    ldr	w18,	[sp, #112]

    add	w2,	w18,	w5
    adrp	x5, :got:line1
    ldr	x5, [x5, #:got_lo12:line1]
    lsl	w10,	w2,	#2
    add	x18,	x5,	x10
    str	x18,	[sp, #120]

    ldr	x20,	[sp, #120]

    ldr	w10,	[x20]

    cmp	w10,	#0
    bne	f_93

f_20:
    ldr	w6,	[sp, #104]

    adrp	x16, :got:line2
    ldr	w7,	[sp, #128]

    ldr	w20,	[sp, #112]

    add	w12,	w6,	w7
    ldr	x16, [x16, #:got_lo12:line2]
    sub	w13,	w12,	w20
    lsl	w6,	w13,	#2
    add	x7,	x16,	x6
    str	x7,	[sp, #152]

    ldr	x8,	[sp, #152]

    ldr	w8,	[x8]

    cmp	w8,	#0
    bne	f_93

f_26:
    ldr	w21,	[sp, #112]

    ldr	x27,	[sp, #144]

    str	w21,	[x27]

    ldr	w7,	[sp, #104]

    ldr	w8,	[sp, #128]

    cmp	w7,	w8
    bne	f_43

f_28:
    adrp	x12, :got:sum
    adrp	x14, :got:sum
    movz	w27,	#1
    ldr	x12, [x12, #:got_lo12:sum]
    ldr	w11,	[x12]

    ldr	x14, [x14, #:got_lo12:sum]
    add	w28,	w11,	#1
    str	w28,	[x14]

    mov	w28,	w27

f_31:
    ldr	w8,	[sp, #128]

    cmp	w28,	w8
    bgt	f_43

f_34:
    lsl	w26,	w28,	#2
    adrp	x25, :got:ans
    ldr	x25, [x25, #:got_lo12:ans]
    add	x25,	x25,	x26
    ldr	w0,	[x25]

    bl	putint
    ldr	w9,	[sp, #128]

    cmp	w28,	w9
    beq	f_38

f_39:
    movz	w0,	#32
    bl	putch
    add	w27,	w28,	#1
    mov	w28,	w27
    b	f_31

f_38:
    movz	w0,	#10
    bl	putch

f_43:
    movz	w8,	#1
    ldr	x16,	[sp, #160]

    movz	w7,	#1
    movz	w6,	#1
    movz	w5,	#1
    str	w8,	[x16]

    ldr	x22,	[sp, #120]

    str	w7,	[x22]

    ldr	x11,	[sp, #152]

    str	w6,	[x11]

    ldr	w11,	[sp, #128]

    cmp	w5,	w11
    bgt	f_89

f_45:
    ldr	w12,	[sp, #108]

    movz	w27,	#1
    ldr	w11,	[sp, #128]

    str	w27,	[sp, #116]

    add	w22,	w12,	w11

f_48:
    ldr	w26,	[sp, #116]

    adrp	x11, :got:row
    lsl	w4,	w26,	#2
    ldr	x11, [x11, #:got_lo12:row]
    add	x26,	x11,	x4
    str	x26,	[sp, #96]

    ldr	x27,	[sp, #96]

    ldr	w12,	[x27]

    cmp	w12,	#1
    beq	f_84

f_53:
    ldr	w13,	[sp, #108]

    adrp	x17, :got:line1
    ldr	w27,	[sp, #116]

    ldr	x17, [x17, #:got_lo12:line1]
    add	w14,	w27,	w13
    lsl	w10,	w14,	#2
    add	x20,	x17,	x10
    ldr	w12,	[x20]

    cmp	w12,	#0
    bne	f_84

f_58:
    ldr	w28,	[sp, #116]

    adrp	x17, :got:line2
    movz	fp,	#132
    sub	w14,	w22,	w28
    ldr	x17, [x17, #:got_lo12:line2]
    lsl	w2,	w14,	#2
    add	x25,	x17,	x2
    str	x25,	[sp, fp]

    movz	fp,	#132
    ldr	x26,	[sp, fp]

    ldr	w4,	[x26]

    cmp	w4,	#0
    bne	f_84

f_63:
    ldr	w0,	[sp, #116]

    ldr	x6,	[sp, #168]

    str	w0,	[x6]

    ldr	w13,	[sp, #108]

    ldr	w4,	[sp, #128]

    cmp	w13,	w4
    bne	f_80

f_65:
    adrp	x8, :got:sum
    adrp	x10, :got:sum
    ldr	x8, [x8, #:got_lo12:sum]
    ldr	w7,	[x8]

    ldr	x10, [x10, #:got_lo12:sum]
    movz	w8,	#1
    add	w2,	w7,	#1
    mov	w27,	w8
    str	w2,	[x10]


f_68:
    ldr	w5,	[sp, #128]

    cmp	w27,	w5
    bgt	f_80

f_71:
    lsl	w0,	w27,	#2
    adrp	x18, :got:ans
    ldr	x18, [x18, #:got_lo12:ans]
    add	x0,	x18,	x0
    ldr	w0,	[x0]

    bl	putint
    ldr	w6,	[sp, #128]

    cmp	w27,	w6
    beq	f_75

f_76:
    movz	w0,	#32
    bl	putch
    add	w17,	w27,	#1
    mov	w27,	w17
    b	f_68

f_75:
    movz	w0,	#10
    bl	putch

f_80:
    movz	w26,	#1
    ldr	x21,	[sp, #96]

    movz	w25,	#1
    movz	w0,	#1
    movz	fp,	#132
    str	w26,	[x21]

    str	w25,	[x20]

    ldr	x23,	[sp, fp]

    str	w0,	[x23]

    mov	w0,	w19
    bl	f
    movz	fp,	#132
    movz	w0,	#0
    movz	w10,	#0
    ldr	x17,	[sp, #96]

    movz	w11,	#0
    str	w11,	[x17]

    str	w10,	[x20]

    ldr	x28,	[sp, fp]

    str	w0,	[x28]


f_84:
    ldr	w1,	[sp, #116]

    ldr	w16,	[sp, #128]

    add	w4,	w1,	#1
    cmp	w4,	w16
    bgt	f_89

f_47:
    str	w4,	[sp, #116]

    b	f_48

f_89:
    movz	w0,	#0
    ldr	x17,	[sp, #160]

    movz	w4,	#0
    movz	w26,	#0
    str	w0,	[x17]

    ldr	x23,	[sp, #120]

    str	w4,	[x23]

    ldr	x11,	[sp, #152]

    str	w26,	[x11]


f_93:
    ldr	w22,	[sp, #112]

    ldr	w17,	[sp, #128]

    add	w12,	w22,	#1
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


