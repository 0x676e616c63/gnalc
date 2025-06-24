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
    mov	w24,	w0
    bl	getint
    mov	w21,	w0
    bl	getint
    mov	w25,	w0
    bl	getint
    mov	w22,	w0
    bl	getint
    mov	w27,	w0
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w19,	w0
    bl	getint
    mov	w23,	w0
    bl	getint
    movz	w2,	#0
    add	w11,	w21,	w24

main_13:
    cmp	w2,	w24
    bge	main_82

main_16:
    cmp	w2,	w21
    bge	main_83

main_18:
    movz	w6,	#5760
    add	w17,	w11,	w2
    movz	w18,	#0
    mul	w3,	w2,	w6
    mov	x12,	x3
    add	x12,	sp,	x12
    add	x12,	x12,	#16

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
    add	w8,	w3,	w15
    movz	w6,	#0
    sub	w4,	w4,	w15,	lsl #4
    add	x14,	x9,	x4

main_37:
    lsl	w5,	w6,	#4
    add	w1,	w8,	w6
    add	w4,	w5,	w6,	lsl #5
    add	w7,	w1,	#1
    add	w6,	w6,	#1
    add	x5,	x14,	x4
    mov	x4,	x5
    add	x20,	x4,	#4
    str	w1,	[x4]

    add	x4,	x5,	#8
    str	w7,	[x20]

    add	x20,	x4,	#4
    str	w7,	[x4]

    add	w4,	w7,	#1
    str	w4,	[x20]

    add	w4,	w1,	#2
    add	x20,	x5,	#16
    add	w7,	w4,	#1
    add	x16,	x20,	#4
    str	w4,	[x20]

    add	w20,	w1,	#3
    add	x4,	x5,	#24
    str	w7,	[x16]

    add	w16,	w20,	#1
    add	x7,	x4,	#4
    str	w20,	[x4]

    str	w16,	[x7]

    add	w16,	w1,	#4
    add	x7,	x5,	#32
    add	x5,	x5,	#40
    add	x4,	x7,	#4
    str	w16,	[x7]

    add	w20,	w16,	#1
    add	x7,	x5,	#4
    str	w20,	[x4]

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
    mov	x24,	x12
    add	x24,	sp,	x24
    add	x24,	x24,	fp

main_89:
    movz	w17,	#5376
    add	w1,	w21,	w18
    movz	w10,	#0
    madd	x20,	x21,	x17,	x24


main_94:
    lsl	w14,	w10,	#11
    movz	w6,	#0
    sub	w11,	w14,	w10,	lsl #8
    add	x5,	x20,	x11

main_98:
    lsl	w2,	w6,	#10
    add	w16,	w1,	w6
    movz	w15,	#0
    sub	w8,	w2,	w6,	lsl #7
    add	w4,	w16,	#4
    add	w3,	w16,	#3
    add	w12,	w16,	#2
    add	w13,	w16,	#1
    add	w2,	w16,	#5
    add	x26,	x5,	x8
    add	w8,	w16,	#6

main_109:
    lsl	w7,	w15,	#8
    sub	w7,	w7,	w15,	lsl #5
    add	w15,	w15,	#1
    add	x9,	x26,	x7
    mov	x7,	x9
    add	x17,	x7,	#12
    add	x14,	x7,	#8
    add	x11,	x7,	#4
    str	w16,	[x7]

    str	w13,	[x11]

    add	x11,	x7,	#16
    str	w12,	[x14]

    add	x14,	x7,	#20
    str	w3,	[x17]

    add	x17,	x7,	#24
    str	w4,	[x11]

    add	x11,	x9,	#28
    str	w2,	[x14]

    str	w8,	[x17]

    add	x7,	x11,	#8
    add	x14,	x11,	#12
    add	x17,	x11,	#4
    str	w16,	[x11]

    str	w13,	[x17]

    add	x17,	x11,	#16
    str	w12,	[x7]

    add	x7,	x11,	#20
    str	w3,	[x14]

    str	w4,	[x17]

    add	x17,	x11,	#24
    str	w2,	[x7]

    add	x11,	x9,	#56
    str	w8,	[x17]

    add	x7,	x11,	#12
    add	x14,	x11,	#4
    add	x17,	x11,	#8
    str	w16,	[x11]

    str	w13,	[x14]

    add	x14,	x11,	#16
    str	w12,	[x17]

    add	x17,	x11,	#20
    str	w3,	[x7]

    str	w4,	[x14]

    str	w2,	[x17]

    add	x17,	x11,	#24
    add	x11,	x9,	#84
    str	w8,	[x17]

    add	x14,	x11,	#8
    add	x7,	x11,	#4
    add	x17,	x11,	#12
    str	w16,	[x11]

    str	w13,	[x7]

    add	x7,	x11,	#16
    str	w12,	[x14]

    add	x14,	x11,	#20
    str	w3,	[x17]

    add	x17,	x11,	#24
    str	w4,	[x7]

    add	x11,	x9,	#112
    str	w2,	[x14]

    str	w8,	[x17]

    add	x7,	x11,	#8
    add	x14,	x11,	#12
    add	x17,	x11,	#4
    str	w16,	[x11]

    str	w13,	[x17]

    add	x17,	x11,	#16
    str	w12,	[x7]

    add	x7,	x11,	#20
    str	w3,	[x14]

    str	w4,	[x17]

    add	x17,	x11,	#24
    str	w2,	[x7]

    add	x11,	x9,	#140
    str	w8,	[x17]

    add	x14,	x11,	#4
    add	x7,	x11,	#12
    add	x17,	x11,	#8
    str	w16,	[x11]

    str	w13,	[x14]

    add	x14,	x11,	#16
    str	w12,	[x17]

    add	x17,	x11,	#20
    str	w3,	[x7]

    str	w4,	[x14]

    str	w2,	[x17]

    add	x17,	x11,	#24
    add	x11,	x9,	#168
    str	w8,	[x17]

    add	x14,	x11,	#8
    add	x7,	x11,	#4
    add	x17,	x11,	#12
    str	w16,	[x11]

    str	w13,	[x7]

    add	x7,	x11,	#16
    str	w12,	[x14]

    add	x14,	x11,	#20
    str	w3,	[x17]

    add	x17,	x11,	#24
    str	w4,	[x7]

    str	w2,	[x14]

    add	x14,	x9,	#196
    str	w8,	[x17]

    add	x9,	x14,	#16
    add	x7,	x14,	#12
    add	x11,	x14,	#4
    add	x17,	x14,	#8
    str	w16,	[x14]

    str	w13,	[x11]

    add	x11,	x14,	#20
    str	w12,	[x17]

    add	x17,	x14,	#24
    str	w3,	[x7]

    str	w4,	[x9]

    str	w2,	[x11]

    str	w8,	[x17]

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
    movz	w11,	#0
    mov	w3,	w9

