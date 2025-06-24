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
    adrp	x4, :got:C
    adrp	x18, :got:A
    adrp	x26, :got:B
    ldr	x26, [x26, #:got_lo12:B]
    ldr	x4, [x4, #:got_lo12:C]
    ldr	x18, [x18, #:got_lo12:A]

main_44:
    movz	w8,	#0
    cmp	w8,	w27
    bge	main_63

main_47:
    movz	w15,	#0

main_49:
    lsl	w7,	w15,	#12
    movz	w13,	#0
    add	x7,	x4,	x7

main_52:
    cmp	w13,	w27
    bge	main_58

main_55:
    lsl	w21,	w13,	#2
    movz	w6,	#0
    add	w13,	w13,	#1
    add	x12,	x7,	x21
    str	w6,	[x12]

    b	main_52

main_58:
    add	w15,	w15,	#1
    cmp	w15,	w27
    blt	main_49

main_63:
    movz	w12,	#0
    cmp	w12,	w27
    bge	main_102

main_65:
    movz	w7,	#0

main_67:
    lsl	w17,	w7,	#12
    movz	w14,	#0
    add	x2,	x26,	x17

main_71:
    lsl	w3,	w14,	#12
    lsl	w6,	w7,	#2
    add	x23,	x18,	x3
    add	x5,	x23,	x6
    ldr	w6,	[x5]

    cmp	w6,	#0
    bne	main_79

main_77:
    add	w14,	w14,	#1
    b	main_94

main_79:
    lsl	w12,	w14,	#12
    movz	w17,	#0
    add	x23,	x4,	x12

main_81:
    cmp	w17,	w27
    bge	main_92

main_84:
    lsl	w10,	w17,	#2
    lsl	w13,	w17,	#2
    add	w17,	w17,	#1
    add	x12,	x2,	x13
    add	x16,	x23,	x10
    ldr	w20,	[x16]

    ldr	w15,	[x12]

    madd	w19,	w15,	w6,	w20

    str	w19,	[x16]

    b	main_81

main_92:
    add	w14,	w14,	#1

main_94:
    cmp	w14,	w27
    blt	main_71

main_97:
    add	w7,	w7,	#1
    cmp	w7,	w27
    blt	main_67

main_102:
    movz	w9,	#0
    cmp	w9,	w27
    bge	main_120

main_104:
    movz	w2,	#0

main_106:
    lsl	w21,	w2,	#12
    movz	w20,	#0
    add	x5,	x26,	x21

main_109:
    cmp	w20,	w27
    bge	main_115

main_112:
    lsl	w10,	w20,	#2
    movz	w3,	#0
    add	w20,	w20,	#1
    add	x6,	x5,	x10
    str	w3,	[x6]

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
    lsl	w5,	w16,	#12
    movz	w20,	#0
    add	x17,	x4,	x5

main_128:
    lsl	w19,	w20,	#12
    lsl	w22,	w16,	#2
    add	x12,	x18,	x19
    add	x21,	x12,	x22
    ldr	w2,	[x21]

    cmp	w2,	#0
    bne	main_136

main_134:
    add	w20,	w20,	#1
    b	main_151

main_136:
    lsl	w1,	w20,	#12
    movz	w23,	#0
    add	x10,	x26,	x1

main_138:
    cmp	w23,	w27
    bge	main_149

main_141:
    lsl	w1,	w23,	#2
    lsl	w5,	w23,	#2
    add	w23,	w23,	#1
    add	x3,	x17,	x5
    add	x22,	x10,	x1
    ldr	w15,	[x22]

    ldr	w6,	[x3]

    madd	w8,	w6,	w2,	w15

    str	w8,	[x22]

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


