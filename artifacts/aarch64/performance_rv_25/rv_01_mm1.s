.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global A
.align	2
A:
.type A, %object
    .zero	4194304

.global B
.align	2
B:
.type B, %object
    .zero	4194304

.global C
.align	2
C:
.type C, %object
    .zero	4194304

.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    movz	w19,	#0
    mov	w24,	w0
    cmp	w19,	w24
    bge	main_20

main_3:
    movz	w21,	#0

main_5:
    lsl	w8,	w21,	#12
    adrp	x4, :got:A
    movz	w20,	#0
    ldr	x4, [x4, #:got_lo12:A]
    add	x25,	x4,	x8

main_8:
    cmp	w20,	w24
    blt	main_11

main_15:
    add	w21,	w21,	#1
    cmp	w21,	w24
    blt	main_5
    b	main_20

main_11:
    lsl	w18,	w20,	#2
    add	x28,	x25,	x18
    bl	getint
    add	w20,	w20,	#1
    str	w0,	[x28]

    b	main_8

main_20:
    movz	w22,	#0
    cmp	w22,	w24
    bge	main_39

main_22:
    movz	w23,	#0

main_24:
    lsl	w19,	w23,	#12
    adrp	x15, :got:B
    movz	w22,	#0
    ldr	x15, [x15, #:got_lo12:B]
    add	x20,	x15,	x19

main_27:
    cmp	w22,	w24
    blt	main_30

main_34:
    add	w23,	w23,	#1
    cmp	w23,	w24
    blt	main_24
    b	main_39

main_30:
    lsl	w21,	w22,	#2
    add	x25,	x20,	x21
    bl	getint
    add	w22,	w22,	#1
    str	w0,	[x25]

    b	main_27

main_39:
    movz	w0,	#65
    bl	_sysy_starttime
    movz	w1,	#0
    adrp	x0, :got:C
    adrp	x6, :got:A
    adrp	x11, :got:B
    ldr	x11, [x11, #:got_lo12:B]
    ldr	x0, [x0, #:got_lo12:C]
    ldr	x6, [x6, #:got_lo12:A]

main_44:
    movz	w10,	#0
    cmp	w10,	w24
    bge	main_63

main_47:
    movz	w16,	#0

main_49:
    lsl	w9,	w16,	#12
    movz	w8,	#0
    add	x9,	x0,	x9

main_52:
    cmp	w8,	w24
    blt	main_55

main_58:
    add	w16,	w16,	#1
    cmp	w16,	w24
    blt	main_49
    b	main_63

main_55:
    lsl	w26,	w8,	#2
    movz	w13,	#0
    add	w8,	w8,	#1
    add	x19,	x9,	x26
    str	w13,	[x19]

    b	main_52

main_63:
    movz	w15,	#0
    cmp	w15,	w24
    bge	main_102

main_65:
    movz	w27,	#0

main_67:
    lsl	w19,	w27,	#12
    movz	w10,	#0
    add	x26,	x11,	x19

main_71:
    lsl	w5,	w10,	#12
    lsl	w8,	w27,	#2
    add	x25,	x6,	x5
    add	x7,	x25,	x8
    ldr	w7,	[x7]

    cmp	w7,	#0
    beq	main_77

main_82:
    lsl	w14,	w10,	#12
    movz	w19,	#0
    add	x23,	x0,	x14

main_84:
    cmp	w19,	w24
    blt	main_87

main_95:
    add	w10,	w10,	#1
    b	main_79

main_87:
    lsl	w13,	w19,	#2
    lsl	w16,	w19,	#2
    add	w19,	w19,	#1
    add	x15,	x26,	x16
    add	x18,	x23,	x13
    ldr	w21,	[x18]

    ldr	w17,	[x15]

    madd	w20,	w17,	w7,	w21

    str	w20,	[x18]

    b	main_84

main_77:
    add	w10,	w10,	#1

main_79:
    cmp	w10,	w24
    blt	main_71

main_97:
    add	w27,	w27,	#1
    cmp	w27,	w24
    blt	main_67

main_102:
    movz	w10,	#0
    cmp	w10,	w24
    bge	main_120

main_104:
    movz	w20,	#0

main_106:
    lsl	w23,	w20,	#12
    movz	w17,	#0
    add	x4,	x11,	x23

main_109:
    cmp	w17,	w24
    blt	main_112

main_115:
    add	w20,	w20,	#1
    cmp	w20,	w24
    blt	main_106
    b	main_120

main_112:
    lsl	w14,	w17,	#2
    movz	w12,	#0
    add	w17,	w17,	#1
    add	x8,	x4,	x14
    str	w12,	[x8]

    b	main_109

main_120:
    movz	w14,	#0
    cmp	w14,	w24
    bge	main_159

main_122:
    movz	w5,	#0

main_124:
    lsl	w8,	w5,	#12
    movz	w19,	#0
    add	x10,	x0,	x8

main_128:
    lsl	w22,	w19,	#12
    lsl	w25,	w5,	#2
    add	x16,	x6,	x22
    add	x23,	x16,	x25
    ldr	w15,	[x23]

    cmp	w15,	#0
    beq	main_134

main_139:
    lsl	w2,	w19,	#12
    movz	w25,	#0
    add	x13,	x11,	x2

main_141:
    cmp	w25,	w24
    blt	main_144

main_152:
    add	w19,	w19,	#1
    b	main_136

main_144:
    lsl	w3,	w25,	#2
    lsl	w8,	w25,	#2
    add	w25,	w25,	#1
    add	x7,	x10,	x8
    add	x26,	x13,	x3
    ldr	w20,	[x26]

    ldr	w9,	[x7]

    madd	w12,	w9,	w15,	w20

    str	w12,	[x26]

    b	main_141

main_134:
    add	w19,	w19,	#1

main_136:
    cmp	w19,	w24
    blt	main_128

main_154:
    add	w5,	w5,	#1
    cmp	w5,	w24
    blt	main_124

main_159:
    add	w1,	w1,	#1
    cmp	w1,	#5
    blt	main_44

main_162:
    movz	w21,	#0
    cmp	w21,	w24
    bge	main_182

main_164:
    movz	w8,	#0
    movz	w21,	#0

main_166:
    lsl	w6,	w8,	#12
    adrp	x28, :got:B
    movz	w16,	#0
    ldr	x28, [x28, #:got_lo12:B]
    add	x26,	x28,	x6

main_170:
    cmp	w16,	w24
    blt	main_174

main_179:
    add	w8,	w8,	#1
    cmp	w8,	w24
    blt	main_166
    b	main_184

main_174:
    lsl	w13,	w16,	#2
    add	w16,	w16,	#1
    add	x12,	x26,	x13
    ldr	w14,	[x12]

    add	w21,	w14,	w21
    b	main_170

main_182:
    movz	w21,	#0

main_184:
    movz	w0,	#84
    bl	_sysy_stoptime
    mov	w0,	w21
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


