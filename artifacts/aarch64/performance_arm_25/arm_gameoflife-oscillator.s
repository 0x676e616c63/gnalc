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
    
    movz	w23,	#16960
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w23,	#15,	lsl #16
    mov	x2,	x23
    bl	memset
    mov	x2,	x23
    movz	w1,	#0
    movz	fp,	#16976
    movk	fp,	#15,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    bl	getint
    mov	w26,	w0
    bl	getint
    mov	w19,	w0
    bl	getint
    mov	w22,	w0
    bl	getch
    movz	w24,	#1
    cmp	w24,	w19
    bgt	main_35

main_8:
    movz	w24,	#1

main_10:
    movz	w13,	#1
    cmp	w13,	w26
    bgt	main_29

main_13:
    movz	w14,	#2000
    movz	fp,	#16976
    movz	w27,	#1
    movk	fp,	#15,	lsl #16
    mul	w11,	w24,	w14
    mov	x20,	x11
    add	x20,	sp,	x20
    add	x20,	x20,	fp

main_16:
    bl	getch
    cmp	w0,	#35
    beq	main_20

main_22:
    lsl	w13,	w27,	#2
    movz	w5,	#0
    add	x6,	x20,	x13
    str	w5,	[x6]

    b	main_24

main_20:
    lsl	w15,	w27,	#2
    add	x7,	x20,	x15
    movz	w15,	#1
    str	w15,	[x7]


main_24:
    add	w27,	w27,	#1
    cmp	w27,	w26
    ble	main_16

main_29:
    bl	getch
    add	w24,	w24,	#1
    cmp	w24,	w19
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
    add	x0,	sp,	#16
    movz	fp,	#16976
    movz	w23,	#1
    movk	fp,	#15,	lsl #16
    add	x15,	sp,	fp

main_41:
    cmp	w23,	#1
    beq	main_45

main_110:
    movz	w23,	#1
    cmp	w23,	w19
    bgt	main_177

main_112:
    movz	w4,	#1

main_114:
    movz	w23,	#1
    cmp	w23,	w26
    ble	main_117

main_169:
    add	w13,	w4,	#1
    b	main_172

main_117:
    sub	x7,	x4,	#1
    movz	w28,	#2000
    movz	w27,	#2000
    add	x13,	x4,	#1
    movz	w16,	#2000
    movz	w14,	#2000
    movz	w5,	#1
    madd	x11,	x7,	x28,	x0

    madd	x18,	x4,	x27,	x0

    madd	x23,	x13,	x16,	x0

    madd	x9,	x4,	x14,	x15


main_125:
    sub	w27,	w5,	#1
    lsl	w6,	w5,	#2
    add	w28,	w5,	#1
    add	x4,	x11,	x6
    lsl	w2,	w27,	#2
    lsl	w20,	w28,	#2
    lsl	w14,	w28,	#2
    add	x1,	x11,	x2
    add	x12,	x18,	x14
    lsl	w2,	w28,	#2
    ldr	w25,	[x1]

    add	x1,	x11,	x2
    ldr	w7,	[x4]

    add	w25,	w7,	w25
    lsl	w7,	w27,	#2
    ldr	w3,	[x1]

    add	x6,	x18,	x7
    add	w10,	w25,	w3
    ldr	w8,	[x6]

    lsl	w6,	w27,	#2
    ldr	w16,	[x12]

    add	w17,	w10,	w8
    lsl	w27,	w5,	#2
    add	x4,	x23,	x6
    lsl	w12,	w5,	#2
    add	w25,	w17,	w16
    add	x10,	x23,	x12
    ldr	w7,	[x4]

    add	x17,	x23,	x20
    ldr	w14,	[x10]

    add	w7,	w25,	w7
    ldr	w21,	[x17]

    add	x25,	x18,	x27
    add	w14,	w7,	w14
    ldr	w1,	[x25]

    add	w24,	w14,	w21
    cmp	w1,	#1
    bne	main_163

main_155:
    cmp	w24,	#2
    beq	main_157

main_163:
    cmp	w24,	#3
    beq	main_165

main_167:
    lsl	w20,	w5,	#2
    movz	w3,	#0
    add	x6,	x9,	x20
    str	w3,	[x6]

    b	main_159

main_165:
    lsl	w24,	w5,	#2
    movz	w5,	#1
    add	x8,	x9,	x24
    str	w5,	[x8]

    b	main_159

main_157:
    lsl	w27,	w5,	#2
    movz	w7,	#1
    add	x12,	x9,	x27
    str	w7,	[x12]


main_159:
    cmp	w28,	w26
    ble	main_124

main_172:
    cmp	w13,	w19
    ble	main_113

main_178:
    movz	w23,	#1
    b	main_179

main_113:
    mov	w4,	w13
    b	main_114

main_124:
    mov	w5,	w28
    b	main_125

main_177:
    movz	w23,	#1
    b	main_179

