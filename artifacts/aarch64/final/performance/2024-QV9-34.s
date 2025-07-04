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
    movz	fp,	#16976
    movz	w25,	#1
    movk	fp,	#15,	lsl #16
    mul	w11,	w23,	w14
    mov	x19,	x11
    add	x19,	sp,	x19
    add	x19,	x19,	fp

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
    add	x10,	sp,	#16
    movz	fp,	#16976
    movz	w23,	#1
    movk	fp,	#15,	lsl #16
    add	x0,	sp,	fp

main_41:
    cmp	w23,	#1
    beq	main_45

main_110:
    movz	w21,	#1
    cmp	w21,	w27
    bgt	main_177

main_112:
    movz	w4,	#1

main_114:
    movz	w21,	#1
    cmp	w21,	w28
    ble	main_117

main_169:
    add	w14,	w4,	#1
    b	main_172

main_117:
    sub	x7,	x4,	#1
    movz	w26,	#2000
    movz	w25,	#2000
    add	x14,	x4,	#1
    movz	w16,	#2000
    movz	w15,	#2000
    movz	w5,	#1
    madd	x12,	x7,	x26,	x10

    madd	x18,	x4,	x25,	x10

    madd	x21,	x14,	x16,	x10

    madd	x9,	x4,	x15,	x0


main_125:
    sub	w25,	w5,	#1
    lsl	w6,	w5,	#2
    add	w26,	w5,	#1
    add	x4,	x12,	x6
    lsl	w2,	w25,	#2
    lsl	w19,	w26,	#2
    lsl	w15,	w26,	#2
    add	x1,	x12,	x2
    add	x13,	x18,	x15
    lsl	w2,	w26,	#2
    ldr	w24,	[x1]

    add	x1,	x12,	x2
    ldr	w7,	[x4]

    add	w24,	w7,	w24
    lsl	w7,	w25,	#2
    ldr	w3,	[x1]

    add	x6,	x18,	x7
    add	w11,	w24,	w3
    ldr	w8,	[x6]

    lsl	w6,	w25,	#2
    ldr	w16,	[x13]

    add	w17,	w11,	w8
    lsl	w25,	w5,	#2
    add	x4,	x21,	x6
    lsl	w13,	w5,	#2
    add	w24,	w17,	w16
    add	x11,	x21,	x13
    ldr	w7,	[x4]

    add	x17,	x21,	x19
    ldr	w15,	[x11]

    add	w7,	w24,	w7
    ldr	w20,	[x17]

    add	x24,	x18,	x25
    add	w15,	w7,	w15
    ldr	w1,	[x24]

    add	w23,	w15,	w20
    cmp	w1,	#1
    bne	main_163

main_155:
    cmp	w23,	#2
    beq	main_157

main_163:
    cmp	w23,	#3
    beq	main_165

main_167:
    lsl	w19,	w5,	#2
    movz	w3,	#0
    add	x6,	x9,	x19
    str	w3,	[x6]

    b	main_159

main_165:
    lsl	w23,	w5,	#2
    movz	w5,	#1
    add	x8,	x9,	x23
    str	w5,	[x8]

    b	main_159

main_157:
    lsl	w25,	w5,	#2
    movz	w7,	#1
    add	x13,	x9,	x25
    str	w7,	[x13]


main_159:
    cmp	w26,	w28
    ble	main_124

main_172:
    cmp	w14,	w27
    ble	main_113

main_178:
    movz	w23,	#1
    b	main_179

main_113:
    mov	w4,	w14
    b	main_114

main_124:
    mov	w5,	w26
    b	main_125

main_177:
    movz	w23,	#1
    b	main_179

main_45:
    movz	w18,	#1
    cmp	w18,	w27
    bgt	main_175

main_47:
    movz	w13,	#1

main_49:
    movz	w19,	#1
    cmp	w19,	w28
    ble	main_52

main_104:
    add	w19,	w13,	#1
    b	main_107

main_52:
    sub	x26,	x13,	#1
    movz	w9,	#2000
    movz	w8,	#2000
    add	x19,	x13,	#1
    movz	w21,	#2000
    movz	w20,	#2000
    movz	w14,	#1
    madd	x12,	x26,	x9,	x0

    madd	x16,	x13,	x8,	x0

    madd	x18,	x19,	x21,	x0

    madd	x25,	x13,	x20,	x10


main_60:
    sub	w9,	w14,	#1
    lsl	w21,	w14,	#2
    add	x20,	x12,	x21
    lsl	w2,	w9,	#2
    lsl	w15,	w9,	#2
    add	w21,	w14,	#1
    add	x1,	x16,	x2
    add	x13,	x12,	x15
    lsl	w6,	w21,	#2
    ldr	w3,	[x13]

    add	x5,	x16,	x6
    ldr	w23,	[x20]

    add	w8,	w23,	w3
    lsl	w23,	w21,	#2
    add	x20,	x12,	x23
    ldr	w24,	[x20]

    lsl	w20,	w9,	#2
    ldr	w3,	[x1]

    add	w26,	w8,	w24
    lsl	w9,	w14,	#2
    add	x17,	x18,	x20
    lsl	w1,	w14,	#2
    ldr	w7,	[x5]

    add	w4,	w26,	w3
    lsl	w5,	w21,	#2
    ldr	w23,	[x17]

    add	x26,	x18,	x1
    add	w8,	w4,	w7
    ldr	w2,	[x26]

    add	x4,	x18,	x5
    add	w15,	w8,	w23
    ldr	w6,	[x4]

    add	x8,	x16,	x9
    add	w26,	w15,	w2
    ldr	w11,	[x8]

    add	w4,	w26,	w6
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
    add	x20,	x25,	x2
    str	w7,	[x20]

    b	main_94

main_100:
    lsl	w4,	w14,	#2
    movz	w9,	#1
    add	x24,	x25,	x4
    str	w9,	[x24]

    b	main_94

main_92:
    lsl	w6,	w14,	#2
    movz	w11,	#1
    add	x1,	x25,	x6
    str	w11,	[x1]


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
    movz	fp,	#16976
    movz	w15,	#2000
    movz	w4,	#1
    mul	w13,	w16,	w17
    movk	fp,	#15,	lsl #16
    mul	w15,	w16,	w15
    mov	x21,	x13
    mov	x14,	x15
    add	x21,	sp,	x21
    add	x14,	sp,	x14
    add	x21,	x21,	fp
    add	x14,	x14,	#16

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
    movz	fp,	#16976
    movz	w25,	#1
    movk	fp,	#15,	lsl #16
    mul	w2,	w24,	w21
    mov	x22,	x2
    add	x22,	sp,	x22
    add	x22,	x22,	fp

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


