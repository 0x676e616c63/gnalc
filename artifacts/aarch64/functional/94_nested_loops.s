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
    mov	w24,	w0
    bl	getint
    mov	w23,	w0
    bl	getint
    mov	w25,	w0
    bl	getint
    mov	w19,	w0
    bl	getint
    mov	w27,	w0
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w20,	w0
    bl	getint
    mov	w21,	w0
    bl	getint
    movz	w2,	#0
    add	w11,	w23,	w24

main_13:
    cmp	w2,	w24
    bge	main_82

main_16:
    cmp	w2,	w23
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
    movz	w26,	#2880
    add	w10,	w17,	w18
    movz	w13,	#0
    madd	x26,	x18,	x26,	x12


main_27:
    lsl	w1,	w13,	#10
    movz	w15,	#0
    sub	w3,	w1,	w13,	lsl #6
    add	x9,	x26,	x3
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
    madd	x22,	x23,	x17,	x24


main_94:
    lsl	w14,	w10,	#11
    movz	w6,	#0
    sub	w11,	w14,	w10,	lsl #8
    add	x5,	x22,	x11

main_98:
    lsl	w2,	w6,	#10
    add	w3,	w1,	w6
    movz	w15,	#0
    sub	w8,	w2,	w6,	lsl #7
    add	w4,	w3,	#6
    add	w11,	w3,	#5
    add	w26,	w3,	#4
    add	w12,	w3,	#2
    add	w16,	w3,	#1
    add	x13,	x5,	x8
    add	w8,	w3,	#3

main_109:
    lsl	w2,	w15,	#8
    sub	w2,	w2,	w15,	lsl #5
    add	w15,	w15,	#1
    add	x9,	x13,	x2
    mov	x7,	x9
    add	x17,	x7,	#12
    add	x14,	x7,	#8
    add	x2,	x7,	#4
    str	w3,	[x7]

    str	w16,	[x2]

    add	x2,	x7,	#16
    str	w12,	[x14]

    add	x14,	x7,	#20
    str	w8,	[x17]

    add	x17,	x7,	#24
    str	w26,	[x2]

    add	x7,	x9,	#28
    str	w11,	[x14]

    str	w4,	[x17]

    add	x2,	x7,	#8
    add	x14,	x7,	#12
    add	x17,	x7,	#4
    str	w3,	[x7]

    str	w16,	[x17]

    add	x17,	x7,	#16
    str	w12,	[x2]

    add	x2,	x7,	#20
    str	w8,	[x14]

    str	w26,	[x17]

    add	x17,	x7,	#24
    str	w11,	[x2]

    add	x7,	x9,	#56
    str	w4,	[x17]

    add	x2,	x7,	#12
    add	x14,	x7,	#4
    add	x17,	x7,	#8
    str	w3,	[x7]

    str	w16,	[x14]

    add	x14,	x7,	#16
    str	w12,	[x17]

    add	x17,	x7,	#20
    str	w8,	[x2]

    str	w26,	[x14]

    str	w11,	[x17]

    add	x17,	x7,	#24
    add	x7,	x9,	#84
    str	w4,	[x17]

    add	x14,	x7,	#8
    add	x2,	x7,	#4
    add	x17,	x7,	#12
    str	w3,	[x7]

    str	w16,	[x2]

    add	x2,	x7,	#16
    str	w12,	[x14]

    add	x14,	x7,	#20
    str	w8,	[x17]

    add	x17,	x7,	#24
    str	w26,	[x2]

    add	x7,	x9,	#112
    str	w11,	[x14]

    str	w4,	[x17]

    add	x2,	x7,	#8
    add	x14,	x7,	#12
    add	x17,	x7,	#4
    str	w3,	[x7]

    str	w16,	[x17]

    add	x17,	x7,	#16
    str	w12,	[x2]

    add	x2,	x7,	#20
    str	w8,	[x14]

    str	w26,	[x17]

    add	x17,	x7,	#24
    str	w11,	[x2]

    add	x7,	x9,	#140
    str	w4,	[x17]

    add	x2,	x7,	#12
    add	x14,	x7,	#4
    add	x17,	x7,	#8
    str	w3,	[x7]

    str	w16,	[x14]

    add	x14,	x7,	#16
    str	w12,	[x17]

    add	x17,	x7,	#20
    str	w8,	[x2]

    str	w26,	[x14]

    str	w11,	[x17]

    add	x17,	x7,	#24
    add	x7,	x9,	#168
    str	w4,	[x17]

    add	x14,	x7,	#8
    add	x2,	x7,	#4
    add	x17,	x7,	#12
    str	w3,	[x7]

    str	w16,	[x2]

    add	x2,	x7,	#16
    str	w12,	[x14]

    add	x14,	x7,	#20
    str	w8,	[x17]

    add	x17,	x7,	#24
    str	w26,	[x2]

    str	w11,	[x14]

    add	x14,	x9,	#196
    str	w4,	[x17]

    add	x7,	x14,	#16
    add	x2,	x14,	#12
    add	x9,	x14,	#4
    add	x17,	x14,	#8
    str	w3,	[x14]

    str	w16,	[x9]

    add	x9,	x14,	#20
    str	w12,	[x17]

    add	x17,	x14,	#24
    str	w8,	[x2]

    str	w26,	[x7]

    str	w11,	[x9]

    str	w4,	[x17]

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
    mov	w12,	w9

