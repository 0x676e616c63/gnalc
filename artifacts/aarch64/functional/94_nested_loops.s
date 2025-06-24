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
    mov	w20,	w0
    bl	getint
    mov	w26,	w0
    bl	getint
    mov	w25,	w0
    bl	getint
    mov	w19,	w0
    bl	getint
    mov	w27,	w0
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w21,	w0
    bl	getint
    mov	w22,	w0
    bl	getint
    movz	w2,	#0
    add	w11,	w26,	w20

main_13:
    cmp	w2,	w20
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
    movz	w24,	#2880
    add	w3,	w17,	w18
    movz	w13,	#0
    madd	x9,	x18,	x24,	x12


main_27:
    lsl	w1,	w13,	#10
    add	w23,	w3,	w13
    movz	w15,	#0
    sub	w4,	w1,	w13,	lsl #6
    add	x24,	x9,	x4

main_32:
    lsl	w4,	w15,	#8
    add	w16,	w23,	w15
    movz	w6,	#0
    sub	w4,	w4,	w15,	lsl #4
    add	x1,	x24,	x4

main_37:
    lsl	w7,	w6,	#4
    add	w14,	w16,	w6
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

    add	w8,	w10,	#1
    add	x7,	x4,	#4
    str	w10,	[x4]

    str	w8,	[x7]

    add	w8,	w14,	#4
    add	x7,	x5,	#32
    add	x5,	x5,	#40
    str	w8,	[x7]

    add	w10,	w8,	#1
    add	x4,	x7,	#4
    add	x8,	x5,	#4
    add	w7,	w14,	#5
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
    movz	w23,	#10752
    mul	w12,	w18,	w23
    movz	w23,	#0
    mov	x24,	x12
    add	x24,	sp,	x24
    add	x24,	x24,	#16

main_89:
    movz	w17,	#5376
    add	w1,	w23,	w18
    movz	w10,	#0
    madd	x20,	x23,	x17,	x24


main_94:
    lsl	w14,	w10,	#11
    movz	w6,	#0
    sub	w11,	w14,	w10,	lsl #8
    add	x5,	x20,	x11

main_98:
    lsl	w2,	w6,	#10
    add	w3,	w1,	w6
    movz	w15,	#0
    sub	w8,	w2,	w6,	lsl #7
    add	w14,	w3,	#6
    add	w11,	w3,	#5
    add	w13,	w3,	#4
    add	w4,	w3,	#2
    add	w26,	w3,	#1
    add	w2,	w3,	#3
    add	x8,	x5,	x8

main_109:
    lsl	w7,	w15,	#8
    sub	w7,	w7,	w15,	lsl #5
    add	w15,	w15,	#1
    add	x9,	x8,	x7
    mov	x7,	x9
    add	x17,	x7,	#12
    add	x16,	x7,	#8
    add	x12,	x7,	#4
    str	w3,	[x7]

    str	w26,	[x12]

    add	x12,	x7,	#16
    str	w4,	[x16]

    add	x16,	x7,	#20
    str	w2,	[x17]

    add	x17,	x7,	#24
    str	w13,	[x12]

    add	x12,	x9,	#28
    str	w11,	[x16]

    str	w14,	[x17]

    add	x7,	x12,	#8
    add	x16,	x12,	#12
    add	x17,	x12,	#4
    str	w3,	[x12]

    str	w26,	[x17]

    add	x17,	x12,	#16
    str	w4,	[x7]

    add	x7,	x12,	#20
    str	w2,	[x16]

    str	w13,	[x17]

    add	x17,	x12,	#24
    str	w11,	[x7]

    add	x12,	x9,	#56
    str	w14,	[x17]

    add	x7,	x12,	#12
    add	x16,	x12,	#4
    add	x17,	x12,	#8
    str	w3,	[x12]

    str	w26,	[x16]

    add	x16,	x12,	#16
    str	w4,	[x17]

    add	x17,	x12,	#20
    str	w2,	[x7]

    str	w13,	[x16]

    str	w11,	[x17]

    add	x17,	x12,	#24
    add	x12,	x9,	#84
    str	w14,	[x17]

    add	x16,	x12,	#8
    add	x7,	x12,	#4
    add	x17,	x12,	#12
    str	w3,	[x12]

    str	w26,	[x7]

    add	x7,	x12,	#16
    str	w4,	[x16]

    add	x16,	x12,	#20
    str	w2,	[x17]

    add	x17,	x12,	#24
    str	w13,	[x7]

    add	x12,	x9,	#112
    str	w11,	[x16]

    str	w14,	[x17]

    add	x7,	x12,	#8
    add	x16,	x12,	#12
    add	x17,	x12,	#4
    str	w3,	[x12]

    str	w26,	[x17]

    add	x17,	x12,	#16
    str	w4,	[x7]

    add	x7,	x12,	#20
    str	w2,	[x16]

    str	w13,	[x17]

    add	x17,	x12,	#24
    str	w11,	[x7]

    add	x12,	x9,	#140
    str	w14,	[x17]

    add	x7,	x12,	#12
    add	x16,	x12,	#4
    add	x17,	x12,	#8
    str	w3,	[x12]

    str	w26,	[x16]

    add	x16,	x12,	#16
    str	w4,	[x17]

    add	x17,	x12,	#20
    str	w2,	[x7]

    str	w13,	[x16]

    str	w11,	[x17]

    add	x17,	x12,	#24
    add	x12,	x9,	#168
    str	w14,	[x17]

    add	x16,	x12,	#8
    add	x7,	x12,	#4
    add	x17,	x12,	#12
    str	w3,	[x12]

    str	w26,	[x7]

    add	x7,	x12,	#16
    str	w4,	[x16]

    add	x16,	x12,	#20
    str	w2,	[x17]

    add	x17,	x12,	#24
    str	w13,	[x7]

    str	w11,	[x16]

    add	x16,	x9,	#196
    str	w14,	[x17]

    add	x9,	x16,	#16
    add	x7,	x16,	#12
    add	x12,	x16,	#4
    add	x17,	x16,	#8
    str	w3,	[x16]

    str	w26,	[x12]

    add	x12,	x16,	#20
    str	w4,	[x17]

    add	x17,	x16,	#24
    str	w2,	[x7]

    str	w13,	[x9]

    str	w11,	[x12]

    str	w14,	[x17]

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
    add	w23,	w23,	#1
    cmp	w23,	#2
    blt	main_89

