.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
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
    mov	w22,	w0
    bl	getint
    mov	w21,	w0
    bl	getint
    mov	w28,	w0
    bl	getch
    movz	w24,	#1
    cmp	w24,	w21
    bgt	main_35

main_8:
    movz	w25,	#1

main_10:
    movz	w13,	#1
    cmp	w13,	w22
    bgt	main_29

main_13:
    movz	w14,	#2000
    movz	w26,	#1
    mul	w11,	w25,	w14
    mov	x19,	x11
    add	x19,	sp,	x19
    add	x19,	x19,	#16

main_16:
    bl	getch
    cmp	w0,	#35
    bne	main_22

main_20:
    lsl	w13,	w26,	#2
    movz	w5,	#1
    add	x6,	x19,	x13
    str	w5,	[x6]

    b	main_24

main_22:
    lsl	w15,	w26,	#2
    add	x7,	x19,	x15
    movz	w15,	#0
    str	w15,	[x7]


main_24:
    add	w26,	w26,	#1
    cmp	w26,	w22
    ble	main_16

main_29:
    bl	getch
    add	w25,	w25,	#1
    cmp	w25,	w21
    ble	main_10

main_35:
    movz	w0,	#95
    bl	_sysy_starttime
    cmp	w28,	#0
    ble	main_183

main_37:
    add	x27,	sp,	#16
    movz	fp,	#16976
    movz	w25,	#1
    movk	fp,	#15,	lsl #16
    add	x15,	sp,	fp

main_41:
    cmp	w25,	#1
    bne	main_110

main_45:
    movz	w20,	#1
    cmp	w20,	w21
    ble	main_47

main_175:
    movz	w25,	#2
    b	main_179

main_47:
    movz	w3,	#1

main_49:
    movz	w20,	#1
    cmp	w20,	w22
    bgt	main_104

main_52:
    sub	x5,	x3,	#1
    movz	w26,	#2000
    movz	w25,	#2000
    add	x16,	x3,	#1
    movz	w13,	#2000
    movz	w12,	#2000
    movz	w10,	#1
    madd	x26,	x5,	x26,	x27

    madd	x1,	x3,	x25,	x27

    madd	x9,	x16,	x13,	x27

    madd	x23,	x3,	x12,	x15


main_60:
    sub	w24,	w10,	#1
    lsl	w4,	w10,	#2
    add	w14,	w10,	#1
    add	x3,	x26,	x4
    lsl	w0,	w24,	#2
    lsl	w17,	w14,	#2
    lsl	w11,	w14,	#2
    add	x25,	x26,	x0
    add	x8,	x1,	x11
    lsl	w0,	w14,	#2
    ldr	w19,	[x25]

    add	x25,	x26,	x0
    ldr	w5,	[x3]

    add	w19,	w5,	w19
    lsl	w5,	w24,	#2
    ldr	w2,	[x25]

    add	x4,	x1,	x5
    add	w7,	w19,	w2
    ldr	w6,	[x4]

    lsl	w4,	w24,	#2
    ldr	w12,	[x8]

    add	w13,	w7,	w6
    lsl	w24,	w10,	#2
    add	x3,	x9,	x4
    lsl	w8,	w10,	#2
    add	w20,	w13,	w12
    add	x7,	x9,	x8
    ldr	w5,	[x3]

    add	x13,	x9,	x17
    ldr	w11,	[x7]

    add	w5,	w20,	w5
    ldr	w18,	[x13]

    add	x20,	x1,	x24
    add	w11,	w5,	w11
    ldr	w25,	[x20]

    add	w18,	w11,	w18
    cmp	w25,	#1
    bne	main_96

main_90:
    cmp	w18,	#2
    bne	main_96

main_92:
    lsl	w13,	w10,	#2
    movz	w2,	#1
    add	x4,	x23,	x13
    str	w2,	[x4]

    b	main_102

main_96:
    cmp	w18,	#3
    bne	main_100

main_98:
    lsl	w19,	w10,	#2
    movz	w4,	#1
    add	x7,	x23,	x19
    str	w4,	[x7]

    b	main_102

main_100:
    lsl	w24,	w10,	#2
    movz	w6,	#0
    add	x10,	x23,	x24
    str	w6,	[x10]


main_102:
    cmp	w14,	w22
    bgt	main_107

main_59:
    mov	w10,	w14
    b	main_60

main_104:
    add	w16,	w3,	#1

main_107:
    cmp	w16,	w21
    bgt	main_176

main_48:
    mov	w3,	w16
    b	main_49

main_176:
    movz	w25,	#2
    b	main_179

main_110:
    movz	w17,	#1
    cmp	w17,	w21
    ble	main_112

main_177:
    movz	w25,	#1
    b	main_179

main_112:
    movz	w14,	#1

main_114:
    movz	w18,	#1
    cmp	w18,	w22
    bgt	main_169

