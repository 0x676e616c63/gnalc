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
    movz	fp,	#34064
    movk	fp,	#2,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w1,	#0
    movz	w2,	#41984
    add	x0,	sp,	#16
    movk	w2,	#1,	lsl #16
    bl	memset
    movz	w1,	#0
    movz	fp,	#42000
    movz	w2,	#57600
    movk	fp,	#1,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    bl	getint
    mov	w26,	w0
    bl	getint
    mov	w24,	w0
    bl	getint
    mov	w23,	w0
    bl	getint
    mov	w25,	w0
    bl	getint
    mov	w20,	w0
    bl	getint
    mov	w28,	w0
    bl	getint
    mov	w21,	w0
    bl	getint
    mov	w22,	w0
    bl	getint
    movz	w2,	#0
    add	w9,	w24,	w26

main_13:
    cmp	w2,	w26
    blt	main_16

main_82:
    movz	w7,	#0
    b	main_85

main_16:
    cmp	w2,	w24
    blt	main_18

main_83:
    movz	w7,	#0

main_85:
    movz	w15,	#10752
    movz	w27,	#0
    mul	w2,	w7,	w15
    mov	x11,	x2
    add	x11,	sp,	x11
    add	x11,	x11,	#16

main_89:
    movz	w14,	#5376
    add	w1,	w27,	w7
    movz	w5,	#0
    madd	x4,	x27,	x14,	x11


main_94:
    lsl	w14,	w5,	#11
    movz	w17,	#0
    sub	w9,	w14,	w5,	lsl #8
    add	x26,	x4,	x9

main_98:
    lsl	w18,	w17,	#10
    add	w6,	w1,	w17
    sub	w14,	w18,	w17,	lsl #7
    add	w16,	w6,	#6
    add	w3,	w6,	#5
    add	w13,	w6,	#4
    add	w12,	w6,	#3
    add	w15,	w6,	#1
    movz	w18,	#0
    add	x19,	x26,	x14
    add	w14,	w6,	#2

main_109:
    lsl	w9,	w18,	#8
    sub	w10,	w9,	w18,	lsl #5
    add	w18,	w18,	#1
    add	x9,	x19,	x10
    mov	x2,	x9
    add	x8,	x2,	#8
    add	x24,	x2,	#4
    add	x10,	x2,	#12
    str	w6,	[x2]

    str	w15,	[x24]

    add	x24,	x2,	#16
    str	w14,	[x8]

    add	x8,	x2,	#20
    str	w12,	[x10]

    str	w13,	[x24]

    add	x24,	x2,	#24
    str	w3,	[x8]

    add	x8,	x9,	#28
    str	w16,	[x24]

    add	x2,	x8,	#12
    add	x10,	x8,	#4
    add	x24,	x8,	#8
    str	w6,	[x8]

    str	w15,	[x10]

    add	x10,	x8,	#16
    str	w14,	[x24]

    add	x24,	x8,	#20
    str	w12,	[x2]

    str	w13,	[x10]

    str	w3,	[x24]

    add	x24,	x8,	#24
    add	x8,	x9,	#56
    str	w16,	[x24]

    add	x10,	x8,	#8
    add	x2,	x8,	#4
    add	x24,	x8,	#12
    str	w6,	[x8]

    str	w15,	[x2]

    add	x2,	x8,	#16
    str	w14,	[x10]

    add	x10,	x8,	#20
    str	w12,	[x24]

    add	x24,	x8,	#24
    str	w13,	[x2]

    add	x8,	x9,	#84
    str	w3,	[x10]

    str	w16,	[x24]

    add	x2,	x8,	#8
    add	x10,	x8,	#12
    add	x24,	x8,	#4
    str	w6,	[x8]

    str	w15,	[x24]

    add	x24,	x8,	#16
    str	w14,	[x2]

    add	x2,	x8,	#20
    str	w12,	[x10]

    str	w13,	[x24]

    add	x24,	x8,	#24
    str	w3,	[x2]

    add	x8,	x9,	#112
    str	w16,	[x24]

    add	x2,	x8,	#12
    add	x10,	x8,	#4
    add	x24,	x8,	#8
    str	w6,	[x8]

    str	w15,	[x10]

    add	x10,	x8,	#16
    str	w14,	[x24]

    add	x24,	x8,	#20
    str	w12,	[x2]

    str	w13,	[x10]

    str	w3,	[x24]

    add	x24,	x8,	#24
    add	x8,	x9,	#140
    str	w16,	[x24]

    add	x10,	x8,	#8
    add	x2,	x8,	#4
    add	x24,	x8,	#12
    str	w6,	[x8]

    str	w15,	[x2]

    add	x2,	x8,	#16
    str	w14,	[x10]

    add	x10,	x8,	#20
    str	w12,	[x24]

    add	x24,	x8,	#24
    str	w13,	[x2]

    add	x8,	x9,	#168
    str	w3,	[x10]

    str	w16,	[x24]

    add	x2,	x8,	#8
    add	x10,	x8,	#12
    add	x24,	x8,	#4
    str	w6,	[x8]

    str	w15,	[x24]

    add	x24,	x8,	#16
    str	w14,	[x2]

    add	x2,	x8,	#20
    str	w12,	[x10]

    str	w13,	[x24]

    add	x24,	x8,	#24
    str	w3,	[x2]

    add	x8,	x9,	#196
    str	w16,	[x24]

    add	x2,	x8,	#12
    add	x10,	x8,	#4
    add	x9,	x8,	#16
    add	x24,	x8,	#8
    str	w6,	[x8]

    str	w15,	[x10]

    add	x10,	x8,	#20
    str	w14,	[x24]

    str	w12,	[x2]

    str	w13,	[x9]

    add	x9,	x8,	#24
    str	w3,	[x10]

    str	w16,	[x9]

    cmp	w18,	#4
    blt	main_109

