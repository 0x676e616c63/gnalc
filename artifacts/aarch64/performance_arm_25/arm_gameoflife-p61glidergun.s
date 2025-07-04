.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    movz	fp,	#33936
    movk	fp,	#30,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	fp,	#16976
    movz	w1,	#0
    movz	w23,	#16960
    movk	fp,	#15,	lsl #16
    movk	w23,	#15,	lsl #16
    add	x0,	sp,	fp
    mov	x2,	x23
    bl	memset
    mov	x2,	x23
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w27,	w0
    bl	getint
    mov	w22,	w0
    bl	getch
    movz	w23,	#1
    cmp	w23,	w27
    bgt	main_35

main_8:
    movz	w23,	#1

main_10:
    movz	w13,	#1
    cmp	w13,	w28
    bgt	main_29

main_13:
    movz	w14,	#2000
    movz	w25,	#1
    mul	w11,	w23,	w14
    mov	x19,	x11
    add	x19,	sp,	x19
    add	x19,	x19,	#16

main_16:
    bl	getch
    cmp	w0,	#35
    beq	main_20

main_22:
    lsl	w13,	w25,	#2
    movz	w5,	#0
    add	x6,	x19,	x13
    str	w5,	[x6]

    b	main_24

main_20:
    lsl	w15,	w25,	#2
    add	x7,	x19,	x15
    movz	w15,	#1
    str	w15,	[x7]


main_24:
    add	w25,	w25,	#1
    cmp	w25,	w28
    ble	main_16

main_29:
    bl	getch
    add	w23,	w23,	#1
    cmp	w23,	w27
    ble	main_10

main_35:
    movz	w0,	#95
    bl	_sysy_starttime
    cmp	w22,	#0
    bgt	main_37

main_183:
    movz	w23,	#1
    b	main_185

main_37:
    movz	fp,	#16976
    add	x12,	sp,	#16
    movz	w23,	#1
    movk	fp,	#15,	lsl #16
    add	x26,	sp,	fp

main_41:
    cmp	w23,	#1
    beq	main_45

main_110:
    movz	w20,	#1
    cmp	w20,	w27
    bgt	main_177

main_112:
    movz	w3,	#1

main_114:
    movz	w20,	#1
    cmp	w20,	w28
    ble	main_117

main_169:
    add	w13,	w3,	#1
    b	main_172

main_117:
    sub	x6,	x3,	#1
    movz	w25,	#2000
    movz	w24,	#2000
    add	x13,	x3,	#1
    movz	w15,	#2000
    movz	w14,	#2000
    movz	w4,	#1
    madd	x10,	x6,	x25,	x26

    madd	x17,	x3,	x24,	x26

    madd	x20,	x13,	x15,	x26

    madd	x8,	x3,	x14,	x12


main_125:
    sub	w24,	w4,	#1
    lsl	w5,	w4,	#2
    add	w25,	w4,	#1
    add	x3,	x10,	x5
    lsl	w1,	w24,	#2
    lsl	w18,	w25,	#2
    lsl	w14,	w25,	#2
    add	x0,	x10,	x1
    add	x11,	x17,	x14
    lsl	w1,	w25,	#2
    ldr	w23,	[x0]

    add	x0,	x10,	x1
    ldr	w6,	[x3]

    add	w23,	w6,	w23
    lsl	w6,	w24,	#2
    ldr	w2,	[x0]

    add	x5,	x17,	x6
    add	w9,	w23,	w2
    ldr	w7,	[x5]

    lsl	w5,	w24,	#2
    ldr	w15,	[x11]

    add	w16,	w9,	w7
    lsl	w24,	w4,	#2
    add	x3,	x20,	x5
    lsl	w11,	w4,	#2
    add	w23,	w16,	w15
    add	x9,	x20,	x11
    ldr	w6,	[x3]

    add	x16,	x20,	x18
    ldr	w14,	[x9]

    add	w6,	w23,	w6
    ldr	w19,	[x16]

    add	x23,	x17,	x24
    add	w14,	w6,	w14
    ldr	w0,	[x23]

    add	w21,	w14,	w19
    cmp	w0,	#1
    bne	main_163

main_155:
    cmp	w21,	#2
    beq	main_157

main_163:
    cmp	w21,	#3
    beq	main_165

main_167:
    lsl	w18,	w4,	#2
    movz	w2,	#0
    add	x5,	x8,	x18
    str	w2,	[x5]

    b	main_159

main_165:
    lsl	w21,	w4,	#2
    movz	w4,	#1
    add	x7,	x8,	x21
    str	w4,	[x7]

    b	main_159

main_157:
    lsl	w24,	w4,	#2
    movz	w6,	#1
    add	x11,	x8,	x24
    str	w6,	[x11]


main_159:
    cmp	w25,	w28
    ble	main_124

main_172:
    cmp	w13,	w27
    ble	main_113

main_178:
    movz	w23,	#1
    b	main_179

main_113:
    mov	w3,	w13
    b	main_114

main_124:
    mov	w4,	w25
    b	main_125

main_177:
    movz	w23,	#1
    b	main_179

main_45:
    movz	w17,	#1
    cmp	w17,	w27
    bgt	main_175

main_47:
    movz	w13,	#1

