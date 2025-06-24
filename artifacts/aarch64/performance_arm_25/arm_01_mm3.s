.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global A
.align	2
A:
    .zero	4194304

.global B
.align	2
B:
    .zero	4194304

.global C
.align	2
C:
    .zero	4194304


.text

.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    movz	w19,	#0
    mov	w27,	w0
    cmp	w19,	w27
    bge	main_20

main_3:
    movz	w19,	#0

main_5:
    lsl	w8,	w19,	#12
    adrp	x4, :got:A
    movz	w22,	#0
    ldr	x4, [x4, #:got_lo12:A]
    add	x20,	x4,	x8

main_8:
    cmp	w22,	w27
    bge	main_15

main_11:
    lsl	w26,	w22,	#2
    add	x25,	x20,	x26
    bl	getint
    add	w22,	w22,	#1
    str	w0,	[x25]

    b	main_8

main_15:
    add	w19,	w19,	#1
    cmp	w19,	w27
    blt	main_5

main_20:
    movz	w22,	#0
    cmp	w22,	w27
    bge	main_39

main_22:
    movz	w21,	#0

main_24:
    lsl	w19,	w21,	#12
    adrp	x15, :got:B
    movz	w24,	#0
    ldr	x15, [x15, #:got_lo12:B]
    add	x23,	x15,	x19

main_27:
    cmp	w24,	w27
    bge	main_34

main_30:
    lsl	w19,	w24,	#2
    add	x20,	x23,	x19
    bl	getint
    add	w24,	w24,	#1
    str	w0,	[x20]

    b	main_27

main_34:
    add	w21,	w21,	#1
    cmp	w21,	w27
    blt	main_24

main_39:
    movz	w0,	#65
    bl	_sysy_starttime
    movz	w24,	#0
    adrp	x0, :got:C
    adrp	x19, :got:A
    adrp	x1, :got:B
    ldr	x1, [x1, #:got_lo12:B]
    ldr	x0, [x0, #:got_lo12:C]
    ldr	x19, [x19, #:got_lo12:A]

main_44:
    movz	w9,	#0
    cmp	w9,	w27
    bge	main_63

main_47:
    movz	w16,	#0

main_49:
    lsl	w8,	w16,	#12
    movz	w14,	#0
    add	x8,	x0,	x8

main_52:
    cmp	w14,	w27
    bge	main_58

main_55:
    lsl	w22,	w14,	#2
    movz	w7,	#0
    add	w14,	w14,	#1
    add	x13,	x8,	x22
    str	w7,	[x13]

    b	main_52

main_58:
    add	w16,	w16,	#1
    cmp	w16,	w27
    blt	main_49

main_63:
    movz	w13,	#0
    cmp	w13,	w27
    bge	main_102

main_65:
    movz	w8,	#0

main_67:
    lsl	w18,	w8,	#12
    movz	w14,	#0
    add	x4,	x1,	x18

main_71:
    lsl	w5,	w14,	#12
    lsl	w7,	w8,	#2
    add	x25,	x19,	x5
    add	x6,	x25,	x7
    ldr	w7,	[x6]

    cmp	w7,	#0
    bne	main_79

main_77:
    add	w14,	w14,	#1
    b	main_94

main_79:
    lsl	w13,	w14,	#12
    movz	w18,	#0
    add	x25,	x0,	x13

main_81:
    cmp	w18,	w27
    bge	main_92

main_84:
    lsl	w11,	w18,	#2
    lsl	w15,	w18,	#2
    add	w18,	w18,	#1
    add	x13,	x4,	x15
    add	x17,	x25,	x11
    ldr	w21,	[x17]

    ldr	w16,	[x13]

    madd	w20,	w16,	w7,	w21

    str	w20,	[x17]

    b	main_81

main_92:
    add	w14,	w14,	#1

main_94:
    cmp	w14,	w27
    blt	main_71

main_97:
    add	w8,	w8,	#1
    cmp	w8,	w27
    blt	main_67

main_102:
    movz	w9,	#0
    cmp	w9,	w27
    bge	main_120

main_104:
    movz	w2,	#0

main_106:
    lsl	w22,	w2,	#12
    movz	w20,	#0
    add	x6,	x1,	x22

main_109:
    cmp	w20,	w27
    bge	main_115

main_112:
    lsl	w11,	w20,	#2
    movz	w3,	#0
    add	w20,	w20,	#1
    add	x7,	x6,	x11
    str	w3,	[x7]

    b	main_109

main_115:
    add	w2,	w2,	#1
    cmp	w2,	w27
    blt	main_106

main_120:
    movz	w13,	#0
    cmp	w13,	w27
    bge	main_159

main_122:
    movz	w16,	#0

main_124:
    lsl	w6,	w16,	#12
    movz	w20,	#0
    add	x18,	x0,	x6

main_128:
    lsl	w21,	w20,	#12
    lsl	w23,	w16,	#2
    add	x13,	x19,	x21
    add	x22,	x13,	x23
    ldr	w4,	[x22]

    cmp	w4,	#0
    bne	main_136

main_134:
    add	w20,	w20,	#1
    b	main_151

main_136:
    lsl	w3,	w20,	#12
    movz	w23,	#0
    add	x11,	x1,	x3

main_138:
    cmp	w23,	w27
    bge	main_149

main_141:
    lsl	w3,	w23,	#2
    lsl	w6,	w23,	#2
    add	w23,	w23,	#1
    add	x5,	x18,	x6
    add	x25,	x11,	x3
    ldr	w17,	[x25]

    ldr	w7,	[x5]

    madd	w9,	w7,	w4,	w17

    str	w9,	[x25]

    b	main_138

main_149:
    add	w20,	w20,	#1

main_151:
    cmp	w20,	w27
    blt	main_128

main_154:
    add	w16,	w16,	#1
    cmp	w16,	w27
    blt	main_124

main_159:
    add	w24,	w24,	#1
    cmp	w24,	#5
    blt	main_44

main_162:
    movz	w21,	#0
    cmp	w21,	w27
    blt	main_164

main_182:
    movz	w21,	#0
    b	main_184

main_164:
    movz	w14,	#0
    movz	w21,	#0

main_166:
    lsl	w6,	w14,	#12
    adrp	x28, :got:B
    movz	w10,	#0
    ldr	x28, [x28, #:got_lo12:B]
    add	x25,	x28,	x6

main_170:
    cmp	w10,	w27
    bge	main_179

main_174:
    lsl	w11,	w10,	#2
    add	w10,	w10,	#1
    add	x9,	x25,	x11
    ldr	w12,	[x9]

    add	w21,	w12,	w21
    b	main_170

main_179:
    add	w14,	w14,	#1
    cmp	w14,	w27
    blt	main_166

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


