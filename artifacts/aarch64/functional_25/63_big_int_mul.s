.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #544
    stp	fp, lr, [sp, #0]
    
    movz	w25,	#0
    movz	w20,	#1
    movz	w18,	#3
    movz	w19,	#2
    add	x0,	sp,	#184
    add	x21,	sp,	#208
    movz	w26,	#9
    movz	w2,	#4
    movz	w24,	#1
    add	x28,	sp,	#180
    add	x22,	sp,	#212
    add	x23,	sp,	#216
    add	x27,	sp,	#176
    add	x1,	sp,	#188
    str	w20,	[x27]

    movz	w27,	#8
    add	x20,	sp,	#204
    str	w19,	[x28]

    movz	w28,	#7
    add	x19,	sp,	#196
    str	w18,	[x0]

    movz	w0,	#6
    add	x18,	sp,	#192
    str	w2,	[x1]

    movz	w2,	#8
    movz	w1,	#5
    str	w1,	[x18]

    add	x1,	sp,	#240
    movz	w18,	#7
    str	w0,	[x19]

    add	x0,	sp,	#236
    add	x19,	sp,	#200
    str	w28,	[x19]

    movz	w19,	#6
    add	x28,	sp,	#232
    str	w27,	[x20]

    movz	w20,	#5
    add	x27,	sp,	#228
    str	w26,	[x21]

    movz	w21,	#4
    add	x26,	sp,	#224
    str	w25,	[x22]

    movz	w22,	#3
    add	x25,	sp,	#220
    str	w24,	[x23]

    movz	w24,	#5
    movz	w23,	#2
    str	w23,	[x25]

    movz	w25,	#2
    add	x23,	sp,	#268
    str	w22,	[x26]

    movz	w26,	#4
    add	x22,	sp,	#264
    str	w21,	[x27]

    add	x21,	sp,	#260
    movz	w27,	#3
    str	w20,	[x28]

    movz	w28,	#2
    add	x20,	sp,	#252
    str	w19,	[x0]

    movz	w0,	#0
    add	x19,	sp,	#248
    str	w18,	[x1]

    movz	w1,	#9
    add	x18,	sp,	#244
    str	w2,	[x18]

    movz	w18,	#9
    add	x2,	sp,	#296
    str	w1,	[x19]

    movz	w19,	#1
    add	x1,	sp,	#292
    str	w0,	[x20]

    add	x0,	sp,	#288
    add	x20,	sp,	#256
    str	w28,	[x20]

    movz	w20,	#0
    add	x28,	sp,	#284
    str	w27,	[x21]

    movz	w21,	#9
    add	x27,	sp,	#280
    str	w26,	[x22]

    movz	w22,	#9
    add	x26,	sp,	#276
    str	w25,	[x23]

    movz	w23,	#7
    add	x25,	sp,	#272
    str	w24,	[x25]

    movz	w25,	#1
    add	x24,	sp,	#324
    str	w23,	[x26]

    movz	w26,	#2
    add	x23,	sp,	#320
    str	w22,	[x27]

    movz	w27,	#3
    add	x22,	sp,	#316
    str	w21,	[x28]

    movz	w28,	#4
    add	x21,	sp,	#308
    str	w20,	[x0]

    movz	w0,	#6
    add	x20,	sp,	#304
    str	w19,	[x1]

    movz	w1,	#7
    add	x19,	sp,	#300
    str	w18,	[x2]

    movz	w2,	#8
    str	w2,	[x19]

    movz	w2,	#160
    str	w1,	[x20]

    movz	w1,	#0
    str	w0,	[x21]

    add	x0,	sp,	#16
    add	x21,	sp,	#312
    str	w28,	[x21]

    str	w27,	[x22]

    add	x27,	sp,	#332
    str	w26,	[x23]

    movz	w23,	#2
    add	x26,	sp,	#328
    str	w25,	[x24]

    movz	w24,	#2
    str	w24,	[x26]

    str	w23,	[x27]

    bl	memset
    movz	w7,	#0

main_47:
    cmp	w7,	#16
    bge	main_85

main_50:
    lsl	w19,	w7,	#2
    lsl	w21,	w7,	#2
    add	w23,	w7,	#1
    mov	x8,	x19
    mov	x20,	x21
    add	x8,	sp,	x8
    add	x20,	sp,	x20
    add	w0,	w23,	#1
    lsl	w4,	w23,	#2
    lsl	w2,	w23,	#2
    add	x8,	x8,	#336
    add	x20,	x20,	#176
    mov	x3,	x4
    add	w6,	w0,	#1
    mov	x10,	x2
    add	x3,	sp,	x3
    add	x10,	sp,	x10
    ldr	w22,	[x20]

    add	w12,	w6,	#1
    lsl	w14,	w6,	#2
    add	x3,	x3,	#176
    add	x10,	x10,	#336
    str	w22,	[x8]

    lsl	w20,	w12,	#2
    mov	x22,	x14
    lsl	w8,	w0,	#2
    ldr	w5,	[x3]

    mov	x28,	x20
    add	x22,	sp,	x22
    mov	x16,	x8
    str	w5,	[x10]

    add	w20,	w12,	#1
    add	x28,	sp,	x28
    add	x22,	x22,	#336
    add	x16,	sp,	x16
    lsl	w10,	w0,	#2
    lsl	w26,	w20,	#2
    add	x28,	x28,	#336
    add	x16,	x16,	#336
    mov	x9,	x10
    add	x9,	sp,	x9
    add	x9,	x9,	#176
    ldr	w11,	[x9]

    str	w11,	[x16]

    lsl	w16,	w6,	#2
    mov	x6,	x26
    mov	x15,	x16
    add	x6,	sp,	x6
    add	x15,	sp,	x15
    add	x6,	x6,	#336
    add	x15,	x15,	#176
    ldr	w17,	[x15]

    str	w17,	[x22]

    lsl	w22,	w12,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	#176
    ldr	w23,	[x21]

    str	w23,	[x28]

    lsl	w28,	w20,	#2
    mov	x27,	x28
    add	x27,	sp,	x27
    add	x27,	x27,	#176
    ldr	w0,	[x27]

    str	w0,	[x6]

    add	w0,	w20,	#1
    lsl	w5,	w0,	#2
    lsl	w3,	w0,	#2
    mov	x4,	x5
    mov	x14,	x3
    add	x4,	sp,	x4
    add	x14,	sp,	x14
    add	x4,	x4,	#176
    add	x14,	x14,	#336
    ldr	w6,	[x4]

    str	w6,	[x14]

    add	w6,	w0,	#1
    lsl	w11,	w6,	#2
    add	w7,	w6,	#1
    lsl	w9,	w6,	#2
    mov	x10,	x11
    mov	x20,	x9
    add	x10,	sp,	x10
    add	x20,	sp,	x20
    add	x10,	x10,	#176
    add	x20,	x20,	#336
    ldr	w12,	[x10]

    str	w12,	[x20]

    b	main_47

main_85:
    lsl	w11,	w7,	#2
    lsl	w13,	w7,	#2
    mov	x5,	x11
    add	w7,	w7,	#1
    mov	x12,	x13
    add	x5,	sp,	x5
    add	x12,	sp,	x12
    add	x5,	x5,	#336
    add	x12,	x12,	#176
    ldr	w14,	[x12]

    str	w14,	[x5]

    cmp	w7,	#20
    blt	main_85

main_92:
    movz	w9,	#0

main_93:
    cmp	w9,	#16
    bge	main_131

main_96:
    lsl	w19,	w9,	#2
    lsl	w21,	w9,	#2
    add	w6,	w9,	#1
    mov	x14,	x19
    mov	x20,	x21
    add	x14,	sp,	x14
    add	x20,	sp,	x20
    add	w12,	w6,	#1
    lsl	w2,	w6,	#2
    lsl	w0,	w6,	#2
    add	x14,	x14,	#436
    add	x20,	x20,	#256
    mov	x1,	x2
    add	w18,	w12,	#1
    lsl	w8,	w12,	#2
    lsl	w6,	w12,	#2
    add	x1,	sp,	x1
    ldr	w22,	[x20]

    mov	x7,	x8
    add	w25,	w18,	#1
    lsl	w12,	w18,	#2
    add	x1,	x1,	#256
    mov	x20,	x6
    str	w22,	[x14]

    add	x7,	sp,	x7
    add	w2,	w25,	#1
    mov	x26,	x12
    add	x20,	sp,	x20
    ldr	w3,	[x1]

    mov	x14,	x0
    add	x7,	x7,	#256
    lsl	w24,	w2,	#2
    add	w12,	w2,	#1
    add	x26,	sp,	x26
    add	x20,	x20,	#436
    add	x14,	sp,	x14
    lsl	w1,	w12,	#2
    add	x26,	x26,	#436
    add	x14,	x14,	#436
    str	w3,	[x14]

    lsl	w14,	w18,	#2
    ldr	w9,	[x7]

    lsl	w18,	w25,	#2
    mov	x13,	x14
    str	w9,	[x20]

    mov	x3,	x18
    add	x13,	sp,	x13
    mov	x9,	x24
    lsl	w20,	w25,	#2
    mov	x18,	x1
    add	x3,	sp,	x3
    add	x9,	sp,	x9
    add	x13,	x13,	#256
    mov	x19,	x20
    add	x18,	sp,	x18
    add	x19,	sp,	x19
    add	x3,	x3,	#436
    add	x9,	x9,	#436
    ldr	w15,	[x13]

    add	x18,	x18,	#436
    add	x19,	x19,	#256
    str	w15,	[x26]

    lsl	w26,	w2,	#2
    ldr	w21,	[x19]

    mov	x25,	x26
    str	w21,	[x3]

    add	x25,	sp,	x25
    lsl	w3,	w12,	#2
    mov	x2,	x3
    add	x25,	x25,	#256
    add	x2,	sp,	x2
    ldr	w27,	[x25]

    add	x2,	x2,	#256
    str	w27,	[x9]

    ldr	w4,	[x2]

    str	w4,	[x18]

    add	w18,	w12,	#1
    lsl	w9,	w18,	#2
    lsl	w7,	w18,	#2
    mov	x8,	x9
    mov	x24,	x7
    add	w9,	w18,	#1
    add	x8,	sp,	x8
    add	x24,	sp,	x24
    add	x8,	x8,	#256
    add	x24,	x24,	#436
    ldr	w10,	[x8]

    str	w10,	[x24]

    b	main_93

main_131:
    lsl	w11,	w9,	#2
    lsl	w13,	w9,	#2
    mov	x15,	x11
    add	w9,	w9,	#1
    mov	x12,	x13
    add	x15,	sp,	x15
    add	x12,	sp,	x12
    add	x15,	x15,	#436
    add	x12,	x12,	#256
    ldr	w14,	[x12]

    str	w14,	[x15]

    cmp	w9,	#20
    blt	main_131

main_138:
    movz	w1,	#0

main_139:
    cmp	w1,	#39
    bgt	main_159

main_142:
    lsl	w19,	w1,	#2
    movz	w20,	#0
    add	w11,	w1,	#1
    movz	w16,	#0
    movz	w12,	#0
    movz	w10,	#0
    movz	w8,	#0
    movz	w6,	#0
    mov	x18,	x19
    add	w14,	w11,	#1
    lsl	w24,	w11,	#2
    add	x18,	sp,	x18
    mov	x21,	x24
    add	w19,	w14,	#1
    lsl	w27,	w14,	#2
    add	x18,	x18,	#16
    add	x21,	sp,	x21
    movz	w14,	#0
    mov	x24,	x27
    add	w23,	w19,	#1
    lsl	w1,	w19,	#2
    str	w20,	[x18]

    add	x21,	x21,	#16
    add	x24,	sp,	x24
    mov	x27,	x1
    add	w26,	w23,	#1
    lsl	w4,	w23,	#2
    movz	w18,	#0
    add	x27,	sp,	x27
    add	x24,	x24,	#16
    mov	x1,	x4
    add	w0,	w26,	#1
    lsl	w7,	w26,	#2
    str	w18,	[x21]

    add	x27,	x27,	#16
    add	x1,	sp,	x1
    mov	x4,	x7
    add	w3,	w0,	#1
    str	w16,	[x24]

    add	x4,	sp,	x4
    str	w14,	[x27]

    add	x1,	x1,	#16
    lsl	w13,	w3,	#2
    add	x4,	x4,	#16
    mov	x11,	x13
    str	w12,	[x1]

    add	x11,	sp,	x11
    add	w1,	w3,	#1
    str	w10,	[x4]

    add	x11,	x11,	#16
    lsl	w10,	w0,	#2
    mov	x7,	x10
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    str	w8,	[x7]

    str	w6,	[x11]

    b	main_139

main_159:
    movz	w25,	#19
    movz	w23,	#39

main_161:
    lsl	w15,	w25,	#2
    movz	w1,	#19
    mov	x14,	x15
    add	x14,	sp,	x14
    add	x14,	x14,	#436
    ldr	w3,	[x14]


main_167:
    lsl	w26,	w23,	#2
    lsl	w0,	w1,	#2
    mov	x22,	x26
    mov	x28,	x0
    add	x22,	sp,	x22
    add	x28,	sp,	x28
    add	x22,	x22,	#16
    add	x28,	x28,	#336
    ldr	w6,	[x22]

    ldr	w2,	[x28]

    madd	w5,	w2,	w3,	w6

    cmp	w5,	#10
    blt	main_183

main_177:
    str	w5,	[x22]

    sub	w14,	w23,	#1
    movz	w21,	#10
    lsl	w9,	w14,	#2
    sdiv	w26,	w5,	w21
    mov	x19,	x9
    add	x19,	sp,	x19
    add	x19,	x19,	#16
    ldr	w15,	[x19]

    add	w27,	w15,	w26
    str	w27,	[x19]

    b	main_336

main_183:
    str	w5,	[x22]

    sub	w14,	w23,	#1
    lsl	w16,	w14,	#2
    mov	x19,	x16
    add	x19,	sp,	x19
    add	x19,	x19,	#16

main_336:
    sub	w28,	w1,	#1
    ldr	w26,	[x19]

    lsl	w20,	w28,	#2
    mov	x18,	x20
    add	x18,	sp,	x18
    add	x18,	x18,	#336
    ldr	w21,	[x18]

    madd	w7,	w21,	w3,	w26

    cmp	w7,	#10
    blt	main_202

main_186:
    str	w7,	[x19]

    sub	w2,	w14,	#1
    movz	w26,	#10
    lsl	w14,	w2,	#2
    sdiv	w1,	w7,	w26
    mov	x17,	x14
    add	x17,	sp,	x17
    add	x17,	x17,	#16
    ldr	w16,	[x17]

    add	w4,	w16,	w1
    str	w4,	[x17]

    b	main_192

main_202:
    str	w7,	[x19]

    sub	w2,	w14,	#1
    lsl	w20,	w2,	#2
    mov	x17,	x20
    add	x17,	sp,	x17
    add	x17,	x17,	#16

main_192:
    sub	w18,	w28,	#1
    ldr	w20,	[x17]

    lsl	w11,	w18,	#2
    mov	x10,	x11
    add	x10,	sp,	x10
    add	x10,	x10,	#336
    ldr	w12,	[x10]

    madd	w26,	w12,	w3,	w20

    cmp	w26,	#10
    blt	main_221

main_205:
    str	w26,	[x17]

    sub	w5,	w2,	#1
    movz	w1,	#10
    lsl	w4,	w5,	#2
    sdiv	w21,	w26,	w1
    mov	x19,	x4
    add	x19,	sp,	x19
    add	x19,	x19,	#16
    ldr	w10,	[x19]

    add	w22,	w10,	w21
    str	w22,	[x19]

    b	main_211

main_221:
    str	w26,	[x17]

    sub	w5,	w2,	#1
    lsl	w11,	w5,	#2
    mov	x19,	x11
    add	x19,	sp,	x19
    add	x19,	x19,	#16

main_211:
    sub	w27,	w18,	#1
    ldr	w14,	[x19]

    lsl	w1,	w27,	#2
    mov	x0,	x1
    add	x0,	sp,	x0
    add	x0,	x0,	#336
    ldr	w2,	[x0]

    madd	w20,	w2,	w3,	w14

    cmp	w20,	#10
    blt	main_240

main_224:
    str	w20,	[x19]

    sub	w7,	w5,	#1
    movz	w6,	#10
    lsl	w22,	w7,	#2
    sdiv	w12,	w20,	w6
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	#16
    ldr	w1,	[x21]

    add	w13,	w1,	w12
    str	w13,	[x21]

    b	main_230

main_240:
    str	w20,	[x19]

    sub	w7,	w5,	#1
    lsl	w0,	w7,	#2
    mov	x21,	x0
    add	x21,	sp,	x21
    add	x21,	x21,	#16

main_230:
    sub	w1,	w27,	#1
    ldr	w5,	[x21]

    lsl	w20,	w1,	#2
    mov	x19,	x20
    add	x19,	sp,	x19
    add	x19,	x19,	#336
    ldr	w22,	[x19]

    madd	w16,	w22,	w3,	w5

    cmp	w16,	#10
    blt	main_259

main_243:
    str	w16,	[x21]

    sub	w9,	w7,	#1
    movz	w11,	#10
    lsl	w13,	w9,	#2
    sdiv	w2,	w16,	w11
    mov	x23,	x13
    add	x23,	sp,	x23
    add	x23,	x23,	#16
    ldr	w22,	[x23]

    add	w4,	w22,	w2
    str	w4,	[x23]

    b	main_249

main_259:
    str	w16,	[x21]

    sub	w9,	w7,	#1
    lsl	w19,	w9,	#2
    mov	x23,	x19
    add	x23,	sp,	x23
    add	x23,	x23,	#16

main_249:
    sub	w10,	w1,	#1
    ldr	w28,	[x23]

    lsl	w12,	w10,	#2
    mov	x11,	x12
    add	x11,	sp,	x11
    add	x11,	x11,	#336
    ldr	w13,	[x11]

    madd	w12,	w13,	w3,	w28

    cmp	w12,	#10
    blt	main_278

main_262:
    str	w12,	[x23]

    sub	w11,	w9,	#1
    movz	w15,	#10
    lsl	w2,	w11,	#2
    sdiv	w21,	w12,	w15
    mov	x26,	x2
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    ldr	w14,	[x26]

    add	w22,	w14,	w21
    str	w22,	[x26]

    b	main_268

main_278:
    str	w12,	[x23]

    sub	w11,	w9,	#1
    lsl	w9,	w11,	#2
    mov	x26,	x9
    add	x26,	sp,	x26
    add	x26,	x26,	#16

main_268:
    sub	w17,	w10,	#1
    ldr	w21,	[x26]

    lsl	w2,	w17,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	x1,	x1,	#336
    ldr	w4,	[x1]

    madd	w8,	w4,	w3,	w21

    cmp	w8,	#10
    blt	main_297

main_281:
    str	w8,	[x26]

    sub	w18,	w11,	#1
    lsl	w21,	w18,	#2
    mov	x13,	x21
    movz	w21,	#10
    add	x13,	sp,	x13
    sdiv	w12,	w8,	w21
    add	x13,	x13,	#16
    ldr	w7,	[x13]

    add	w14,	w7,	w12
    str	w14,	[x13]

    b	main_287

main_297:
    str	w8,	[x26]

    sub	w18,	w11,	#1
    lsl	w28,	w18,	#2
    mov	x13,	x28
    add	x13,	sp,	x13
    add	x13,	x13,	#16

main_287:
    sub	w10,	w17,	#1
    ldr	w12,	[x13]

    lsl	w22,	w10,	#2
    mov	x21,	x22
    add	x21,	sp,	x21
    add	x21,	x21,	#336
    ldr	w23,	[x21]

    madd	w2,	w23,	w3,	w12

    cmp	w2,	#10
    blt	main_310

main_300:
    str	w2,	[x13]

    sub	w23,	w18,	#1
    movz	w18,	#10
    lsl	w11,	w23,	#2
    sdiv	w13,	w2,	w18
    mov	x26,	x11
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    ldr	w22,	[x26]

    add	w14,	w22,	w13
    str	w14,	[x26]

    b	main_306

main_310:
    str	w2,	[x13]

    sub	w23,	w18,	#1

main_306:
    sub	w1,	w10,	#1
    cmp	w1,	#3
    bgt	main_167

main_314:
    lsl	w11,	w23,	#2
    lsl	w14,	w1,	#2
    mov	x20,	x11
    mov	x13,	x14
    add	x20,	sp,	x20
    add	x13,	sp,	x13
    add	x20,	x20,	#16
    add	x13,	x13,	#336
    ldr	w9,	[x20]

    ldr	w15,	[x13]

    madd	w16,	w15,	w3,	w9

    cmp	w16,	#10
    blt	main_334

main_324:
    str	w16,	[x20]

    sub	w23,	w23,	#1
    movz	w2,	#10
    lsl	w21,	w23,	#2
    sdiv	w24,	w16,	w2
    mov	x5,	x21
    add	x5,	sp,	x5
    add	x5,	x5,	#16
    ldr	w21,	[x5]

    add	w26,	w21,	w24
    str	w26,	[x5]

    b	main_330

main_334:
    str	w16,	[x20]

    sub	w23,	w23,	#1

main_330:
    sub	w1,	w1,	#1
    movz	w5,	#65535
    movk	w5,	#65535,	lsl #16
    cmp	w1,	w5
    bgt	main_314

main_346:
    add	w11,	w23,	#20
    sub	w25,	w25,	#1
    sub	w23,	w11,	#1
    cmp	w25,	w5
    bgt	main_161

main_351:
    add	x3,	sp,	#16
    ldr	w0,	[x3]

    cmp	w0,	#0
    beq	main_356

main_355:
    bl	putint
    movz	w28,	#1
    b	main_357

main_356:
    movz	w28,	#1

main_357:
    cmp	w28,	#32
    bge	main_387

main_360:
    lsl	w27,	w28,	#2
    mov	x26,	x27
    add	x26,	sp,	x26
    add	x26,	x26,	#16
    ldr	w0,	[x26]

    bl	putint
    add	w27,	w28,	#1
    lsl	w25,	w27,	#2
    mov	x24,	x25
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    ldr	w0,	[x24]

    bl	putint
    add	w26,	w27,	#1
    lsl	w0,	w26,	#2
    mov	x28,	x0
    add	x28,	sp,	x28
    add	x28,	x28,	#16
    ldr	w0,	[x28]

    bl	putint
    add	w27,	w26,	#1
    lsl	w21,	w27,	#2
    mov	x20,	x21
    add	x20,	sp,	x20
    add	x20,	x20,	#16
    ldr	w0,	[x20]

    bl	putint
    add	w21,	w27,	#1
    lsl	w25,	w21,	#2
    mov	x24,	x25
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    ldr	w0,	[x24]

    bl	putint
    add	w20,	w21,	#1
    lsl	w0,	w20,	#2
    mov	x28,	x0
    add	x28,	sp,	x28
    add	x28,	x28,	#16
    ldr	w0,	[x28]

    bl	putint
    add	w23,	w20,	#1
    lsl	w21,	w23,	#2
    mov	x20,	x21
    add	x20,	sp,	x20
    add	x20,	x20,	#16
    ldr	w0,	[x20]

    bl	putint
    add	w27,	w23,	#1
    lsl	w25,	w27,	#2
    mov	x24,	x25
    add	x24,	sp,	x24
    add	x24,	x24,	#16
    ldr	w0,	[x24]

    bl	putint
    add	w28,	w27,	#1
    b	main_357

main_387:
    lsl	w26,	w28,	#2
    mov	x25,	x26
    add	x25,	sp,	x25
    add	x25,	x25,	#16
    ldr	w0,	[x25]

    bl	putint
    add	w28,	w28,	#1
    cmp	w28,	#39
    ble	main_387

main_393:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #544
    ret


