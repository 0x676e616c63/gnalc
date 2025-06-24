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
    mov	w21,	w0
    bl	getint
    mov	w25,	w0
    bl	getint
    mov	w26,	w0
    bl	getint
    mov	w24,	w0
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w23,	w0
    bl	getint
    mov	w20,	w0
    bl	getint
    movz	w2,	#0
    add	w11,	w21,	w22

main_13:
    cmp	w2,	w22
    bge	main_82

main_16:
    cmp	w2,	w21
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
    add	w19,	w3,	w13
    movz	w15,	#0
    sub	w4,	w1,	w13,	lsl #6
    add	x27,	x9,	x4

main_32:
    lsl	w4,	w15,	#8
    add	w8,	w19,	w15
    movz	w6,	#0
    sub	w4,	w4,	w15,	lsl #4
    add	x10,	x27,	x4

main_37:
    lsl	w5,	w6,	#4
    add	w1,	w8,	w6
    add	w4,	w5,	w6,	lsl #5
    add	w7,	w1,	#1
    add	w6,	w6,	#1
    add	x5,	x10,	x4
    mov	x4,	x5
    add	x17,	x4,	#4
    str	w1,	[x4]

    add	x4,	x5,	#8
    str	w7,	[x17]

    add	x17,	x4,	#4
    str	w7,	[x4]

    add	w4,	w7,	#1
    str	w4,	[x17]

    add	w4,	w1,	#2
    add	x17,	x5,	#16
    add	w7,	w4,	#1
    add	x14,	x17,	#4
    str	w4,	[x17]

    add	w17,	w1,	#3
    add	x4,	x5,	#24
    str	w7,	[x14]

    add	w14,	w17,	#1
    add	x7,	x4,	#4
    str	w17,	[x4]

    str	w14,	[x7]

    add	w14,	w1,	#4
    add	x7,	x5,	#32
    add	x5,	x5,	#40
    str	w14,	[x7]

    add	w17,	w14,	#1
    add	x4,	x7,	#4
    add	x7,	x5,	#4
    str	w17,	[x4]

    add	w4,	w1,	#5
    add	w1,	w4,	#1
    str	w4,	[x5]

    str	w1,	[x7]

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
    movz	w21,	#10752
    movz	fp,	#57616
    mul	w12,	w18,	w21
    movz	w21,	#0
    mov	x22,	x12
    add	x22,	sp,	x22
    add	x22,	x22,	fp

main_89:
    movz	w17,	#5376
    add	w1,	w21,	w18
    movz	w10,	#0
    madd	x19,	x21,	x17,	x22


main_94:
    lsl	w14,	w10,	#11
    movz	w6,	#0
    sub	w11,	w14,	w10,	lsl #8
    add	x5,	x19,	x11

main_98:
    lsl	w2,	w6,	#10
    add	w16,	w1,	w6
    movz	w15,	#0
    sub	w8,	w2,	w6,	lsl #7
    add	w14,	w16,	#6
    add	w27,	w16,	#4
    add	w4,	w16,	#3
    add	w17,	w16,	#1
    add	w2,	w16,	#5
    add	x13,	x5,	x8
    add	w8,	w16,	#2

