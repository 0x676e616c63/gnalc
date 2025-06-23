.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#34064
    movk	fp,	#2,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w1,	#0
    movz	w2,	#41984
    add	x0,	sp,	#16
    movk	w2,	#1,	lsl #16
    bl	memset
    movz	fp,	#42000
    movz	w1,	#0
    movz	w2,	#57600
    movk	fp,	#1,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    bl	getint
    mov	w21,	w0
    bl	getint
    mov	w26,	w0
    bl	getint
    mov	w27,	w0
    bl	getint
    mov	w24,	w0
    bl	getint
    mov	w25,	w0
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w19,	w0
    bl	getint
    mov	w20,	w0
    bl	getint
    movz	w2,	#0
    add	w11,	w26,	w21

main_13:
    cmp	w2,	w21
    bge	main_82

main_16:
    cmp	w2,	w26
    bge	main_83

main_18:
    movz	w6,	#5760
    movz	fp,	#42000
    add	w17,	w11,	w2
    movz	w18,	#0
    mul	w3,	w2,	w6
    movk	fp,	#1,	lsl #16
    mov	x12,	x3
    add	x12,	sp,	x12
    add	x12,	x12,	fp

main_22:
    movz	w23,	#2880
    add	w10,	w17,	w18
    movz	w13,	#0
    madd	x23,	x18,	x23,	x12


main_27:
    lsl	w1,	w13,	#10
    movz	w15,	#0
    sub	w3,	w1,	w13,	lsl #6
    add	x9,	x23,	x3
    add	w3,	w10,	w13

main_32:
    lsl	w4,	w15,	#8
    add	w22,	w3,	w15
    movz	w6,	#0
    sub	w4,	w4,	w15,	lsl #4
    add	x1,	x9,	x4

main_37:
    lsl	w7,	w6,	#4
    add	w16,	w22,	w6
    add	w5,	w7,	w6,	lsl #5
    add	w6,	w6,	#1
    add	x5,	x1,	x5
    mov	x4,	x5
    add	x14,	x4,	#4
    str	w16,	[x4]

    add	x7,	x5,	#8
    add	w4,	w16,	#1
    str	w4,	[x14]

    add	x14,	x5,	#16
    str	w4,	[x7]

    add	w4,	w4,	#1
    add	x7,	x7,	#4
    add	x8,	x14,	#4
    str	w4,	[x7]

    add	w4,	w16,	#2
    add	w7,	w4,	#1
    str	w4,	[x14]

    add	w14,	w16,	#3
    add	x4,	x5,	#24
    str	w7,	[x8]

    add	w8,	w14,	#1
    add	x7,	x4,	#4
    str	w14,	[x4]

    str	w8,	[x7]

    add	w8,	w16,	#4
    add	x7,	x5,	#32
    add	x5,	x5,	#40
    add	x4,	x7,	#4
    str	w8,	[x7]

    add	w14,	w8,	#1
    add	w7,	w16,	#5
    add	x8,	x5,	#4
    str	w14,	[x4]

    add	w4,	w7,	#1
    str	w7,	[x5]

    str	w4,	[x8]

    cmp	w6,	#5
    blt	main_37

main_71:
    add	w15,	w15,	#1
    cmp	w15,	#4
    blt	main_32

main_74:
    add	w13,	w13,	#1
    cmp	w13,	#3
    blt	main_27

main_77:
    add	w18,	w18,	#1
    cmp	w18,	#2
    blt	main_22

main_80:
    add	w2,	w2,	#1
    b	main_13

main_83:
    movz	w18,	#0
    b	main_85

main_82:
    movz	w18,	#0

main_85:
    movz	w22,	#10752
    mul	w12,	w18,	w22
    movz	w22,	#0
    mov	x23,	x12
    add	x23,	sp,	x23
    add	x23,	x23,	#16

main_89:
    movz	w17,	#5376
    add	w1,	w22,	w18
    movz	w10,	#0
    madd	x21,	x22,	x17,	x23


main_94:
    lsl	w14,	w10,	#11
    movz	w6,	#0
    sub	w11,	w14,	w10,	lsl #8
    add	x5,	x21,	x11

main_98:
    lsl	w2,	w6,	#10
    add	w11,	w1,	w6
    movz	w15,	#0
    sub	w8,	w2,	w6,	lsl #7
    add	w4,	w11,	#5
    add	w12,	w11,	#4
    add	w17,	w11,	#3
    add	w16,	w11,	#6
    add	w14,	w11,	#1
    add	w2,	w11,	#2
    add	x8,	x5,	x8