main_192:
    cmp	w3,	#10
    bge	main_292

main_196:
    movz	w26,	#5760
    movz	w4,	#10752
    movz	fp,	#57616
    mul	w15,	w3,	w26
    mul	w17,	w3,	w4
    mov	x2,	x15
    movz	w4,	#0
    mov	x1,	x17
    add	x2,	sp,	x2
    mov	w16,	w4
    add	x1,	sp,	x1
    add	x2,	x2,	#16
    add	x1,	x1,	fp

main_200:
    cmp	x16,	#100
    bge	main_286

main_204:
    movz	w5,	#2880
    movz	w9,	#5376
    movz	w17,	#0
    madd	x7,	x16,	x5,	x2

    madd	x8,	x16,	x9,	x1

    mov	w10,	w17

main_208:
    cmp	w10,	#1000
    bge	main_280

main_212:
    lsl	w6,	w10,	#10
    lsl	w12,	w10,	#11
    movz	w13,	#0
    sub	w6,	w6,	w10,	lsl #6
    sub	w24,	w12,	w10,	lsl #8
    add	x9,	x7,	x6
    add	x14,	x8,	x24
    mov	w6,	w13

main_216:
    movz	w15,	#10000
    cmp	w6,	w15
    bge	main_274

main_220:
    lsl	w18,	w6,	#8
    lsl	w26,	w6,	#10
    movz	w20,	#0
    sub	w12,	w18,	w6,	lsl #4
    sub	w26,	w26,	w6,	lsl #7
    mov	w17,	w20
    add	x21,	x9,	x12
    add	x13,	x14,	x26

main_224:
    movz	w15,	#34464
    movk	w15,	#1,	lsl #16
    cmp	w17,	w15
    bge	main_268

main_228:
    lsl	w12,	w17,	#4
    lsl	w4,	w17,	#8
    add	w18,	w12,	w17,	lsl #5
    sub	w4,	w4,	w17,	lsl #5
    add	x12,	x21,	x18
    add	x15,	x13,	x4
    movz	w18,	#0

main_232:
    movz	w4,	#16960
    movk	w4,	#15,	lsl #16
    cmp	w18,	w4
    bge	main_262

main_236:
    lsl	w20,	w18,	#3
    lsl	w4,	w18,	#5
    movz	w24,	#0
    add	x5,	x12,	x20
    sub	w26,	w4,	w18,	lsl #2
    add	x4,	x15,	x26

main_240:
    movz	w26,	#38528
    movk	w26,	#152,	lsl #16
    cmp	w24,	w26
    bge	main_256

main_244:
    movz	w26,	#817
    movz	w20,	#817
    sdiv	w26,	w11,	w26
    msub	w20,	w26,	w20,	w11

    lsl	w26,	w24,	#2
    add	x11,	x5,	x26
    ldr	w11,	[x11]

    add	w26,	w11,	w20
    lsl	w20,	w24,	#2
    add	w24,	w24,	#1
    add	x11,	x4,	x20
    ldr	w11,	[x11]

    add	w11,	w26,	w11
    cmp	w24,	w0
    blt	main_240

main_256:
    add	w4,	w18,	#1
    cmp	w4,	w23
    bge	main_262

main_231:
    mov	w18,	w4
    b	main_232

main_262:
    add	w26,	w17,	#1
    cmp	w26,	w19
    bge	main_268

main_223:
    mov	w17,	w26
    b	main_224

main_268:
    add	w13,	w6,	#1
    cmp	w13,	w28
    bge	main_274

main_215:
    mov	w6,	w13
    b	main_216

main_274:
    add	w9,	w10,	#1
    cmp	w9,	w27
    bge	main_280

main_207:
    mov	w10,	w9
    b	main_208

main_280:
    add	w20,	w16,	#1
    cmp	w20,	w22
    bge	main_286

main_199:
    mov	w16,	w20
    b	main_200

main_286:
    add	w8,	w3,	#1
    cmp	w8,	w25
    bge	main_292

main_191:
    mov	w3,	w8
    b	main_192

main_292:
    mov	w0,	w11
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#34064
    movk	fp,	#2,	lsl #16
    add	sp, sp, fp
    ret


