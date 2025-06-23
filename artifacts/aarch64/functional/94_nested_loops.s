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
    
    movz	fp,	#57616
    movz	w1,	#0
    movz	w2,	#41984
    add	x0,	sp,	fp
    movk	w2,	#1,	lsl #16
    bl	memset
    movz	w2,	#57600
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    bl	getint
    mov	w22,	w0
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w24,	w0
    bl	getint
    mov	w26,	w0
    bl	getint
    mov	w20,	w0
    bl	getint
    mov	w21,	w0
    bl	getint
    mov	w19,	w0
    bl	getint
    mov	w23,	w0
    bl	getint
    movz	w2,	#0
    add	w11,	w28,	w22

main_13:
    cmp	w2,	w22
    bge	main_82

main_16:
    cmp	w2,	w28
    bge	main_83

main_18:
    movz	w6,	#5760
    add	w16,	w11,	w2
    movz	w18,	#0
    mul	w3,	w2,	w6
    mov	x12,	x3
    add	x12,	sp,	x12
    add	x12,	x12,	#16

main_22:
    movz	w27,	#2880
    add	w3,	w16,	w18
    movz	w13,	#0
    madd	x9,	x18,	x27,	x12


main_27:
    lsl	w1,	w13,	#10
    add	w25,	w3,	w13
    movz	w15,	#0
    sub	w4,	w1,	w13,	lsl #6
    add	x27,	x9,	x4

main_32:
    lsl	w4,	w15,	#8
    add	w17,	w25,	w15
    movz	w6,	#0
    sub	w4,	w4,	w15,	lsl #4
    add	x1,	x27,	x4

main_37:
    lsl	w7,	w6,	#4
    add	w14,	w17,	w6
    add	w5,	w7,	w6,	lsl #5
    add	w6,	w6,	#1
    add	x5,	x1,	x5
    mov	x4,	x5
    add	x10,	x4,	#4
    str	w14,	[x4]

    add	x7,	x5,	#8
    add	w4,	w14,	#1
    str	w4,	[x10]

    add	x10,	x5,	#16
    str	w4,	[x7]

    add	w4,	w4,	#1
    add	x7,	x7,	#4
    add	x8,	x10,	#4
    str	w4,	[x7]

    add	w4,	w14,	#2
    add	w7,	w4,	#1
    str	w4,	[x10]

    add	w10,	w14,	#3
    add	x4,	x5,	#24
    str	w7,	[x8]

    add	x7,	x4,	#4
    add	w8,	w10,	#1
    str	w10,	[x4]

    str	w8,	[x7]

    add	w8,	w14,	#4
    add	x7,	x5,	#32
    add	x5,	x5,	#40
    add	x4,	x7,	#4
    str	w8,	[x7]

    add	w10,	w8,	#1
    add	w7,	w14,	#5
    add	x8,	x5,	#4
    str	w10,	[x4]

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
    movz	w25,	#10752
    movz	fp,	#57616
    mul	w12,	w18,	w25
    movz	w25,	#0
    mov	x27,	x12
    add	x27,	sp,	x27
    add	x27,	x27,	fp

main_89:
    movz	w17,	#5376
    add	w1,	w25,	w18
    movz	w10,	#0
    madd	x22,	x25,	x17,	x27


main_94:
    lsl	w14,	w10,	#11
    movz	w6,	#0
    sub	w11,	w14,	w10,	lsl #8
    add	x5,	x22,	x11

main_98:
    lsl	w2,	w6,	#10
    add	w16,	w1,	w6
    movz	w15,	#0
    sub	w8,	w2,	w6,	lsl #7
    add	w11,	w16,	#6
    add	w12,	w16,	#5
    add	w28,	w16,	#4
    add	w3,	w16,	#3
    add	w14,	w16,	#1
    add	x17,	x5,	x8
    add	w8,	w16,	#2