main_109:
    lsl	w3,	w15,	#8
    sub	w3,	w3,	w15,	lsl #5
    add	w15,	w15,	#1
    add	x9,	x8,	x3
    mov	x7,	x9
    add	x13,	x7,	#8
    add	x26,	x7,	#12
    add	x3,	x7,	#4
    str	w11,	[x7]

    str	w14,	[x3]

    add	x3,	x7,	#16
    str	w2,	[x13]

    add	x13,	x7,	#20
    str	w17,	[x26]

    add	x26,	x7,	#24
    str	w12,	[x3]

    add	x7,	x9,	#28
    str	w4,	[x13]

    str	w16,	[x26]

    add	x3,	x7,	#8
    add	x13,	x7,	#12
    add	x26,	x7,	#4
    str	w11,	[x7]

    str	w14,	[x26]

    add	x26,	x7,	#16
    str	w2,	[x3]

    add	x3,	x7,	#20
    str	w17,	[x13]

    str	w12,	[x26]

    add	x26,	x7,	#24
    str	w4,	[x3]

    add	x7,	x9,	#56
    str	w16,	[x26]

    add	x3,	x7,	#12
    add	x13,	x7,	#4
    add	x26,	x7,	#8
    str	w11,	[x7]

    str	w14,	[x13]

    add	x13,	x7,	#16
    str	w2,	[x26]

    add	x26,	x7,	#20
    str	w17,	[x3]

    str	w12,	[x13]

    str	w4,	[x26]

    add	x26,	x7,	#24
    add	x7,	x9,	#84
    str	w16,	[x26]

    add	x13,	x7,	#8
    add	x3,	x7,	#4
    add	x26,	x7,	#12
    str	w11,	[x7]

    str	w14,	[x3]

    add	x3,	x7,	#16
    str	w2,	[x13]

    add	x13,	x7,	#20
    str	w17,	[x26]

    add	x26,	x7,	#24
    str	w12,	[x3]

    add	x7,	x9,	#112
    str	w4,	[x13]

    str	w16,	[x26]

    add	x3,	x7,	#8
    add	x13,	x7,	#12
    add	x26,	x7,	#4
    str	w11,	[x7]

    str	w14,	[x26]

    add	x26,	x7,	#16
    str	w2,	[x3]

    add	x3,	x7,	#20
    str	w17,	[x13]

    str	w12,	[x26]

    add	x26,	x7,	#24
    str	w4,	[x3]

    add	x7,	x9,	#140
    str	w16,	[x26]

    add	x3,	x7,	#12
    add	x13,	x7,	#4
    add	x26,	x7,	#8
    str	w11,	[x7]

    str	w14,	[x13]

    add	x13,	x7,	#16
    str	w2,	[x26]

    add	x26,	x7,	#20
    str	w17,	[x3]

    str	w12,	[x13]

    str	w4,	[x26]

    add	x26,	x7,	#24
    add	x7,	x9,	#168
    str	w16,	[x26]

    add	x13,	x7,	#8
    add	x3,	x7,	#4
    add	x26,	x7,	#12
    str	w11,	[x7]

    str	w14,	[x3]

    add	x3,	x7,	#16
    str	w2,	[x13]

    add	x13,	x7,	#20
    str	w17,	[x26]

    add	x26,	x7,	#24
    str	w12,	[x3]

    str	w4,	[x13]

    add	x13,	x9,	#196
    str	w16,	[x26]

    add	x7,	x13,	#16
    add	x3,	x13,	#12
    add	x9,	x13,	#4
    add	x26,	x13,	#8
    str	w11,	[x13]

    str	w14,	[x9]

    add	x9,	x13,	#20
    str	w2,	[x26]

    add	x26,	x13,	#24
    str	w17,	[x3]

    str	w12,	[x7]

    str	w4,	[x9]

    str	w16,	[x26]

    cmp	w15,	#4
    blt	main_109

main_178:
    add	w6,	w6,	#1
    cmp	w6,	#2
    blt	main_98

main_181:
    add	w10,	w10,	#1
    cmp	w10,	#3
    blt	main_94

main_184:
    add	w22,	w22,	#1
    cmp	w22,	#2
    blt	main_89

main_187:
    add	w18,	w18,	#1
    cmp	w18,	#10
    blt	main_85