main_187:
    add	w18,	w18,	#1
    cmp	w18,	#10
    blt	main_85

main_190:
    movz	w9,	#0
    movz	w3,	#0

main_192:
    cmp	w9,	#10
    bge	main_292

main_196:
    movz	w26,	#5760
    movz	fp,	#42000
    movz	w2,	#10752
    movz	w1,	#0
    mul	w15,	w9,	w26
    movk	fp,	#1,	lsl #16
    mul	w16,	w9,	w2
    mov	w5,	w1
    mov	x26,	x15
    mov	x15,	x16
    add	x26,	sp,	x26
    add	x15,	sp,	x15
    add	x26,	x26,	fp
    add	x15,	x15,	#16

main_200:
    cmp	x5,	#100
    bge	main_286

main_204:
    movz	w2,	#2880
    movz	w8,	#5376
    movz	w16,	#0
    madd	x4,	x5,	x2,	x26

    madd	x11,	x5,	x8,	x15


main_208:
    cmp	w16,	#1000
    bge	main_280

main_212:
    lsl	w6,	w16,	#10
    lsl	w7,	w16,	#11
    movz	w12,	#0
    sub	w6,	w6,	w16,	lsl #6
    sub	w23,	w7,	w16,	lsl #8
    mov	w17,	w12
    add	x8,	x4,	x6
    add	x6,	x11,	x23

main_216:
    movz	w12,	#10000
    cmp	w17,	w12
    bge	main_274

main_220:
    lsl	w14,	w17,	#8
    lsl	w24,	w17,	#10
    movz	w18,	#0
    sub	w7,	w14,	w17,	lsl #4
    sub	w24,	w24,	w17,	lsl #7
    mov	w12,	w18
    add	x23,	x8,	x7
    add	x1,	x6,	x24

main_224:
    movz	w13,	#34464
    movk	w13,	#1,	lsl #16
    cmp	w12,	w13
    bge	main_268

main_228:
    lsl	w10,	w12,	#4
    lsl	w2,	w12,	#8
    add	w14,	w10,	w12,	lsl #5
    sub	w2,	w2,	w12,	lsl #5
    add	x13,	x23,	x14
    add	x10,	x1,	x2
    movz	w14,	#0
    mov	w7,	w14

main_232:
    movz	w2,	#16960
    movk	w2,	#15,	lsl #16
    cmp	w7,	w2
    bge	main_262

main_236:
    lsl	w18,	w7,	#3
    lsl	w14,	w7,	#5
    movz	w20,	#0
    add	x2,	x13,	x18
    sub	w24,	w14,	w7,	lsl #2
    add	x18,	x10,	x24
    mov	w24,	w20

main_240:
    movz	w20,	#38528
    movk	w20,	#152,	lsl #16
    cmp	w24,	w20
    bge	main_256

main_244:
    movz	w20,	#817
    sdiv	w14,	w3,	w20
    movz	w20,	#817
    msub	w14,	w14,	w20,	w3

    lsl	w20,	w24,	#2
    add	x3,	x2,	x20
    ldr	w3,	[x3]

    add	w20,	w3,	w14
    lsl	w14,	w24,	#2
    add	x3,	x18,	x14
    ldr	w3,	[x3]

    add	w3,	w20,	w3
    add	w20,	w24,	#1
    cmp	w20,	w0
    bge	main_256

main_239:
    mov	w24,	w20
    b	main_240

main_256:
    add	w2,	w7,	#1
    cmp	w2,	w22
    bge	main_262

main_231:
    mov	w7,	w2
    b	main_232

main_262:
    add	w24,	w12,	#1
    cmp	w24,	w21
    bge	main_268

main_223:
    mov	w12,	w24
    b	main_224

main_268:
    add	w12,	w17,	#1
    cmp	w12,	w28
    bge	main_274

main_215:
    mov	w17,	w12
    b	main_216

main_274:
    add	w7,	w16,	#1
    cmp	w7,	w27
    bge	main_280

main_207:
    mov	w16,	w7
    b	main_208

main_280:
    add	w18,	w5,	#1
    cmp	w18,	w19
    bge	main_286

main_199:
    mov	w5,	w18
    b	main_200

main_286:
    add	w9,	w9,	#1
    cmp	w9,	w25
    blt	main_192

main_292:
    mov	w0,	w3
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#34064
    movk	fp,	#2,	lsl #16
    add	sp, sp, fp
    ret


