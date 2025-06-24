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
    
    movz	w23,	#16960
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w23,	#15,	lsl #16
    mov	x2,	x23
    bl	memset
    movz	w1,	#0
    mov	x2,	x23
    movz	fp,	#16976
    movk	fp,	#15,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    bl	getint
    mov	w20,	w0
    bl	getint
    mov	w23,	w0
    bl	getint
    mov	w28,	w0
    bl	getch
    movz	w24,	#1
    cmp	w24,	w23
    bgt	main_35

main_8:
    movz	w25,	#1

main_10:
    movz	w13,	#1
    cmp	w13,	w20
    bgt	main_29

main_13:
    movz	w14,	#2000
    movz	fp,	#16976
    movz	w26,	#1
    movk	fp,	#15,	lsl #16
    mul	w11,	w25,	w14
    mov	x19,	x11
    add	x19,	sp,	x19
    add	x19,	x19,	fp

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
    cmp	w26,	w20
    ble	main_16

main_29:
    bl	getch
    add	w25,	w25,	#1
    cmp	w25,	w23
    ble	main_10

main_35:
    movz	w0,	#95
    bl	_sysy_starttime
    cmp	w28,	#0
    ble	main_183

main_37:
    movz	fp,	#16976
    add	x0,	sp,	#16
    movz	w25,	#1
    movk	fp,	#15,	lsl #16
    add	x15,	sp,	fp

main_41:
    cmp	w25,	#1
    bne	main_110

main_45:
    movz	w22,	#1
    cmp	w22,	w23
    ble	main_47

main_175:
    movz	w25,	#2
    b	main_179

main_47:
    movz	w4,	#1

main_49:
    movz	w22,	#1
    cmp	w22,	w20
    bgt	main_104

main_52:
    sub	x6,	x4,	#1
    movz	w27,	#2000
    movz	w26,	#2000
    add	x17,	x4,	#1
    movz	w14,	#2000
    movz	w13,	#2000
    movz	w11,	#1
    madd	x27,	x6,	x27,	x15

    madd	x2,	x4,	x26,	x15

    madd	x10,	x17,	x14,	x15

    madd	x24,	x4,	x13,	x0


main_60:
    sub	w25,	w11,	#1
    lsl	w5,	w11,	#2
    add	w16,	w11,	#1
    add	x4,	x27,	x5
    lsl	w1,	w25,	#2
    lsl	w18,	w16,	#2
    lsl	w12,	w16,	#2
    add	x26,	x27,	x1
    add	x9,	x2,	x12
    lsl	w1,	w16,	#2
    ldr	w21,	[x26]

    add	x26,	x27,	x1
    ldr	w6,	[x4]

    add	w21,	w6,	w21
    lsl	w6,	w25,	#2
    ldr	w3,	[x26]

    add	x5,	x2,	x6
    add	w8,	w21,	w3
    ldr	w7,	[x5]

    lsl	w5,	w25,	#2
    ldr	w13,	[x9]

    add	w14,	w8,	w7
    lsl	w25,	w11,	#2
    add	x4,	x10,	x5
    lsl	w9,	w11,	#2
    add	w22,	w14,	w13
    add	x8,	x10,	x9
    ldr	w6,	[x4]

    add	x14,	x10,	x18
    ldr	w12,	[x8]

    add	w6,	w22,	w6
    ldr	w19,	[x14]

    add	x22,	x2,	x25
    add	w12,	w6,	w12
    ldr	w26,	[x22]

    add	w19,	w12,	w19
    cmp	w26,	#1
    bne	main_96

main_90:
    cmp	w19,	#2
    bne	main_96

main_92:
    lsl	w14,	w11,	#2
    movz	w3,	#1
    add	x5,	x24,	x14
    str	w3,	[x5]

    b	main_102

main_96:
    cmp	w19,	#3
    bne	main_100

main_98:
    lsl	w21,	w11,	#2
    movz	w5,	#1
    add	x8,	x24,	x21
    str	w5,	[x8]

    b	main_102

main_100:
    lsl	w25,	w11,	#2
    movz	w7,	#0
    add	x11,	x24,	x25
    str	w7,	[x11]


main_102:
    cmp	w16,	w20
    bgt	main_107

main_59:
    mov	w11,	w16
    b	main_60

main_104:
    add	w17,	w4,	#1

main_107:
    cmp	w17,	w23
    bgt	main_176

main_48:
    mov	w4,	w17
    b	main_49

main_176:
    movz	w25,	#2
    b	main_179

main_110:
    movz	w18,	#1
    cmp	w18,	w23
    ble	main_112