main_109:
    lsl	w3,	w15,	#8
    sub	w3,	w3,	w15,	lsl #5
    add	w15,	w15,	#1
    add	x9,	x13,	x3
    mov	x7,	x9
    add	x12,	x7,	#12
    add	x11,	x7,	#8
    add	x3,	x7,	#4
    str	w16,	[x7]

    str	w17,	[x3]

    add	x3,	x7,	#16
    str	w8,	[x11]

    add	x11,	x7,	#20
    str	w4,	[x12]

    add	x12,	x7,	#24
    str	w27,	[x3]

    add	x7,	x9,	#28
    str	w2,	[x11]

    str	w14,	[x12]

    add	x3,	x7,	#8
    add	x11,	x7,	#12
    add	x12,	x7,	#4
    str	w16,	[x7]

    str	w17,	[x12]

    add	x12,	x7,	#16
    str	w8,	[x3]

    add	x3,	x7,	#20
    str	w4,	[x11]

    str	w27,	[x12]

    add	x12,	x7,	#24
    str	w2,	[x3]

    add	x7,	x9,	#56
    str	w14,	[x12]

    add	x3,	x7,	#12
    add	x11,	x7,	#4
    add	x12,	x7,	#8
    str	w16,	[x7]

    str	w17,	[x11]

    add	x11,	x7,	#16
    str	w8,	[x12]

    add	x12,	x7,	#20
    str	w4,	[x3]

    str	w27,	[x11]

    str	w2,	[x12]

    add	x12,	x7,	#24
    add	x7,	x9,	#84
    str	w14,	[x12]

    add	x11,	x7,	#8
    add	x3,	x7,	#4
    add	x12,	x7,	#12
    str	w16,	[x7]

    str	w17,	[x3]

    add	x3,	x7,	#16
    str	w8,	[x11]

    add	x11,	x7,	#20
    str	w4,	[x12]

    add	x12,	x7,	#24
    str	w27,	[x3]

    add	x7,	x9,	#112
    str	w2,	[x11]

    str	w14,	[x12]

    add	x3,	x7,	#8
    add	x11,	x7,	#12
    add	x12,	x7,	#4
    str	w16,	[x7]

    str	w17,	[x12]

    add	x12,	x7,	#16
    str	w8,	[x3]

    add	x3,	x7,	#20
    str	w4,	[x11]

    str	w27,	[x12]

    add	x12,	x7,	#24
    str	w2,	[x3]

    add	x7,	x9,	#140
    str	w14,	[x12]

    add	x3,	x7,	#12
    add	x11,	x7,	#4
    add	x12,	x7,	#8
    str	w16,	[x7]

    str	w17,	[x11]

    add	x11,	x7,	#16
    str	w8,	[x12]

    add	x12,	x7,	#20
    str	w4,	[x3]

    str	w27,	[x11]

    str	w2,	[x12]

    add	x12,	x7,	#24
    add	x7,	x9,	#168
    str	w14,	[x12]

    add	x11,	x7,	#8
    add	x3,	x7,	#4
    add	x12,	x7,	#12
    str	w16,	[x7]

    str	w17,	[x3]

    add	x3,	x7,	#16
    str	w8,	[x11]

    add	x11,	x7,	#20
    str	w4,	[x12]

    add	x12,	x7,	#24
    str	w27,	[x3]

    str	w2,	[x11]

    add	x11,	x9,	#196
    str	w14,	[x12]

    add	x7,	x11,	#16
    add	x3,	x11,	#12
    add	x9,	x11,	#4
    add	x12,	x11,	#8
    str	w16,	[x11]

    str	w17,	[x9]

    add	x9,	x11,	#20
    str	w8,	[x12]

    add	x12,	x11,	#24
    str	w4,	[x3]

    str	w27,	[x7]

    str	w2,	[x9]

    str	w14,	[x12]

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
    add	w21,	w21,	#1
    cmp	w21,	#2
    blt	main_89

main_187:
    add	w18,	w18,	#1
    cmp	w18,	#10
    blt	main_85

main_190:
    movz	w9,	#0
    movz	w4,	#0
    mov	w10,	w9

main_192:
    cmp	w10,	#10
    bge	main_292

main_196:
    movz	w27,	#5760
    movz	w2,	#10752
    movz	fp,	#57616
    movz	w1,	#0
    mul	w15,	w10,	w27
    mul	w17,	w10,	w2
    mov	x3,	x15
    mov	x6,	x17
    add	x3,	sp,	x3
    add	x6,	sp,	x6
    add	x3,	x3,	#16
    add	x6,	x6,	fp