main_49:
    movz	w18,	#1
    cmp	w18,	w28
    ble	main_52

main_104:
    add	w19,	w13,	#1
    b	main_107

main_52:
    sub	x25,	x13,	#1
    movz	w9,	#2000
    movz	w8,	#2000
    add	x19,	x13,	#1
    movz	w21,	#2000
    movz	w20,	#2000
    movz	w14,	#1
    madd	x6,	x25,	x9,	x12

    madd	x15,	x13,	x8,	x12

    madd	x17,	x19,	x21,	x12

    madd	x24,	x13,	x20,	x26


main_60:
    sub	w9,	w14,	#1
    lsl	w20,	w14,	#2
    add	x18,	x6,	x20
    lsl	w1,	w9,	#2
    lsl	w13,	w9,	#2
    add	x0,	x15,	x1
    add	x11,	x6,	x13
    ldr	w2,	[x11]

    ldr	w21,	[x18]

    add	w8,	w21,	w2
    add	w21,	w14,	#1
    lsl	w5,	w21,	#2
    lsl	w20,	w21,	#2
    add	x4,	x15,	x5
    add	x18,	x6,	x20
    ldr	w23,	[x18]

    ldr	w2,	[x0]

    lsl	w18,	w9,	#2
    add	w25,	w8,	w23
    lsl	w0,	w14,	#2
    ldr	w7,	[x4]

    lsl	w9,	w14,	#2
    add	x16,	x17,	x18
    lsl	w4,	w21,	#2
    add	w3,	w25,	w2
    add	x25,	x17,	x0
    ldr	w20,	[x16]

    add	w8,	w3,	w7
    ldr	w1,	[x25]

    add	x3,	x17,	x4
    add	w13,	w8,	w20
    ldr	w5,	[x3]

    add	x8,	x15,	x9
    add	w25,	w13,	w1
    ldr	w10,	[x8]

    add	w3,	w25,	w5
    cmp	w10,	#1
    bne	main_98

main_90:
    cmp	w3,	#2
    beq	main_92

main_98:
    cmp	w3,	#3
    beq	main_100

main_102:
    lsl	w1,	w14,	#2
    movz	w7,	#0
    add	x18,	x24,	x1
    str	w7,	[x18]

    b	main_94

main_100:
    lsl	w3,	w14,	#2
    movz	w9,	#1
    add	x23,	x24,	x3
    str	w9,	[x23]

    b	main_94

main_92:
    lsl	w5,	w14,	#2
    movz	w11,	#1
    add	x0,	x24,	x5
    str	w11,	[x0]


main_94:
    cmp	w21,	w28
    ble	main_59

main_107:
    cmp	w19,	w27
    ble	main_48

main_176:
    movz	w23,	#2
    b	main_179

main_48:
    mov	w13,	w19
    b	main_49

main_59:
    mov	w14,	w21
    b	main_60

main_175:
    movz	w23,	#2

main_179:
    sub	w22,	w22,	#1
    cmp	w22,	#0
    bgt	main_41

main_185:
    movz	w0,	#106
    bl	_sysy_stoptime
    cmp	w23,	#2
    bne	main_210

main_188:
    movz	w20,	#1
    cmp	w20,	w27
    bgt	main_210

main_190:
    movz	w16,	#1

main_192:
    movz	w17,	#2000
    movz	w15,	#2000
    movz	fp,	#16976
    movz	w4,	#1
    mul	w13,	w16,	w17
    mul	w15,	w16,	w15
    movk	fp,	#15,	lsl #16
    mov	x21,	x13
    mov	x14,	x15
    add	x21,	sp,	x21
    add	x14,	sp,	x14
    add	x21,	x21,	#16
    add	x14,	x14,	fp

main_196:
    cmp	w4,	w28
    ble	main_199

main_204:
    add	w16,	w16,	#1
    cmp	w16,	w27
    ble	main_192
    b	main_210

main_199:
    lsl	w5,	w4,	#2
    lsl	w7,	w4,	#2
    add	w4,	w4,	#1
    add	x6,	x14,	x7
    add	x1,	x21,	x5
    ldr	w8,	[x6]

    str	w8,	[x1]

    b	main_196

main_210:
    movz	w25,	#1
    cmp	w25,	w27
    bgt	main_237

main_212:
    movz	w24,	#1

main_214:
    movz	w20,	#1
    cmp	w20,	w28
    bgt	main_232

main_217:
    movz	w21,	#2000
    movz	w25,	#1
    mul	w2,	w24,	w21
    mov	x22,	x2
    add	x22,	sp,	x22
    add	x22,	x22,	#16

main_220:
    lsl	w0,	w25,	#2
    add	x26,	x22,	x0
    ldr	w1,	[x26]

    cmp	w1,	#1
    beq	main_225

main_226:
    movz	w0,	#46
    bl	putch
    b	main_227

main_225:
    movz	w0,	#35
    bl	putch

main_227:
    add	w25,	w25,	#1
    cmp	w25,	w28
    ble	main_220

main_232:
    movz	w0,	#10
    bl	putch
    add	w24,	w24,	#1
    cmp	w24,	w27
    ble	main_214

main_237:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#33936
    movk	fp,	#30,	lsl #16
    add	sp, sp, fp
    ret