main_177:
    movz	w25,	#1
    b	main_179

main_112:
    movz	w14,	#1

main_114:
    movz	w19,	#1
    cmp	w19,	w20
    bgt	main_169

main_117:
    sub	x26,	x14,	#1
    movz	w9,	#2000
    movz	w8,	#2000
    add	x12,	x14,	#1
    movz	w22,	#2000
    movz	w21,	#2000
    movz	w19,	#1
    madd	x7,	x26,	x9,	x0

    madd	x18,	x12,	x22,	x0

    madd	x25,	x14,	x21,	x15

    madd	x9,	x14,	x8,	x0


main_125:
    sub	w11,	w19,	#1
    lsl	w21,	w19,	#2
    add	x17,	x7,	x21
    lsl	w1,	w11,	#2
    lsl	w14,	w11,	#2
    add	x27,	x9,	x1
    add	x13,	x7,	x14
    ldr	w2,	[x13]

    ldr	w22,	[x17]

    add	w10,	w22,	w2
    add	w2,	w19,	#1
    lsl	w6,	w2,	#2
    lsl	w22,	w2,	#2
    add	x5,	x9,	x6
    add	x21,	x7,	x22
    ldr	w24,	[x21]

    lsl	w21,	w11,	#2
    ldr	w3,	[x27]

    add	w24,	w10,	w24
    lsl	w11,	w19,	#2
    add	x17,	x18,	x21
    lsl	w27,	w19,	#2
    ldr	w8,	[x5]

    add	w4,	w24,	w3
    add	x26,	x18,	x27
    lsl	w5,	w2,	#2
    ldr	w22,	[x17]

    add	w10,	w4,	w8
    ldr	w1,	[x26]

    add	x4,	x18,	x5
    add	w14,	w10,	w22
    ldr	w6,	[x4]

    add	x10,	x9,	x11
    add	w26,	w14,	w1
    ldr	w13,	[x10]

    add	w4,	w26,	w6
    cmp	w13,	#1
    bne	main_161

main_155:
    cmp	w4,	#2
    bne	main_161

main_157:
    lsl	w27,	w19,	#2
    movz	w8,	#1
    add	x19,	x25,	x27
    str	w8,	[x19]

    b	main_167

main_161:
    cmp	w4,	#3
    bne	main_165

main_163:
    lsl	w4,	w19,	#2
    movz	w10,	#1
    add	x24,	x25,	x4
    str	w10,	[x24]

    b	main_167

main_165:
    lsl	w6,	w19,	#2
    movz	w13,	#0
    add	x27,	x25,	x6
    str	w13,	[x27]


main_167:
    cmp	w2,	w20
    bgt	main_172

main_124:
    mov	w19,	w2
    b	main_125

main_169:
    add	w12,	w14,	#1

main_172:
    cmp	w12,	w23
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
    movz	w21,	#1
    cmp	w21,	w23
    bgt	main_210

main_190:
    movz	w3,	#1

main_192:
    movz	w17,	#2000
    movz	fp,	#16976
    movz	w16,	#2000
    movk	fp,	#15,	lsl #16
    mul	w14,	w3,	w17
    mul	w16,	w3,	w16
    movz	w17,	#1
    mov	x21,	x14
    mov	x13,	x16
    add	x21,	sp,	x21
    add	x13,	sp,	x13
    add	x21,	x21,	fp
    add	x13,	x13,	#16

main_196:
    cmp	w17,	w20
    bgt	main_204

main_199:
    lsl	w2,	w17,	#2
    lsl	w5,	w17,	#2
    add	w17,	w17,	#1
    add	x4,	x13,	x5
    add	x28,	x21,	x2
    ldr	w6,	[x4]

    str	w6,	[x28]

    b	main_196

main_204:
    add	w3,	w3,	#1
    cmp	w3,	w23
    ble	main_192

main_210:
    movz	w27,	#1
    cmp	w27,	w23
    bgt	main_237

main_212:
    movz	w24,	#1

main_214:
    movz	w21,	#1
    cmp	w21,	w20
    bgt	main_232

main_217:
    movz	w22,	#2000
    movz	fp,	#16976
    movz	w26,	#1
    movk	fp,	#15,	lsl #16
    mul	w2,	w24,	w22
    mov	x25,	x2
    add	x25,	sp,	x25
    add	x25,	x25,	fp

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
    cmp	w26,	w20
    ble	main_220

main_232:
    movz	w0,	#10
    bl	putch
    add	w24,	w24,	#1
    cmp	w24,	w23
    ble	main_214

main_237:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#33936
    movk	fp,	#30,	lsl #16
    add	sp, sp, fp
    ret