main_200:
    cmp	x1,	#100
    bge	main_286

main_204:
    movz	w5,	#2880
    movz	w9,	#5376
    movz	w16,	#0
    madd	x17,	x1,	x5,	x3

    madd	x15,	x1,	x9,	x6

    mov	w27,	w16

main_208:
    cmp	w27,	#1000
    bge	main_280

main_212:
    lsl	w7,	w27,	#10
    lsl	w9,	w27,	#11
    movz	w11,	#0
    sub	w7,	w7,	w27,	lsl #6
    sub	w21,	w9,	w27,	lsl #8
    mov	w18,	w11
    add	x2,	x17,	x7
    add	x16,	x15,	x21

main_216:
    movz	w11,	#10000
    cmp	w18,	w11
    bge	main_274

main_220:
    lsl	w13,	w18,	#8
    lsl	w22,	w18,	#10
    movz	w14,	#0
    sub	w8,	w13,	w18,	lsl #4
    sub	w22,	w22,	w18,	lsl #7
    mov	w12,	w14
    add	x21,	x2,	x8
    add	x5,	x16,	x22

main_224:
    movz	w11,	#34464
    movk	w11,	#1,	lsl #16
    cmp	w12,	w11
    bge	main_268

main_228:
    lsl	w9,	w12,	#4
    lsl	w7,	w12,	#8
    movz	w11,	#0
    add	w13,	w9,	w12,	lsl #5
    sub	w7,	w7,	w12,	lsl #5
    add	x13,	x21,	x13
    add	x7,	x5,	x7

main_232:
    movz	w8,	#16960
    movk	w8,	#15,	lsl #16
    cmp	w11,	w8
    bge	main_262

main_236:
    lsl	w14,	w11,	#3
    lsl	w8,	w11,	#5
    movz	w19,	#0
    mov	w9,	w4
    add	x14,	x13,	x14
    sub	w22,	w8,	w11,	lsl #2
    add	x8,	x7,	x22
    mov	w22,	w19

main_240:
    movz	w19,	#38528
    movk	w19,	#152,	lsl #16
    cmp	w22,	w19
    bge	main_254

main_244:
    movz	w19,	#817
    sdiv	w4,	w9,	w19
    movz	w19,	#817
    msub	w9,	w4,	w19,	w9

    lsl	w19,	w22,	#2
    add	x4,	x14,	x19
    ldr	w4,	[x4]

    add	w19,	w4,	w9
    lsl	w9,	w22,	#2
    add	x4,	x8,	x9
    ldr	w4,	[x4]

    add	w4,	w19,	w4
    add	w19,	w22,	#1
    cmp	w19,	w0
    bge	main_256

main_239:
    mov	w22,	w19
    mov	w9,	w4
    b	main_240

main_254:
    mov	w4,	w9

main_256:
    add	w8,	w11,	#1
    cmp	w8,	w20
    bge	main_262

main_231:
    mov	w11,	w8
    b	main_232

main_262:
    add	w22,	w12,	#1
    cmp	w22,	w23
    bge	main_268

main_223:
    mov	w12,	w22
    b	main_224

main_268:
    add	w11,	w18,	#1
    cmp	w11,	w28
    bge	main_274

main_215:
    mov	w18,	w11
    b	main_216

main_274:
    add	w8,	w27,	#1
    cmp	w8,	w24
    bge	main_280

main_207:
    mov	w27,	w8
    b	main_208

main_280:
    add	w19,	w1,	#1
    cmp	w19,	w26
    bge	main_286

main_199:
    mov	w1,	w19
    b	main_200

main_286:
    add	w9,	w10,	#1
    cmp	w9,	w25
    bge	main_292

main_191:
    mov	w10,	w9
    b	main_192

main_292:
    mov	w0,	w4
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#34064
    movk	fp,	#2,	lsl #16
    add	sp, sp, fp
    ret