main_192:
    cmp	w12,	#10
    bge	main_292

main_196:
    movz	w26,	#5760
    movz	fp,	#42000
    movz	w2,	#10752
    movz	w1,	#0
    mul	w15,	w12,	w26
    movk	fp,	#1,	lsl #16
    mul	w17,	w12,	w2
    mov	w18,	w1
    mov	x14,	x15
    mov	x2,	x17
    add	x14,	sp,	x14
    add	x2,	sp,	x2
    add	x14,	x14,	fp
    add	x2,	x2,	#16

main_200:
    cmp	x18,	#100
    bge	main_286

main_204:
    movz	w4,	#2880
    movz	w7,	#5376
    movz	w15,	#0
    madd	x8,	x18,	x4,	x14

    madd	x23,	x18,	x7,	x2

    mov	w16,	w15

main_208:
    cmp	w16,	#1000
    bge	main_280

main_212:
    lsl	w5,	w16,	#10
    lsl	w6,	w16,	#11
    movz	w7,	#0
    sub	w5,	w5,	w16,	lsl #6
    sub	w24,	w6,	w16,	lsl #8
    mov	w26,	w7
    add	x13,	x8,	x5
    add	x9,	x23,	x24

main_216:
    movz	w7,	#10000
    cmp	w26,	w7
    bge	main_274

main_220:
    lsl	w11,	w26,	#8
    lsl	w24,	w26,	#10
    movz	w17,	#0
    sub	w5,	w11,	w26,	lsl #4
    sub	w24,	w24,	w26,	lsl #7
    mov	w7,	w17
    add	x6,	x13,	x5
    add	x4,	x9,	x24

main_224:
    movz	w11,	#34464
    movk	w11,	#1,	lsl #16
    cmp	w7,	w11
    bge	main_268

main_228:
    lsl	w10,	w7,	#4
    lsl	w1,	w7,	#8
    add	w15,	w10,	w7,	lsl #5
    sub	w1,	w1,	w7,	lsl #5
    movz	w10,	#0
    mov	w5,	w10
    add	x11,	x6,	x15
    add	x15,	x4,	x1

main_232:
    movz	w1,	#16960
    movk	w1,	#15,	lsl #16
    cmp	w5,	w1
    bge	main_262

main_236:
    lsl	w17,	w5,	#3
    lsl	w10,	w5,	#5
    movz	w22,	#0
    add	x1,	x11,	x17
    sub	w24,	w10,	w5,	lsl #2
    add	x17,	x15,	x24
    mov	w24,	w22

main_240:
    movz	w22,	#38528
    movk	w22,	#152,	lsl #16
    cmp	w24,	w22
    bge	main_256

main_244:
    movz	w22,	#817
    sdiv	w10,	w3,	w22
    movz	w22,	#817
    msub	w10,	w10,	w22,	w3

    lsl	w22,	w24,	#2
    add	x3,	x1,	x22
    ldr	w3,	[x3]

    add	w22,	w3,	w10
    lsl	w10,	w24,	#2
    add	x3,	x17,	x10
    ldr	w3,	[x3]

    add	w3,	w22,	w3
    add	w22,	w24,	#1
    cmp	w22,	w0
    bge	main_256

main_239:
    mov	w24,	w22
    b	main_240

main_256:
    add	w1,	w5,	#1
    cmp	w1,	w21
    bge	main_262

main_231:
    mov	w5,	w1
    b	main_232

main_262:
    add	w24,	w7,	#1
    cmp	w24,	w20
    bge	main_268

main_223:
    mov	w7,	w24
    b	main_224

main_268:
    add	w7,	w26,	#1
    cmp	w7,	w28
    bge	main_274

main_215:
    mov	w26,	w7
    b	main_216

main_274:
    add	w6,	w16,	#1
    cmp	w6,	w27
    bge	main_280

main_207:
    mov	w16,	w6
    b	main_208

main_280:
    add	w22,	w18,	#1
    cmp	w22,	w19
    bge	main_286

main_199:
    mov	w18,	w22
    b	main_200

main_286:
    add	w9,	w12,	#1
    cmp	w9,	w25
    bge	main_292

main_191:
    mov	w12,	w9
    b	main_192

main_292:
    mov	w0,	w3
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#34064
    movk	fp,	#2,	lsl #16
    add	sp, sp, fp
    ret


