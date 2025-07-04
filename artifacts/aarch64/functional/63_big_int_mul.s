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
    sub	sp, sp, #544
    stp	fp, lr, [sp, #0]
    
    movz	w25,	#0
    movz	w19,	#2
    add	x27,	sp,	#16
    add	x0,	sp,	#24
    movz	w2,	#4
    add	x28,	sp,	#20
    movz	w26,	#9
    add	x23,	sp,	#56
    movz	w20,	#1
    add	x21,	sp,	#48
    movz	w18,	#3
    add	x1,	sp,	#28
    add	x22,	sp,	#52
    movz	w24,	#1
    str	w20,	[x27]

    movz	w27,	#8
    add	x20,	sp,	#44
    str	w19,	[x28]

    movz	w28,	#7
    add	x19,	sp,	#36
    str	w18,	[x0]

    movz	w0,	#6
    add	x18,	sp,	#32
    str	w2,	[x1]

    movz	w2,	#8
    movz	w1,	#5
    str	w1,	[x18]

    movz	w18,	#7
    add	x1,	sp,	#80
    str	w0,	[x19]

    add	x0,	sp,	#76
    add	x19,	sp,	#40
    str	w28,	[x19]

    movz	w19,	#6
    add	x28,	sp,	#72
    str	w27,	[x20]

    movz	w20,	#5
    add	x27,	sp,	#68
    str	w26,	[x21]

    movz	w21,	#4
    add	x26,	sp,	#64
    str	w25,	[x22]

    add	x25,	sp,	#60
    movz	w22,	#3
    str	w24,	[x23]

    movz	w24,	#5
    movz	w23,	#2
    str	w23,	[x25]

    movz	w25,	#2
    add	x23,	sp,	#108
    str	w22,	[x26]

    movz	w26,	#4
    add	x22,	sp,	#104
    str	w21,	[x27]

    movz	w27,	#3
    add	x21,	sp,	#100
    str	w20,	[x28]

    movz	w28,	#2
    add	x20,	sp,	#92
    str	w19,	[x0]

    movz	w0,	#0
    add	x19,	sp,	#88
    str	w18,	[x1]

    movz	w1,	#9
    add	x18,	sp,	#84
    str	w2,	[x18]

    movz	w18,	#9
    add	x2,	sp,	#136
    str	w1,	[x19]

    movz	w19,	#1
    add	x1,	sp,	#132
    str	w0,	[x20]

    add	x0,	sp,	#128
    add	x20,	sp,	#96
    str	w28,	[x20]

    movz	w20,	#0
    add	x28,	sp,	#124
    str	w27,	[x21]

    movz	w21,	#9
    add	x27,	sp,	#120
    str	w26,	[x22]

    movz	w22,	#9
    add	x26,	sp,	#116
    str	w25,	[x23]

    movz	w23,	#7
    add	x25,	sp,	#112
    str	w24,	[x25]

    movz	w25,	#1
    add	x24,	sp,	#164
    str	w23,	[x26]

    movz	w26,	#2
    add	x23,	sp,	#160
    str	w22,	[x27]

    movz	w27,	#3
    add	x22,	sp,	#156
    str	w21,	[x28]

    movz	w28,	#4
    add	x21,	sp,	#148
    str	w20,	[x0]

    movz	w0,	#6
    add	x20,	sp,	#144
    str	w19,	[x1]

    movz	w1,	#7
    add	x19,	sp,	#140
    str	w18,	[x2]

    movz	w2,	#8
    str	w2,	[x19]

    movz	w2,	#160
    str	w1,	[x20]

    movz	w1,	#0
    str	w0,	[x21]

    add	x0,	sp,	#376
    add	x21,	sp,	#152
    str	w28,	[x21]

    str	w27,	[x22]

    add	x27,	sp,	#172
    str	w26,	[x23]

    movz	w23,	#2
    add	x26,	sp,	#168
    str	w25,	[x24]

    movz	w24,	#2
    str	w24,	[x26]

    str	w23,	[x27]

    bl	memset
    movz	w7,	#0

main_47:
    cmp	w7,	#16
    blt	main_50

main_85:
    lsl	w19,	w7,	#2
    lsl	w21,	w7,	#2
    mov	x8,	x19
    add	w7,	w7,	#1
    mov	x20,	x21
    add	x8,	sp,	x8
    add	x20,	sp,	x20
    add	x8,	x8,	#176
    add	x20,	x20,	#16
    ldr	w22,	[x20]

    str	w22,	[x8]

    cmp	w7,	#20
    blt	main_85

main_92:
    movz	w9,	#0

main_93:
    cmp	w9,	#16
    blt	main_96

main_131:
    lsl	w27,	w9,	#2
    lsl	w0,	w9,	#2
    mov	x18,	x27
    add	w9,	w9,	#1
    mov	x28,	x0
    add	x18,	sp,	x18
    add	x28,	sp,	x28
    add	x18,	x18,	#276
    add	x28,	x28,	#96
    ldr	w1,	[x28]

    str	w1,	[x18]

    cmp	w9,	#20
    blt	main_131

main_138:
    movz	w1,	#0

main_139:
    cmp	w1,	#39
    ble	main_142

main_159:
    movz	w25,	#19
    movz	w5,	#39

main_161:
    lsl	w3,	w25,	#2
    movz	w13,	#19
    mov	x2,	x3
    add	x2,	sp,	x2
    add	x2,	x2,	#276
    ldr	w11,	[x2]


main_167:
    lsl	w2,	w5,	#2
    lsl	w6,	w13,	#2
    mov	x14,	x2
    mov	x4,	x6
    add	x14,	sp,	x14
    add	x4,	sp,	x4
    add	x14,	x14,	#376
    add	x4,	x4,	#176
    ldr	w20,	[x14]

    ldr	w7,	[x4]

    madd	w4,	w7,	w11,	w20

    cmp	w4,	#10
    bge	main_177

main_183:
    str	w4,	[x14]

    sub	w18,	w5,	#1
    lsl	w14,	w18,	#2
    mov	x23,	x14
    add	x23,	sp,	x23
    add	x23,	x23,	#376
    b	main_336

main_177:
    str	w4,	[x14]

    sub	w18,	w5,	#1
    movz	w0,	#10
    lsl	w17,	w18,	#2
    sdiv	w0,	w4,	w0
    mov	x23,	x17
    add	x23,	sp,	x23
    add	x23,	x23,	#376
    ldr	w21,	[x23]

    add	w1,	w21,	w0
    str	w1,	[x23]


main_336:
    sub	w20,	w13,	#1
    ldr	w9,	[x23]

    lsl	w26,	w20,	#2
    mov	x24,	x26
    add	x24,	sp,	x24
    add	x24,	x24,	#176
    ldr	w27,	[x24]

    madd	w0,	w27,	w11,	w9

    cmp	w0,	#10
    bge	main_186

main_202:
    str	w0,	[x23]

    sub	w16,	w18,	#1
    lsl	w24,	w16,	#2
    mov	x21,	x24
    add	x21,	sp,	x21
    add	x21,	x21,	#376
    b	main_192

main_186:
    str	w0,	[x23]

    sub	w16,	w18,	#1
    movz	w1,	#10
    lsl	w28,	w16,	#2
    sdiv	w9,	w0,	w1
    mov	x21,	x28
    add	x21,	sp,	x21
    add	x21,	x21,	#376
    ldr	w14,	[x21]

    add	w10,	w14,	w9
    str	w10,	[x21]


main_192:
    sub	w3,	w20,	#1
    ldr	w4,	[x21]

    lsl	w15,	w3,	#2
    mov	x14,	x15
    add	x14,	sp,	x14
    add	x14,	x14,	#176
    ldr	w17,	[x14]

    madd	w26,	w17,	w11,	w4

    cmp	w26,	#10
    bge	main_205

main_221:
    str	w26,	[x21]

    sub	w18,	w16,	#1
    lsl	w14,	w18,	#2
    mov	x23,	x14
    add	x23,	sp,	x23
    add	x23,	x23,	#376
    b	main_211

main_205:
    str	w26,	[x21]

    sub	w18,	w16,	#1
    movz	w5,	#10
    lsl	w17,	w18,	#2
    sdiv	w1,	w26,	w5
    mov	x23,	x17
    add	x23,	sp,	x23
    add	x23,	x23,	#376
    ldr	w7,	[x23]

    add	w2,	w7,	w1
    str	w2,	[x23]


main_211:
    sub	w8,	w3,	#1
    ldr	w28,	[x23]

    lsl	w6,	w8,	#2
    mov	x5,	x6
    add	x5,	sp,	x5
    add	x5,	x5,	#176
    ldr	w7,	[x5]

    madd	w17,	w7,	w11,	w28

    cmp	w17,	#10
    bge	main_224

main_240:
    str	w17,	[x23]

    sub	w20,	w18,	#1
    lsl	w4,	w20,	#2
    mov	x26,	x4
    add	x26,	sp,	x26
    add	x26,	x26,	#376
    b	main_230

main_224:
    str	w17,	[x23]

    sub	w20,	w18,	#1
    movz	w9,	#10
    lsl	w7,	w20,	#2
    sdiv	w19,	w17,	w9
    mov	x26,	x7
    add	x26,	sp,	x26
    add	x26,	x26,	#376
    ldr	w28,	[x26]

    add	w21,	w28,	w19
    str	w21,	[x26]


main_230:
    sub	w5,	w8,	#1
    ldr	w17,	[x26]

    lsl	w27,	w5,	#2
    mov	x24,	x27
    add	x24,	sp,	x24
    add	x24,	x24,	#176
    ldr	w28,	[x24]

    madd	w12,	w28,	w11,	w17

    cmp	w12,	#10
    bge	main_243

main_259:
    str	w12,	[x26]

    sub	w22,	w20,	#1
    lsl	w23,	w22,	#2
    mov	x28,	x23
    add	x28,	sp,	x28
    add	x28,	x28,	#376
    b	main_249

main_243:
    str	w12,	[x26]

    sub	w22,	w20,	#1
    movz	w14,	#10
    lsl	w27,	w22,	#2
    sdiv	w10,	w12,	w14
    mov	x28,	x27
    add	x28,	sp,	x28
    add	x28,	x28,	#376
    ldr	w19,	[x28]

    add	w12,	w19,	w10
    str	w12,	[x28]


main_249:
    sub	w21,	w5,	#1
    ldr	w12,	[x28]

    lsl	w16,	w21,	#2
    mov	x15,	x16
    add	x15,	sp,	x15
    add	x15,	x15,	#176
    ldr	w17,	[x15]

    madd	w9,	w17,	w11,	w12

    cmp	w9,	#10
    bge	main_262

main_278:
    str	w9,	[x28]

    sub	w24,	w22,	#1
    lsl	w13,	w24,	#2
    mov	x1,	x13
    add	x1,	sp,	x1
    add	x1,	x1,	#376
    b	main_268

main_262:
    str	w9,	[x28]

    sub	w24,	w22,	#1
    movz	w18,	#10
    lsl	w16,	w24,	#2
    sdiv	w3,	w9,	w18
    mov	x1,	x16
    add	x1,	sp,	x1
    add	x1,	x1,	#376
    ldr	w13,	[x1]

    add	w4,	w13,	w3
    str	w4,	[x1]


main_268:
    sub	w27,	w21,	#1
    ldr	w10,	[x1]

    lsl	w8,	w27,	#2
    mov	x7,	x8
    add	x7,	sp,	x7
    add	x7,	x7,	#176
    ldr	w9,	[x7]

    madd	w8,	w9,	w11,	w10

    cmp	w8,	#10
    bge	main_281

main_297:
    str	w8,	[x1]

    sub	w13,	w24,	#1
    lsl	w3,	w13,	#2
    mov	x28,	x3
    add	x28,	sp,	x28
    add	x28,	x28,	#376
    b	main_287

main_281:
    str	w8,	[x1]

    sub	w13,	w24,	#1
    movz	w10,	#10
    lsl	w6,	w13,	#2
    sdiv	w21,	w8,	w10
    mov	x28,	x6
    add	x28,	sp,	x28
    add	x28,	x28,	#376
    ldr	w4,	[x28]

    add	w22,	w4,	w21
    str	w22,	[x28]


main_287:
    sub	w12,	w27,	#1
    ldr	w2,	[x28]

    lsl	w27,	w12,	#2
    mov	x26,	x27
    add	x26,	sp,	x26
    add	x26,	x26,	#176
    ldr	w0,	[x26]

    madd	w2,	w0,	w11,	w2

    cmp	w2,	#10
    bge	main_300

main_310:
    str	w2,	[x28]

    sub	w5,	w13,	#1
    b	main_306

main_300:
    str	w2,	[x28]

    sub	w5,	w13,	#1
    movz	w26,	#10
    lsl	w23,	w5,	#2
    sdiv	w26,	w2,	w26
    mov	x20,	x23
    add	x20,	sp,	x20
    add	x20,	x20,	#376
    ldr	w9,	[x20]

    add	w27,	w9,	w26
    str	w27,	[x20]


main_306:
    sub	w13,	w12,	#1
    cmp	w13,	#3
    bgt	main_167

main_314:
    lsl	w17,	w5,	#2
    lsl	w20,	w13,	#2
    mov	x17,	x17
    mov	x19,	x20
    add	x17,	sp,	x17
    add	x19,	sp,	x19
    add	x17,	x17,	#376
    add	x19,	x19,	#176
    ldr	w26,	[x17]

    ldr	w21,	[x19]

    madd	w8,	w21,	w11,	w26

    cmp	w8,	#10
    bge	main_324

main_334:
    str	w8,	[x17]

    sub	w5,	w5,	#1
    b	main_330

main_324:
    str	w8,	[x17]

    sub	w5,	w5,	#1
    movz	w6,	#10
    lsl	w0,	w5,	#2
    sdiv	w2,	w8,	w6
    mov	x15,	x0
    add	x15,	sp,	x15
    add	x15,	x15,	#376
    ldr	w19,	[x15]

    add	w3,	w19,	w2
    str	w3,	[x15]


main_330:
    sub	w13,	w13,	#1
    movz	w9,	#65535
    movk	w9,	#65535,	lsl #16
    cmp	w13,	w9
    bgt	main_314

main_346:
    add	w27,	w5,	#20
    sub	w25,	w25,	#1
    sub	w5,	w27,	#1
    cmp	w25,	w9
    bgt	main_161

main_351:
    add	x28,	sp,	#376
    ldr	w0,	[x28]

    cmp	w0,	#0
    bne	main_355

main_356:
    movz	w28,	#1
    b	main_357

main_355:
    bl	putint
    movz	w28,	#1

main_357:
    cmp	w28,	#32
    blt	main_360

main_387:
    lsl	w0,	w28,	#2
    mov	x27,	x0
    add	x27,	sp,	x27
    add	x27,	x27,	#376
    ldr	w0,	[x27]

    bl	putint
    add	w28,	w28,	#1
    cmp	w28,	#39
    ble	main_387

main_393:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #544
    ret


main_360:
    lsl	w22,	w28,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	#376
    ldr	w0,	[x21]

    bl	putint
    add	w26,	w28,	#1
    lsl	w18,	w26,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	#376
    ldr	w0,	[x0]

    bl	putint
    add	w28,	w26,	#1
    lsl	w22,	w28,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	#376
    ldr	w0,	[x21]

    bl	putint
    add	w22,	w28,	#1
    lsl	w26,	w22,	#2
    mov	x25,	x26
    add	x25,	sp,	x25
    add	x25,	x25,	#376
    ldr	w0,	[x25]

    bl	putint
    add	w28,	w22,	#1
    lsl	w18,	w28,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	#376
    ldr	w0,	[x0]

    bl	putint
    add	w24,	w28,	#1
    lsl	w22,	w24,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	#376
    ldr	w0,	[x21]

    bl	putint
    add	w28,	w24,	#1
    lsl	w26,	w28,	#2
    mov	x25,	x26
    add	x25,	sp,	x25
    add	x25,	x25,	#376
    ldr	w0,	[x25]

    bl	putint
    add	w20,	w28,	#1
    lsl	w18,	w20,	#2
    mov	x0,	x18
    add	x0,	sp,	x0
    add	x0,	x0,	#376
    ldr	w0,	[x0]

    bl	putint
    add	w28,	w20,	#1
    b	main_357

main_142:
    lsl	w14,	w1,	#2
    movz	w8,	#0
    add	w17,	w1,	#1
    movz	w6,	#0
    movz	w4,	#0
    movz	w2,	#0
    movz	w0,	#0
    mov	x18,	x14
    add	w20,	w17,	#1
    lsl	w15,	w17,	#2
    add	x18,	sp,	x18
    mov	x16,	x15
    add	x16,	sp,	x16
    add	w23,	w20,	#1
    add	x18,	x18,	#376
    add	x16,	x16,	#376
    add	w26,	w23,	#1
    lsl	w21,	w23,	#2
    str	w8,	[x18]

    movz	w23,	#0
    mov	x22,	x21
    lsl	w18,	w20,	#2
    add	w3,	w26,	#1
    lsl	w24,	w26,	#2
    str	w6,	[x16]

    add	x22,	sp,	x22
    mov	x19,	x18
    mov	x25,	x24
    add	w5,	w3,	#1
    lsl	w27,	w3,	#2
    add	x22,	x22,	#376
    add	x19,	sp,	x19
    add	x25,	sp,	x25
    mov	x28,	x27
    add	w8,	w5,	#1
    lsl	w1,	w5,	#2
    add	x19,	x19,	#376
    movz	w27,	#0
    add	x28,	sp,	x28
    add	x25,	x25,	#376
    str	w4,	[x19]

    add	x28,	x28,	#376
    lsl	w4,	w8,	#2
    str	w2,	[x22]

    mov	x5,	x4
    mov	x2,	x1
    str	w0,	[x25]

    add	x5,	sp,	x5
    add	w1,	w8,	#1
    add	x2,	sp,	x2
    movz	w25,	#0
    str	w27,	[x28]

    add	x5,	x5,	#376
    add	x2,	x2,	#376
    str	w25,	[x2]

    str	w23,	[x5]

    b	main_139

main_96:
    lsl	w10,	w9,	#2
    lsl	w12,	w9,	#2
    add	w26,	w9,	#1
    mov	x0,	x10
    mov	x11,	x12
    add	x0,	sp,	x0
    add	x11,	sp,	x11
    add	w3,	w26,	#1
    lsl	w15,	w26,	#2
    add	x0,	x0,	#276
    mov	x14,	x15
    add	x11,	x11,	#96
    add	x14,	sp,	x14
    add	w10,	w3,	#1
    lsl	w21,	w3,	#2
    mov	x20,	x21
    ldr	w13,	[x11]

    add	x14,	x14,	#96
    lsl	w27,	w10,	#2
    add	x20,	sp,	x20
    str	w13,	[x0]

    ldr	w16,	[x14]

    lsl	w13,	w26,	#2
    add	x20,	x20,	#96
    mov	x26,	x27
    mov	x19,	x13
    add	x26,	sp,	x26
    add	x19,	sp,	x19
    add	x26,	x26,	#96
    add	x19,	x19,	#276
    str	w16,	[x19]

    ldr	w22,	[x20]

    lsl	w19,	w3,	#2
    add	w20,	w10,	#1
    mov	x25,	x19
    add	x25,	sp,	x25
    lsl	w4,	w20,	#2
    add	x25,	x25,	#276
    mov	x3,	x4
    add	x3,	sp,	x3
    str	w22,	[x25]

    add	x3,	x3,	#96
    ldr	w28,	[x26]

    lsl	w25,	w10,	#2
    add	w26,	w20,	#1
    mov	x2,	x25
    add	x2,	sp,	x2
    lsl	w10,	w26,	#2
    lsl	w8,	w26,	#2
    mov	x9,	x10
    mov	x17,	x8
    add	x2,	x2,	#276
    add	x9,	sp,	x9
    add	x17,	sp,	x17
    str	w28,	[x2]

    add	x9,	x9,	#96
    add	x17,	x17,	#276
    ldr	w5,	[x3]

    lsl	w2,	w20,	#2
    add	w3,	w26,	#1
    mov	x11,	x2
    add	x11,	sp,	x11
    add	w10,	w3,	#1
    lsl	w16,	w3,	#2
    lsl	w14,	w3,	#2
    mov	x15,	x16
    add	x11,	x11,	#276
    mov	x23,	x14
    lsl	w22,	w10,	#2
    lsl	w20,	w10,	#2
    add	x15,	sp,	x15
    add	x23,	sp,	x23
    str	w5,	[x11]

    mov	x21,	x22
    mov	x0,	x20
    ldr	w11,	[x9]

    add	x15,	x15,	#96
    add	x23,	x23,	#276
    add	x21,	sp,	x21
    add	x0,	sp,	x0
    add	w9,	w10,	#1
    str	w11,	[x17]

    ldr	w17,	[x15]

    add	x21,	x21,	#96
    add	x0,	x0,	#276
    str	w17,	[x23]

    ldr	w23,	[x21]

    str	w23,	[x0]

    b	main_93

main_50:
    lsl	w1,	w7,	#2
    lsl	w3,	w7,	#2
    add	w26,	w7,	#1
    mov	x27,	x1
    mov	x2,	x3
    add	x27,	sp,	x27
    add	x2,	sp,	x2
    lsl	w5,	w26,	#2
    lsl	w3,	w26,	#2
    add	x27,	x27,	#176
    mov	x15,	x3
    add	x2,	x2,	#16
    add	w3,	w26,	#1
    add	x15,	sp,	x15
    ldr	w4,	[x2]

    lsl	w11,	w3,	#2
    lsl	w9,	w3,	#2
    add	x15,	x15,	#176
    str	w4,	[x27]

    mov	x10,	x11
    mov	x21,	x9
    mov	x4,	x5
    add	x10,	sp,	x10
    add	w9,	w3,	#1
    add	x21,	sp,	x21
    add	x4,	sp,	x4
    add	x10,	x10,	#16
    lsl	w17,	w9,	#2
    add	x21,	x21,	#176
    add	x4,	x4,	#16
    mov	x16,	x17
    add	x16,	sp,	x16
    ldr	w6,	[x4]

    str	w6,	[x15]

    add	x16,	x16,	#16
    lsl	w15,	w9,	#2
    ldr	w12,	[x10]

    mov	x27,	x15
    str	w12,	[x21]

    add	x27,	sp,	x27
    ldr	w18,	[x16]

    add	w16,	w9,	#1
    add	x27,	x27,	#176
    lsl	w23,	w16,	#2
    lsl	w21,	w16,	#2
    str	w18,	[x27]

    mov	x22,	x23
    mov	x4,	x21
    add	x22,	sp,	x22
    add	x4,	sp,	x4
    add	x22,	x22,	#16
    add	x4,	x4,	#176
    ldr	w24,	[x22]

    str	w24,	[x4]

    add	w24,	w16,	#1
    add	w3,	w24,	#1
    lsl	w0,	w24,	#2
    lsl	w27,	w24,	#2
    mov	x28,	x0
    mov	x12,	x27
    add	x28,	sp,	x28
    add	w9,	w3,	#1
    lsl	w6,	w3,	#2
    lsl	w4,	w3,	#2
    add	x12,	sp,	x12
    add	x28,	x28,	#16
    mov	x5,	x6
    lsl	w10,	w9,	#2
    mov	x19,	x4
    add	x12,	x12,	#176
    add	x5,	sp,	x5
    ldr	w1,	[x28]

    mov	x25,	x10
    add	x19,	sp,	x19
    add	x25,	sp,	x25
    add	x5,	x5,	#16
    str	w1,	[x12]

    lsl	w12,	w9,	#2
    add	x19,	x19,	#176
    add	x25,	x25,	#176
    ldr	w7,	[x5]

    mov	x11,	x12
    add	x11,	sp,	x11
    str	w7,	[x19]

    add	w7,	w9,	#1
    add	x11,	x11,	#16
    ldr	w13,	[x11]

    str	w13,	[x25]

    b	main_47