main_178:
    add	w17,	w17,	#1
    cmp	w17,	#2
    blt	main_98

main_181:
    add	w5,	w5,	#1
    cmp	w5,	#3
    blt	main_94

main_184:
    add	w27,	w27,	#1
    cmp	w27,	#2
    blt	main_89

main_187:
    add	w7,	w7,	#1
    cmp	w7,	#10
    blt	main_85

main_190:
    movz	w3,	#0
    movz	w4,	#0
    mov	w8,	w3

main_192:
    cmp	w8,	#10
    bge	main_292

main_196:
    movz	w17,	#5760
    movz	fp,	#42000
    movz	w19,	#10752
    movz	w16,	#0
    mul	w1,	w8,	w17
    movk	fp,	#1,	lsl #16
    mul	w27,	w8,	w19
    mov	w26,	w16
    mov	x18,	x1
    mov	x5,	x27
    add	x18,	sp,	x18
    add	x5,	sp,	x5
    add	x18,	x18,	fp
    add	x5,	x5,	#16

main_200:
    cmp	x26,	#100
    bge	main_286

main_204:
    movz	w17,	#2880
    movz	w27,	#5376
    movz	w7,	#0
    madd	x1,	x26,	x17,	x18

    madd	x10,	x26,	x27,	x5


main_208:
    cmp	w7,	#1000
    bge	main_280

main_212:
    lsl	w27,	w7,	#10
    lsl	w2,	w7,	#11
    sub	w13,	w27,	w7,	lsl #6
    sub	w24,	w2,	w7,	lsl #8
    add	x3,	x1,	x13
    add	x15,	x10,	x24
    movz	w24,	#0
    mov	w12,	w24

main_216:
    movz	w27,	#10000
    cmp	w12,	w27
    bge	main_274

main_220:
    lsl	w11,	w12,	#8
    lsl	w16,	w12,	#10
    movz	w2,	#0
    sub	w14,	w11,	w12,	lsl #4
    sub	w19,	w16,	w12,	lsl #7
    add	x17,	x3,	x14
    add	x14,	x15,	x19

main_224:
    movz	w24,	#34464
    movk	w24,	#1,	lsl #16
    cmp	w2,	w24
    bge	main_268

main_228:
    lsl	w27,	w2,	#4
    lsl	w16,	w2,	#8
    movz	w13,	#0
    add	w6,	w27,	w2,	lsl #5
    sub	w16,	w16,	w2,	lsl #5
    mov	w24,	w13
    add	x27,	x17,	x6
    add	x9,	x14,	x16

main_232:
    movz	w6,	#16960
    movk	w6,	#15,	lsl #16
    cmp	w24,	w6
    bge	main_262

main_236:
    lsl	w6,	w24,	#3
    lsl	w13,	w24,	#5
    add	x6,	x27,	x6
    sub	w19,	w13,	w24,	lsl #2
    movz	w13,	#0
    mov	w11,	w13
    add	x16,	x9,	x19

