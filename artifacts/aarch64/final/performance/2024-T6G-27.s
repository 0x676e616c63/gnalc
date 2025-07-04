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
    adrp	x18, :got:A
    adrp	x3, :got:C
    adrp	x26, :got:B
    ldr	x26, [x26, #:got_lo12:B]
    ldr	x3, [x3, #:got_lo12:C]
    ldr	x18, [x18, #:got_lo12:A]

main_44:
    movz	w9,	#0
    cmp	w9,	w24
    bge	main_63

main_47:
    movz	w14,	#0

main_49:
    lsl	w8,	w14,	#12
    movz	w7,	#0
    add	x8,	x3,	x8

main_52:
    cmp	w7,	w24
    blt	main_55

main_58:
    add	w14,	w14,	#1
    cmp	w14,	w24
    blt	main_49
    b	main_63

main_55:
    lsl	w25,	w7,	#2
    movz	w11,	#0
    add	w7,	w7,	#1
    add	x17,	x8,	x25
    str	w11,	[x17]

    b	main_52

main_63:
    movz	w13,	#0
    cmp	w13,	w24
    bge	main_102

main_65:
    movz	w27,	#0

main_67:
    lsl	w17,	w27,	#12
    movz	w9,	#0
    add	x25,	x26,	x17

main_71:
    lsl	w5,	w9,	#12
    lsl	w7,	w27,	#2
    add	x23,	x18,	x5
    add	x6,	x23,	x7
    ldr	w6,	[x6]

    cmp	w6,	#0
    beq	main_77

main_82:
    lsl	w12,	w9,	#12
    movz	w17,	#0
    add	x22,	x3,	x12

main_84:
    cmp	w17,	w24
    blt	main_87

main_95:
    add	w9,	w9,	#1
    b	main_79

main_87:
    lsl	w11,	w17,	#2
    lsl	w14,	w17,	#2
    add	w17,	w17,	#1
    add	x13,	x25,	x14
    add	x16,	x22,	x11
    ldr	w20,	[x16]

    ldr	w15,	[x13]

    madd	w19,	w15,	w6,	w20

    str	w19,	[x16]

    b	main_84

main_77:
    add	w9,	w9,	#1

main_79:
    cmp	w9,	w24
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
    lsl	w22,	w20,	#12
    movz	w17,	#0
    add	x11,	x26,	x22

main_109:
    cmp	w17,	w24
    blt	main_112

main_115:
    add	w20,	w20,	#1
    cmp	w20,	w24
    blt	main_106
    b	main_120

main_112:
    lsl	w12,	w17,	#2
    add	w17,	w17,	#1
    add	x7,	x11,	x12
    movz	w12,	#0
    str	w12,	[x7]

    b	main_109

main_120:
    movz	w14,	#0
    cmp	w14,	w24
    bge	main_159

main_122:
    movz	w5,	#0

main_124:
    lsl	w7,	w5,	#12
    movz	w19,	#0
    add	x9,	x3,	x7

main_128:
    lsl	w21,	w19,	#12
    lsl	w23,	w5,	#2
    add	x14,	x18,	x21
    add	x22,	x14,	x23
    ldr	w13,	[x22]

    cmp	w13,	#0
    beq	main_134

main_139:
    lsl	w0,	w19,	#12
    movz	w25,	#0
    add	x11,	x26,	x0

main_141:
    cmp	w25,	w24
    blt	main_144

main_152:
    add	w19,	w19,	#1
    b	main_136

main_144:
    lsl	w2,	w25,	#2
    lsl	w7,	w25,	#2
    add	w25,	w25,	#1
    add	x6,	x9,	x7
    add	x23,	x11,	x2
    ldr	w17,	[x23]

    ldr	w8,	[x6]

    madd	w10,	w8,	w13,	w17

    str	w10,	[x23]

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