main_117:
    sub	x25,	x14,	#1
    movz	w9,	#2000
    movz	w8,	#2000
    add	x12,	x14,	#1
    movz	w23,	#2000
    movz	w20,	#2000
    movz	w19,	#1
    madd	x6,	x25,	x9,	x15

    madd	x7,	x14,	x8,	x15

    madd	x17,	x12,	x23,	x15

    madd	x24,	x14,	x20,	x27


main_125:
    sub	w10,	w19,	#1
    lsl	w18,	w19,	#2
    add	w2,	w19,	#1
    add	x16,	x6,	x18
    lsl	w0,	w10,	#2
    lsl	w13,	w10,	#2
    lsl	w5,	w2,	#2
    add	x26,	x7,	x0
    add	x11,	x6,	x13
    add	x4,	x7,	x5
    ldr	w1,	[x11]

    ldr	w20,	[x16]

    add	w9,	w20,	w1
    lsl	w20,	w2,	#2
    add	x18,	x6,	x20
    ldr	w23,	[x18]

    lsl	w18,	w10,	#2
    ldr	w1,	[x26]

    add	w23,	w9,	w23
    lsl	w10,	w19,	#2
    add	x16,	x17,	x18
    lsl	w26,	w19,	#2
    ldr	w8,	[x4]

    add	w3,	w23,	w1
    add	x25,	x17,	x26
    lsl	w4,	w2,	#2
    ldr	w20,	[x16]

    add	w9,	w3,	w8
    ldr	w0,	[x25]

    add	x3,	x17,	x4
    add	w13,	w9,	w20
    ldr	w5,	[x3]

    add	x9,	x7,	x10
    add	w25,	w13,	w0
    ldr	w11,	[x9]

    add	w3,	w25,	w5
    cmp	w11,	#1
    bne	main_161

main_155:
    cmp	w3,	#2
    bne	main_161

main_157:
    lsl	w26,	w19,	#2
    movz	w8,	#1
    add	x18,	x24,	x26
    str	w8,	[x18]

    b	main_167

main_161:
    cmp	w3,	#3
    bne	main_165

main_163:
    lsl	w3,	w19,	#2
    movz	w10,	#1
    add	x23,	x24,	x3
    str	w10,	[x23]

    b	main_167

main_165:
    lsl	w5,	w19,	#2
    movz	w13,	#0
    add	x26,	x24,	x5
    str	w13,	[x26]


main_167:
    cmp	w2,	w22
    bgt	main_172

main_124:
    mov	w19,	w2
    b	main_125

main_169:
    add	w12,	w14,	#1

main_172:
    cmp	w12,	w21
    bgt	main_178

main_113:
    mov	w14,	w12
    b	main_114

main_178:
    movz	w25,	#1

main_179:
    sub	w28,	w28,	#1
    cmp	w28,	#0
    bgt	main_41
    b	main_185

main_183:
    movz	w25,	#1

main_185:
    movz	w0,	#106
    bl	_sysy_stoptime
    cmp	w25,	#2
    bne	main_210

main_188:
    movz	w20,	#1
    cmp	w20,	w21
    bgt	main_210

main_190:
    movz	w3,	#1

main_192:
    movz	w17,	#2000
    movz	w16,	#2000
    movz	fp,	#16976
    mul	w14,	w3,	w17
    mul	w16,	w3,	w16
    movk	fp,	#15,	lsl #16
    movz	w17,	#1
    mov	x20,	x14
    mov	x13,	x16
    add	x20,	sp,	x20
    add	x13,	sp,	x13
    add	x20,	x20,	#16
    add	x13,	x13,	fp

main_196:
    cmp	w17,	w22
    bgt	main_204

main_199:
    lsl	w2,	w17,	#2
    lsl	w5,	w17,	#2
    add	w17,	w17,	#1
    add	x4,	x13,	x5
    add	x28,	x20,	x2
    ldr	w6,	[x4]

    str	w6,	[x28]

    b	main_196

main_204:
    add	w3,	w3,	#1
    cmp	w3,	w21
    ble	main_192

main_210:
    movz	w27,	#1
    cmp	w27,	w21
    bgt	main_237

main_212:
    movz	w24,	#1

main_214:
    movz	w20,	#1
    cmp	w20,	w22
    bgt	main_232

main_217:
    movz	w23,	#2000
    movz	w26,	#1
    mul	w2,	w24,	w23
    mov	x25,	x2
    add	x25,	sp,	x25
    add	x25,	x25,	#16

main_220:
    lsl	w0,	w26,	#2
    add	x28,	x25,	x0
    ldr	w1,	[x28]

    cmp	w1,	#1
    bne	main_226

main_225:
    movz	w0,	#35
    bl	putch
    b	main_227

main_226:
    movz	w0,	#46
    bl	putch

main_227:
    add	w26,	w26,	#1
    cmp	w26,	w22
    ble	main_220

main_232:
    movz	w0,	#10
    bl	putch
    add	w24,	w24,	#1
    cmp	w24,	w21
    ble	main_214

main_237:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#33936
    movk	fp,	#30,	lsl #16
    add	sp, sp, fp
    ret