main_240:
    movz	w13,	#38528
    movk	w13,	#152,	lsl #16
    cmp	w11,	w13
    bge	main_256

main_244:
    movz	w19,	#817
    sdiv	w13,	w4,	w19
    movz	w19,	#817
    msub	w4,	w13,	w19,	w4

    lsl	w19,	w11,	#2
    add	x13,	x6,	x19
    lsl	w19,	w11,	#2
    add	w11,	w11,	#1
    ldr	w13,	[x13]

    add	w13,	w13,	w4
    add	x4,	x16,	x19
    ldr	w4,	[x4]

    add	w4,	w13,	w4
    cmp	w11,	w0
    blt	main_240

main_256:
    add	w13,	w24,	#1
    cmp	w13,	w22
    bge	main_262

main_231:
    mov	w24,	w13
    b	main_232

main_262:
    add	w6,	w2,	#1
    cmp	w6,	w21
    bge	main_268

main_223:
    mov	w2,	w6
    b	main_224

main_268:
    add	w2,	w12,	#1
    cmp	w2,	w28
    bge	main_274

main_215:
    mov	w12,	w2
    b	main_216

main_274:
    add	w17,	w7,	#1
    cmp	w17,	w20
    bge	main_280

main_207:
    mov	w7,	w17
    b	main_208

main_280:
    add	w26,	w26,	#1
    cmp	w26,	w25
    blt	main_200

main_286:
    add	w24,	w8,	#1
    cmp	w24,	w23
    blt	main_191

main_292:
    mov	w0,	w4
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#34064
    movk	fp,	#2,	lsl #16
    add	sp, sp, fp
    ret


main_191:
    mov	w8,	w24
    b	main_192

main_18:
    movz	w14,	#5760
    movz	fp,	#42000
    add	w1,	w9,	w2
    movz	w27,	#0
    mul	w5,	w2,	w14
    movk	fp,	#1,	lsl #16
    mov	x14,	x5
    add	x14,	sp,	x14
    add	x14,	x14,	fp

main_22:
    movz	w13,	#2880
    add	w15,	w1,	w27
    movz	w3,	#0
    madd	x10,	x27,	x13,	x14


main_27:
    lsl	w18,	w3,	#10
    add	w4,	w15,	w3
    movz	w11,	#0
    sub	w7,	w18,	w3,	lsl #6
    add	x16,	x10,	x7

main_32:
    lsl	w7,	w11,	#8
    add	w6,	w4,	w11
    movz	w19,	#0
    sub	w8,	w7,	w11,	lsl #4
    add	x7,	x16,	x8

main_37:
    lsl	w5,	w19,	#4
    add	w13,	w5,	w19,	lsl #5
    add	x18,	x7,	x13
    mov	x12,	x18
    add	w13,	w6,	w19
    add	x8,	x12,	#4
    add	w19,	w19,	#1
    add	w17,	w13,	#1
    str	w13,	[x12]

    add	x12,	x18,	#8
    str	w17,	[x8]

    add	x8,	x12,	#4
    str	w17,	[x12]

    add	w12,	w17,	#1
    add	w17,	w13,	#2
    str	w12,	[x8]

    add	x12,	x18,	#24
    add	x8,	x18,	#16
    str	w17,	[x8]

    add	w17,	w17,	#1
    add	x8,	x8,	#4
    str	w17,	[x8]

    add	x17,	x12,	#4
    add	w8,	w13,	#3
    add	w5,	w8,	#1
    str	w8,	[x12]

    str	w5,	[x17]

    add	w5,	w13,	#4
    add	x17,	x18,	#32
    add	w8,	w5,	#1
    add	x12,	x17,	#4
    str	w5,	[x17]

    str	w8,	[x12]

    add	x12,	x18,	#40
    add	w18,	w13,	#5
    add	x17,	x12,	#4
    str	w18,	[x12]

    add	w12,	w18,	#1
    str	w12,	[x17]

    cmp	w19,	#5
    blt	main_37

main_71:
    add	w11,	w11,	#1
    cmp	w11,	#4
    blt	main_32

main_74:
    add	w3,	w3,	#1
    cmp	w3,	#3
    blt	main_27

main_77:
    add	w27,	w27,	#1
    cmp	w27,	#2
    blt	main_22

main_80:
    add	w2,	w2,	#1
    b	main_13