main_190:
    movz	w9,	#0
    movz	w1,	#0
    mov	w2,	w9

main_192:
    cmp	w2,	#10
    bge	main_292

main_196:
    movz	w26,	#5760
    movz	fp,	#42000
    movz	w4,	#10752
    movz	w3,	#0
    mul	w15,	w2,	w26
    movk	fp,	#1,	lsl #16
    mul	w17,	w2,	w4
    mov	w5,	w3
    mov	x12,	x15
    mov	x8,	x17
    add	x12,	sp,	x12
    add	x8,	sp,	x8
    add	x12,	x12,	fp
    add	x8,	x8,	#16

main_200:
    cmp	x5,	#100
    bge	main_286

main_204:
    movz	w4,	#2880
    movz	w10,	#5376
    movz	w17,	#0
    madd	x6,	x5,	x4,	x12

    madd	x10,	x5,	x10,	x8

    mov	w26,	w17

main_208:
    cmp	w26,	#1000
    bge	main_280

main_212:
    lsl	w7,	w26,	#10
    lsl	w9,	w26,	#11
    movz	w11,	#0
    sub	w7,	w7,	w26,	lsl #6
    sub	w22,	w9,	w26,	lsl #8
    mov	w17,	w11
    add	x13,	x6,	x7
    add	x14,	x10,	x22

main_216:
    movz	w11,	#10000
    cmp	w17,	w11
    bge	main_274

main_220:
    lsl	w16,	w17,	#8
    lsl	w22,	w17,	#10
    movz	w18,	#0
    sub	w7,	w16,	w17,	lsl #4
    sub	w22,	w22,	w17,	lsl #7
    mov	w9,	w18
    add	x23,	x13,	x7
    add	x16,	x14,	x22

main_224:
    movz	w11,	#34464
    movk	w11,	#1,	lsl #16
    cmp	w9,	w11
    bge	main_268

main_228:
    lsl	w7,	w9,	#4
    lsl	w3,	w9,	#8
    movz	w11,	#0
    add	w15,	w7,	w9,	lsl #5
    sub	w3,	w3,	w9,	lsl #5
    mov	w7,	w11
    add	x4,	x23,	x15
    add	x15,	x16,	x3

main_232:
    movz	w3,	#16960
    movk	w3,	#15,	lsl #16
    cmp	w7,	w3
    bge	main_262

main_236:
    lsl	w18,	w7,	#3
    lsl	w11,	w7,	#5
    movz	w21,	#0
    add	x3,	x4,	x18
    sub	w22,	w11,	w7,	lsl #2
    mov	w18,	w21
    add	x11,	x15,	x22

main_240:
    movz	w22,	#38528
    movk	w22,	#152,	lsl #16
    cmp	w18,	w22
    bge	main_256

main_244:
    movz	w22,	#817
    movz	w21,	#817
    sdiv	w22,	w1,	w22
    msub	w21,	w22,	w21,	w1

    lsl	w22,	w18,	#2
    add	x1,	x3,	x22
    ldr	w1,	[x1]

    add	w22,	w1,	w21
    lsl	w21,	w18,	#2
    add	x1,	x11,	x21
    add	w21,	w18,	#1
    ldr	w1,	[x1]

    add	w1,	w22,	w1
    cmp	w21,	w0
    bge	main_256

main_239:
    mov	w18,	w21
    b	main_240

main_256:
    add	w3,	w7,	#1
    cmp	w3,	w20
    bge	main_262

main_231:
    mov	w7,	w3
    b	main_232

main_262:
    add	w22,	w9,	#1
    cmp	w22,	w19
    bge	main_268

main_223:
    mov	w9,	w22
    b	main_224

main_268:
    add	w11,	w17,	#1
    cmp	w11,	w28
    bge	main_274

main_215:
    mov	w17,	w11
    b	main_216

main_274:
    add	w9,	w26,	#1
    cmp	w9,	w25
    bge	main_280

main_207:
    mov	w26,	w9
    b	main_208

main_280:
    add	w21,	w5,	#1
    cmp	w21,	w24
    bge	main_286

main_199:
    mov	w5,	w21
    b	main_200

main_286:
    add	w9,	w2,	#1
    cmp	w9,	w27
    bge	main_292

main_191:
    mov	w2,	w9
    b	main_192

main_292:
    mov	w0,	w1
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#34064
    movk	fp,	#2,	lsl #16
    add	sp, sp, fp
    ret