main_45:
    movz	w18,	#1
    cmp	w18,	w19
    bgt	main_175

main_47:
    movz	w13,	#1

main_49:
    movz	w20,	#1
    cmp	w20,	w26
    ble	main_52

main_104:
    add	w20,	w13,	#1
    b	main_107

main_52:
    sub	x28,	x13,	#1
    movz	w9,	#2000
    movz	w8,	#2000
    add	x20,	x13,	#1
    movz	w23,	#2000
    movz	w21,	#2000
    movz	w14,	#1
    madd	x10,	x28,	x9,	x15

    madd	x16,	x13,	x8,	x15

    madd	x18,	x20,	x23,	x15

    madd	x27,	x13,	x21,	x0


main_60:
    sub	w9,	w14,	#1
    lsl	w23,	w14,	#2
    add	x21,	x10,	x23
    lsl	w2,	w9,	#2
    lsl	w13,	w9,	#2
    add	w23,	w14,	#1
    add	x1,	x16,	x2
    add	x12,	x10,	x13
    lsl	w6,	w23,	#2
    ldr	w3,	[x12]

    add	x5,	x16,	x6
    ldr	w24,	[x21]

    add	w8,	w24,	w3
    lsl	w24,	w23,	#2
    add	x21,	x10,	x24
    ldr	w25,	[x21]

    lsl	w21,	w9,	#2
    ldr	w3,	[x1]

    add	w28,	w8,	w25
    lsl	w9,	w14,	#2
    add	x17,	x18,	x21
    lsl	w1,	w14,	#2
    ldr	w7,	[x5]

    add	w4,	w28,	w3
    lsl	w5,	w23,	#2
    ldr	w24,	[x17]

    add	x28,	x18,	x1
    add	w8,	w4,	w7
    ldr	w2,	[x28]

    add	x4,	x18,	x5
    add	w13,	w8,	w24
    ldr	w6,	[x4]

    add	x8,	x16,	x9
    add	w28,	w13,	w2
    ldr	w11,	[x8]

    add	w4,	w28,	w6
    cmp	w11,	#1
    bne	main_98

main_90:
    cmp	w4,	#2
    beq	main_92

main_98:
    cmp	w4,	#3
    beq	main_100

main_102:
    lsl	w2,	w14,	#2
    movz	w7,	#0
    add	x21,	x27,	x2
    str	w7,	[x21]

    b	main_94

main_100:
    lsl	w4,	w14,	#2
    movz	w9,	#1
    add	x25,	x27,	x4
    str	w9,	[x25]

    b	main_94

main_92:
    lsl	w6,	w14,	#2
    movz	w11,	#1
    add	x1,	x27,	x6
    str	w11,	[x1]


main_94:
    cmp	w23,	w26
    ble	main_59

main_107:
    cmp	w20,	w19
    ble	main_48

main_176:
    movz	w23,	#2
    b	main_179

main_48:
    mov	w13,	w20
    b	main_49

main_59:
    mov	w14,	w23
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
    movz	w21,	#1
    cmp	w21,	w19
    bgt	main_210

main_190:
    movz	w16,	#1

main_192:
    movz	w17,	#2000
    movz	fp,	#16976
    movz	w15,	#2000
    movz	w4,	#1
    mul	w13,	w16,	w17
    movk	fp,	#15,	lsl #16
    mul	w15,	w16,	w15
    mov	x22,	x13
    mov	x14,	x15
    add	x22,	sp,	x22
    add	x14,	sp,	x14
    add	x22,	x22,	fp
    add	x14,	x14,	#16

main_196:
    cmp	w4,	w26
    ble	main_199

main_204:
    add	w16,	w16,	#1
    cmp	w16,	w19
    ble	main_192
    b	main_210

main_199:
    lsl	w5,	w4,	#2
    lsl	w7,	w4,	#2
    add	w4,	w4,	#1
    add	x6,	x14,	x7
    add	x1,	x22,	x5
    ldr	w8,	[x6]

    str	w8,	[x1]

    b	main_196

main_210:
    movz	w27,	#1
    cmp	w27,	w19
    bgt	main_237

main_212:
    movz	w24,	#1

main_214:
    movz	w21,	#1
    cmp	w21,	w26
    bgt	main_232

main_217:
    movz	w22,	#2000
    movz	fp,	#16976
    movz	w25,	#1
    movk	fp,	#15,	lsl #16
    mul	w2,	w24,	w22
    mov	x23,	x2
    add	x23,	sp,	x23
    add	x23,	x23,	fp

main_220:
    lsl	w0,	w25,	#2
    add	x28,	x23,	x0
    ldr	w1,	[x28]

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
    cmp	w25,	w26
    ble	main_220

main_232:
    movz	w0,	#10
    bl	putch
    add	w24,	w24,	#1
    cmp	w24,	w19
    ble	main_214

main_237:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#33936
    movk	fp,	#30,	lsl #16
    add	sp, sp, fp
    ret