main_109:
    lsl	w2,	w15,	#8
    sub	w2,	w2,	w15,	lsl #5
    add	w15,	w15,	#1
    add	x9,	x17,	x2
    mov	x7,	x9
    add	x13,	x7,	#12
    add	x4,	x7,	#8
    add	x2,	x7,	#4
    str	w16,	[x7]

    str	w14,	[x2]

    add	x2,	x7,	#16
    str	w8,	[x4]

    add	x4,	x7,	#20
    str	w3,	[x13]

    add	x13,	x7,	#24
    str	w28,	[x2]

    str	w12,	[x4]

    add	x4,	x9,	#28
    str	w11,	[x13]

    add	x2,	x4,	#8
    add	x7,	x4,	#12
    add	x13,	x4,	#4
    str	w16,	[x4]

    str	w14,	[x13]

    add	x13,	x4,	#16
    str	w8,	[x2]

    add	x2,	x4,	#20
    str	w3,	[x7]

    str	w28,	[x13]

    add	x13,	x4,	#24
    str	w12,	[x2]

    add	x4,	x9,	#56
    str	w11,	[x13]

    add	x2,	x4,	#12
    add	x7,	x4,	#4
    add	x13,	x4,	#8
    str	w16,	[x4]

    str	w14,	[x7]

    add	x7,	x4,	#16
    str	w8,	[x13]

    add	x13,	x4,	#20
    str	w3,	[x2]

    str	w28,	[x7]

    str	w12,	[x13]

    add	x13,	x4,	#24
    add	x4,	x9,	#84
    str	w11,	[x13]

    add	x7,	x4,	#8
    add	x2,	x4,	#4
    add	x13,	x4,	#12
    str	w16,	[x4]

    str	w14,	[x2]

    add	x2,	x4,	#16
    str	w8,	[x7]

    add	x7,	x4,	#20
    str	w3,	[x13]

    add	x13,	x4,	#24
    str	w28,	[x2]

    add	x4,	x9,	#112
    str	w12,	[x7]

    str	w11,	[x13]

    add	x2,	x4,	#8
    add	x7,	x4,	#12
    add	x13,	x4,	#4
    str	w16,	[x4]

    str	w14,	[x13]

    add	x13,	x4,	#16
    str	w8,	[x2]

    add	x2,	x4,	#20
    str	w3,	[x7]

    str	w28,	[x13]

    add	x13,	x4,	#24
    str	w12,	[x2]

    add	x4,	x9,	#140
    str	w11,	[x13]

    add	x7,	x4,	#4
    add	x2,	x4,	#12
    add	x13,	x4,	#8
    str	w16,	[x4]

    str	w14,	[x7]

    add	x7,	x4,	#16
    str	w8,	[x13]

    add	x13,	x4,	#20
    str	w3,	[x2]

    str	w28,	[x7]

    str	w12,	[x13]

    add	x13,	x4,	#24
    add	x4,	x9,	#168
    add	x9,	x9,	#196
    str	w11,	[x13]

    add	x7,	x4,	#8
    add	x2,	x4,	#4
    add	x13,	x4,	#12
    str	w16,	[x4]

    str	w14,	[x2]

    add	x2,	x4,	#16
    str	w8,	[x7]

    add	x7,	x4,	#20
    str	w3,	[x13]

    add	x13,	x4,	#24
    str	w28,	[x2]

    add	x4,	x9,	#16
    add	x2,	x9,	#12
    str	w12,	[x7]

    add	x7,	x9,	#4
    str	w11,	[x13]

    add	x13,	x9,	#8
    str	w16,	[x9]

    str	w14,	[x7]

    add	x7,	x9,	#20
    str	w8,	[x13]

    add	x13,	x9,	#24
    str	w3,	[x2]

    str	w28,	[x4]

    str	w12,	[x7]

    str	w11,	[x13]

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
    add	w25,	w25,	#1
    cmp	w25,	#2
    blt	main_89

main_187:
    add	w18,	w18,	#1
    cmp	w18,	#10
    blt	main_85

main_190:
    movz	w9,	#0
    mov	w2,	w9
    movz	w9,	#0

main_192:
    cmp	w2,	#10
    bge	main_292

main_196:
    movz	w28,	#5760
    movz	w3,	#10752
    movz	fp,	#57616
    movz	w1,	#0
    mul	w15,	w2,	w28
    mul	w17,	w2,	w3
    mov	x12,	x15
    mov	x3,	x17
    mov	w15,	w1
    add	x12,	sp,	x12
    add	x3,	sp,	x3
    add	x12,	x12,	#16
    add	x3,	x3,	fp

main_200:
    cmp	x15,	#100
    bge	main_286

main_204:
    movz	w4,	#2880
    movz	w7,	#5376
    movz	w17,	#0
    madd	x10,	x15,	x4,	x12

    madd	x13,	x15,	x7,	x3

    mov	w25,	w17

main_208:
    cmp	w25,	#1000
    bge	main_280

main_212:
    lsl	w5,	w25,	#10
    lsl	w6,	w25,	#11
    movz	w7,	#0
    sub	w5,	w5,	w25,	lsl #6
    sub	w27,	w6,	w25,	lsl #8
    mov	w4,	w7
    add	x14,	x10,	x5
    add	x8,	x13,	x27

main_216:
    movz	w11,	#10000
    cmp	w4,	w11
    bge	main_274

main_220:
    lsl	w17,	w4,	#8
    lsl	w28,	w4,	#10
    movz	w18,	#0
    sub	w6,	w17,	w4,	lsl #4
    sub	w28,	w28,	w4,	lsl #7
    mov	w11,	w18
    add	x27,	x14,	x6
    add	x16,	x8,	x28

main_224:
    movz	w7,	#34464
    movk	w7,	#1,	lsl #16
    cmp	w11,	w7
    bge	main_268

main_228:
    lsl	w6,	w11,	#4
    lsl	w1,	w11,	#8
    add	w17,	w6,	w11,	lsl #5
    sub	w1,	w1,	w11,	lsl #5
    movz	w6,	#0
    add	x18,	x27,	x17
    add	x7,	x16,	x1

main_232:
    movz	w1,	#16960
    movk	w1,	#15,	lsl #16
    cmp	w6,	w1
    bge	main_262

main_236:
    lsl	w17,	w6,	#3
    lsl	w5,	w6,	#5
    add	x1,	x18,	x17
    sub	w28,	w5,	w6,	lsl #2
    movz	w17,	#0
    mov	w5,	w17
    add	x28,	x7,	x28

main_240:
    movz	w22,	#38528
    movk	w22,	#152,	lsl #16
    cmp	w5,	w22
    bge	main_256

main_244:
    movz	w22,	#817
    sdiv	w17,	w9,	w22
    movz	w22,	#817
    msub	w17,	w17,	w22,	w9

    lsl	w22,	w5,	#2
    add	x9,	x1,	x22
    ldr	w9,	[x9]

    add	w22,	w9,	w17
    lsl	w17,	w5,	#2
    add	x9,	x28,	x17
    add	w17,	w5,	#1
    ldr	w9,	[x9]

    add	w9,	w22,	w9
    cmp	w17,	w0
    bge	main_256

main_239:
    mov	w5,	w17
    b	main_240

main_256:
    add	w1,	w6,	#1
    cmp	w1,	w23
    bge	main_262

main_231:
    mov	w6,	w1
    b	main_232

main_262:
    add	w28,	w11,	#1
    cmp	w28,	w19
    bge	main_268

main_223:
    mov	w11,	w28
    b	main_224

main_268:
    add	w7,	w4,	#1
    cmp	w7,	w21
    bge	main_274

main_215:
    mov	w4,	w7
    b	main_216

main_274:
    add	w6,	w25,	#1
    cmp	w6,	w20
    bge	main_280

main_207:
    mov	w25,	w6
    b	main_208

main_280:
    add	w22,	w15,	#1
    cmp	w22,	w26
    bge	main_286

main_199:
    mov	w15,	w22
    b	main_200

main_286:
    add	w8,	w2,	#1
    cmp	w8,	w24
    bge	main_292

main_191:
    mov	w2,	w8
    b	main_192

main_292:
    mov	w0,	w9
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#34064
    movk	fp,	#2,	lsl #16
    add	sp, sp, fp
    ret


