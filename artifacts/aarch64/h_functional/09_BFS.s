.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#52128
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#4020
    movz	w1,	#0
    movz	fp,	#20036
    add	x0,	sp,	fp
    bl	memset
    movz	w2,	#4020
    movz	w1,	#0
    movz	fp,	#24056
    add	x0,	sp,	fp
    bl	memset
    movz	w2,	#4020
    movz	w1,	#0
    movz	fp,	#28076
    add	x0,	sp,	fp
    bl	memset
    movz	w2,	#20020
    movz	w1,	#0
    movz	fp,	#32096
    add	x0,	sp,	fp
    bl	memset
    movz	w2,	#20020
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    bl	getch
    mov	w27,	w0

main_7:
    cmp	w27,	#48
    blt	main_14

main_10:
    cmp	w27,	#57
    bgt	main_14

main_17:
    cmp	w27,	#48
    blt	main_26

main_20:
    cmp	w27,	#57
    bgt	main_26

main_22:
    bl	getch
    mov	w27,	w0
    b	main_17

main_26:
    bl	getch
    movz	w23,	#0
    mov	w2,	w0

main_28:
    cmp	w2,	#48
    blt	main_36

main_32:
    cmp	w2,	#57
    bgt	main_36

main_40:
    movz	w25,	#0

main_41:
    cmp	w2,	#48
    blt	main_54

main_45:
    cmp	w2,	#57
    bgt	main_54

main_47:
    lsl	w19,	w25,	#1
    add	w22,	w19,	w25,	lsl #3
    add	w24,	w2,	w22
    sub	w25,	w24,	#48
    bl	getch
    mov	w2,	w0
    b	main_41

main_54:
    movz	w6,	#0
    sub	w9,	w6,	w25
    cmp	w23,	#0
    movz	w17,	#0
    csel	w16,	w9,	w25,	ne

main_58:
    movz	w4,	#65535
    movk	w4,	#65535,	lsl #16
    mov	w22,	w4
    cmp	w17,	#952
    bge	main_176

main_61:
    lsl	w21,	w17,	#2
    movz	fp,	#28076
    mov	w9,	w22
    add	w20,	w17,	#1
    mov	w7,	w22
    mov	w5,	w22
    mov	w3,	w22
    mov	w1,	w22
    mov	w23,	w22
    mov	w19,	w22
    mov	x27,	x21
    lsl	w18,	w20,	#2
    add	x27,	sp,	x27
    mov	x24,	x18
    add	x24,	sp,	x24
    add	x27,	x27,	fp
    movz	fp,	#28076
    str	w9,	[x27]

    add	x24,	x24,	fp
    movz	fp,	#28076
    str	w7,	[x24]

    add	w24,	w20,	#1
    add	w28,	w24,	#1
    lsl	w21,	w24,	#2
    mov	x27,	x21
    mov	w21,	w22
    add	x27,	sp,	x27
    add	w4,	w28,	#1
    lsl	w25,	w28,	#2
    mov	x2,	x25
    add	x27,	x27,	fp
    mov	w25,	w22
    add	w7,	w4,	#1
    lsl	w28,	w4,	#2
    add	x2,	sp,	x2
    movz	fp,	#28076
    str	w5,	[x27]

    mov	x6,	x28
    add	w10,	w7,	#1
    mov	w27,	w22
    add	x2,	x2,	fp
    mov	w28,	w22
    add	x6,	sp,	x6
    movz	fp,	#28076
    add	w13,	w10,	#1
    str	w3,	[x2]

    add	x6,	x6,	fp
    lsl	w3,	w7,	#2
    add	w17,	w13,	#1
    lsl	w9,	w13,	#2
    movz	fp,	#28076
    mov	x8,	x3
    str	w1,	[x6]

    mov	x14,	x9
    lsl	w12,	w17,	#2
    add	x8,	sp,	x8
    lsl	w6,	w10,	#2
    add	x14,	sp,	x14
    mov	x18,	x12
    mov	w10,	w22
    add	x8,	x8,	fp
    mov	x11,	x6
    mov	w12,	w22
    add	x18,	sp,	x18
    movz	fp,	#28076
    mov	w6,	w22
    add	x11,	sp,	x11
    str	w27,	[x8]

    mov	w8,	w22
    add	x11,	x11,	fp
    movz	fp,	#28076
    str	w25,	[x11]

    add	x14,	x14,	fp
    movz	fp,	#28076
    str	w23,	[x14]

    add	x18,	x18,	fp
    mov	w14,	w22
    movz	fp,	#28076
    str	w21,	[x18]

    add	w21,	w17,	#1
    mov	w17,	w22
    add	w25,	w21,	#1
    lsl	w15,	w21,	#2
    mov	x23,	x15
    mov	w15,	w22
    add	x23,	sp,	x23
    add	w2,	w25,	#1
    add	x23,	x23,	fp
    add	w5,	w2,	#1
    movz	fp,	#28076
    str	w19,	[x23]

    add	w9,	w5,	#1
    lsl	w23,	w2,	#2
    lsl	w19,	w25,	#2
    mov	w2,	w22
    mov	x1,	x23
    mov	x26,	x19
    add	w13,	w9,	#1
    mov	w23,	w22
    add	x1,	sp,	x1
    add	x26,	sp,	x26
    add	x26,	x26,	fp
    movz	fp,	#28076
    str	w17,	[x26]

    add	x1,	x1,	fp
    add	w17,	w13,	#1
    lsl	w26,	w5,	#2
    movz	fp,	#28076
    mov	x4,	x26
    str	w14,	[x1]

    add	x4,	sp,	x4
    add	w20,	w17,	#1
    lsl	w1,	w9,	#2
    mov	x7,	x1
    add	x4,	x4,	fp
    mov	w1,	w22
    add	w24,	w20,	#1
    add	x7,	sp,	x7
    movz	fp,	#28076
    str	w12,	[x4]

    add	w26,	w24,	#1
    add	x7,	x7,	fp
    lsl	w4,	w13,	#2
    movz	fp,	#28076
    lsl	w13,	w24,	#2
    mov	x11,	x4
    str	w10,	[x7]

    mov	x21,	x13
    mov	w4,	w22
    add	x11,	sp,	x11
    lsl	w10,	w20,	#2
    lsl	w7,	w17,	#2
    add	x21,	sp,	x21
    mov	x18,	x10
    add	x11,	x11,	fp
    lsl	w17,	w26,	#2
    mov	x14,	x7
    add	x18,	sp,	x18
    movz	fp,	#28076
    mov	x24,	x17
    str	w8,	[x11]

    mov	w7,	w22
    add	x14,	sp,	x14
    add	x24,	sp,	x24
    add	x14,	x14,	fp
    movz	fp,	#28076
    str	w6,	[x14]

    add	x18,	x18,	fp
    movz	fp,	#28076
    str	w4,	[x18]

    add	x21,	x21,	fp
    mov	w18,	w22
    movz	fp,	#28076
    str	w2,	[x21]

    add	x24,	x24,	fp
    add	w2,	w26,	#1
    movz	fp,	#28076
    mov	w26,	w22
    str	w28,	[x24]

    lsl	w20,	w2,	#2
    add	w11,	w2,	#1
    mov	x28,	x20
    mov	w20,	w22
    add	x28,	sp,	x28
    add	w13,	w11,	#1
    lsl	w24,	w11,	#2
    mov	x3,	x24
    add	x28,	x28,	fp
    mov	w24,	w22
    lsl	w27,	w13,	#2
    add	x3,	sp,	x3
    movz	fp,	#28076
    add	w13,	w13,	#1
    str	w26,	[x28]

    add	x3,	x3,	fp
    mov	x26,	x27
    add	w17,	w13,	#1
    lsl	w2,	w13,	#2
    movz	fp,	#28076
    add	x26,	sp,	x26
    str	w24,	[x3]

    mov	w13,	w22
    mov	x9,	x2
    add	w21,	w17,	#1
    lsl	w5,	w17,	#2
    add	x26,	x26,	fp
    add	x9,	sp,	x9
    mov	x12,	x5
    add	w25,	w21,	#1
    lsl	w8,	w21,	#2
    movz	fp,	#28076
    str	w22,	[x26]

    mov	w5,	w22
    add	x12,	sp,	x12
    add	w28,	w25,	#1
    lsl	w11,	w25,	#2
    mov	x17,	x8
    add	x9,	x9,	fp
    add	x17,	sp,	x17
    movz	fp,	#28076
    add	w3,	w28,	#1
    lsl	w14,	w28,	#2
    str	w20,	[x9]

    add	x12,	x12,	fp
    mov	x24,	x14
    mov	w9,	w22
    add	w8,	w3,	#1
    mov	x20,	x11
    movz	fp,	#28076
    str	w18,	[x12]

    add	x24,	sp,	x24
    mov	w11,	w22
    add	x20,	sp,	x20
    lsl	w21,	w8,	#2
    add	x17,	x17,	fp
    lsl	w18,	w3,	#2
    mov	x2,	x21
    movz	fp,	#28076
    mov	w3,	w22
    mov	x27,	x18
    str	w15,	[x17]

    add	x2,	sp,	x2
    add	x20,	x20,	fp
    add	x27,	sp,	x27
    mov	w17,	w22
    movz	fp,	#28076
    str	w13,	[x20]

    add	x24,	x24,	fp
    movz	fp,	#28076
    str	w11,	[x24]

    add	x27,	x27,	fp
    add	w11,	w8,	#1
    movz	fp,	#28076
    mov	w8,	w22
    str	w9,	[x27]

    add	x2,	x2,	fp
    add	w14,	w11,	#1
    lsl	w25,	w11,	#2
    mov	w27,	w22
    movz	fp,	#28076
    str	w7,	[x2]

    mov	x6,	x25
    add	w19,	w14,	#1
    lsl	w28,	w14,	#2
    mov	w25,	w22
    add	x6,	sp,	x6
    mov	x9,	x28
    add	w21,	w19,	#1
    add	x9,	sp,	x9
    add	x6,	x6,	fp
    movz	fp,	#28076
    add	w26,	w21,	#1
    str	w5,	[x6]

    add	x9,	x9,	fp
    lsl	w6,	w21,	#2
    movz	fp,	#28076
    mov	x14,	x6
    str	w3,	[x9]

    mov	w6,	w22
    add	x14,	sp,	x14
    lsl	w9,	w26,	#2
    lsl	w3,	w19,	#2
    mov	x18,	x9
    mov	x12,	x3
    add	x18,	sp,	x18
    add	x12,	sp,	x12
    add	x12,	x12,	fp
    movz	fp,	#28076
    str	w1,	[x12]

    add	x14,	x14,	fp
    add	w1,	w26,	#1
    movz	fp,	#28076
    str	w27,	[x14]

    add	x18,	x18,	fp
    add	w4,	w1,	#1
    lsl	w12,	w1,	#2
    mov	w14,	w22
    movz	fp,	#28076
    str	w25,	[x18]

    mov	x21,	x12
    add	w11,	w4,	#1
    lsl	w15,	w4,	#2
    mov	w12,	w22
    add	x21,	sp,	x21
    mov	x26,	x15
    lsl	w19,	w11,	#2
    add	x26,	sp,	x26
    add	x21,	x21,	fp
    add	w11,	w11,	#1
    mov	x1,	x19
    movz	fp,	#28076
    mov	w19,	w22
    add	x1,	sp,	x1
    str	w23,	[x21]

    add	w15,	w11,	#1
    add	x26,	x26,	fp
    lsl	w23,	w11,	#2
    mov	w21,	w22
    movz	fp,	#28076
    add	w20,	w15,	#1
    mov	x4,	x23
    str	w21,	[x26]

    add	x1,	x1,	fp
    add	x4,	sp,	x4
    lsl	w26,	w15,	#2
    add	w24,	w20,	#1
    movz	fp,	#28076
    str	w19,	[x1]

    mov	x7,	x26
    add	x4,	x4,	fp
    lsl	w1,	w20,	#2
    add	w27,	w24,	#1
    mov	w26,	w22
    add	x7,	sp,	x7
    movz	fp,	#28076
    str	w17,	[x4]

    mov	x10,	x1
    add	w2,	w27,	#1
    lsl	w4,	w24,	#2
    add	x7,	x7,	fp
    add	x10,	sp,	x10
    movz	fp,	#28076
    str	w14,	[x7]

    add	x10,	x10,	fp
    mov	x14,	x4
    lsl	w7,	w27,	#2
    movz	fp,	#28076
    mov	w4,	w22
    str	w12,	[x10]

    add	x14,	sp,	x14
    mov	x18,	x7
    mov	w10,	w22
    mov	w7,	w22
    add	x18,	sp,	x18
    add	x14,	x14,	fp
    movz	fp,	#28076
    str	w10,	[x14]

    add	x18,	x18,	fp
    lsl	w10,	w2,	#2
    movz	fp,	#28076
    mov	x21,	x10
    str	w8,	[x18]

    add	x21,	sp,	x21
    mov	w18,	w22
    add	x21,	x21,	fp
    movz	fp,	#28076
    str	w6,	[x21]

    add	w6,	w2,	#1
    mov	w2,	w22
    add	w9,	w6,	#1
    lsl	w13,	w6,	#2
    mov	x25,	x13
    mov	w13,	w22
    add	x25,	sp,	x25
    add	w12,	w9,	#1
    lsl	w17,	w9,	#2
    mov	x28,	x17
    add	x25,	x25,	fp
    add	x28,	sp,	x28
    add	w15,	w12,	#1
    lsl	w20,	w12,	#2
    movz	fp,	#28076
    mov	x3,	x20
    str	w4,	[x25]

    mov	w20,	w22
    add	w19,	w15,	#1
    lsl	w24,	w15,	#2
    add	x3,	sp,	x3
    add	x28,	x28,	fp
    mov	x6,	x24
    movz	fp,	#28076
    lsl	w27,	w19,	#2
    mov	w24,	w22
    str	w2,	[x28]

    add	x6,	sp,	x6
    add	x3,	x3,	fp
    mov	x9,	x27
    mov	w28,	w22
    movz	fp,	#28076
    add	x9,	sp,	x9
    str	w28,	[x3]

    add	x6,	x6,	fp
    movz	fp,	#28076
    str	w26,	[x6]

    add	x9,	x9,	fp
    add	w26,	w19,	#1
    movz	fp,	#28076
    str	w24,	[x9]

    add	w28,	w26,	#1
    lsl	w2,	w26,	#2
    mov	x1,	x2
    add	x1,	sp,	x1
    add	w3,	w28,	#1
    lsl	w5,	w28,	#2
    mov	x15,	x5
    add	x1,	x1,	fp
    add	x15,	sp,	x15
    add	w6,	w3,	#1
    lsl	w8,	w3,	#2
    movz	fp,	#28076
    str	w22,	[x1]

    add	w9,	w6,	#1
    lsl	w11,	w6,	#2
    add	x15,	x15,	fp
    mov	x24,	x11
    movz	fp,	#28076
    mov	w11,	w22
    lsl	w14,	w9,	#2
    add	x24,	sp,	x24
    str	w20,	[x15]

    mov	x27,	x14
    mov	w15,	w22
    mov	x20,	x8
    add	w14,	w9,	#1
    add	x27,	sp,	x27
    add	x20,	sp,	x20
    mov	w9,	w22
    add	x20,	x20,	fp
    movz	fp,	#28076
    str	w18,	[x20]

    add	x24,	x24,	fp
    lsl	w18,	w14,	#2
    movz	fp,	#28076
    mov	x2,	x18
    str	w15,	[x24]

    add	x27,	x27,	fp
    add	w18,	w14,	#1
    add	x2,	sp,	x2
    movz	fp,	#28076
    str	w13,	[x27]

    lsl	w21,	w18,	#2
    add	x2,	x2,	fp
    mov	x5,	x21
    movz	fp,	#28076
    add	w21,	w18,	#1
    add	x5,	sp,	x5
    str	w11,	[x2]

    add	w17,	w21,	#1
    lsl	w25,	w21,	#2
    add	x5,	x5,	fp
    movz	fp,	#28076
    str	w9,	[x5]

    mov	x9,	x25
    add	x9,	sp,	x9
    add	x9,	x9,	fp
    str	w7,	[x9]

    b	main_58

main_176:
    lsl	w12,	w17,	#2
    movz	fp,	#28076
    mov	w26,	w22
    add	w1,	w17,	#1
    mov	w24,	w22
    mov	w20,	w22
    mov	w18,	w22
    mov	w13,	w22
    mov	w11,	w22
    mov	x27,	x12
    add	w4,	w1,	#1
    lsl	w3,	w1,	#2
    add	x27,	sp,	x27
    mov	x14,	x3
    add	x14,	sp,	x14
    add	w7,	w4,	#1
    lsl	w6,	w4,	#2
    add	x27,	x27,	fp
    mov	x5,	x6
    movz	fp,	#28076
    add	x5,	sp,	x5
    add	w10,	w7,	#1
    lsl	w9,	w7,	#2
    str	w26,	[x27]

    add	x14,	x14,	fp
    mov	x23,	x9
    movz	fp,	#28076
    lsl	w12,	w10,	#2
    add	x23,	sp,	x23
    str	w24,	[x14]

    add	x5,	x5,	fp
    mov	x26,	x12
    add	w14,	w10,	#1
    movz	fp,	#28076
    add	x26,	sp,	x26
    str	w22,	[x5]

    lsl	w15,	w14,	#2
    add	x23,	x23,	fp
    mov	x1,	x15
    movz	fp,	#28076
    mov	w15,	w22
    add	x1,	sp,	x1
    str	w20,	[x23]

    add	x26,	x26,	fp
    add	w20,	w14,	#1
    movz	fp,	#28076
    str	w18,	[x26]

    add	x1,	x1,	fp
    add	w24,	w20,	#1
    lsl	w19,	w20,	#2
    movz	fp,	#28076
    mov	x4,	x19
    str	w15,	[x1]

    add	x4,	sp,	x4
    add	w17,	w24,	#1
    lsl	w23,	w24,	#2
    mov	x7,	x23
    add	x4,	x4,	fp
    add	x7,	sp,	x7
    movz	fp,	#28076
    str	w13,	[x4]

    add	x7,	x7,	fp
    str	w11,	[x7]

    cmp	w17,	#1000
    blt	main_176

main_197:
    lsl	w12,	w17,	#2
    movz	fp,	#28076
    mov	w28,	w22
    add	w17,	w17,	#1
    mov	x27,	x12
    add	x27,	sp,	x27
    add	x27,	x27,	fp
    str	w28,	[x27]

    cmp	w17,	#1005
    blt	main_197

main_202:
    cmp	w16,	#0
    beq	main_412

main_204:
    movz	fp,	#24060
    movz	w12,	#0
    mov	w24,	w16
    mov	w20,	w12
    add	x19,	sp,	fp

main_207:
    bl	getch
    mov	w25,	w0

main_211:
    cmp	w25,	#81
    beq	main_220

main_214:
    cmp	w25,	#85
    beq	main_220

main_216:
    bl	getch
    mov	w25,	w0
    b	main_211

main_220:
    cmp	w25,	#81
    bne	main_333

main_222:
    bl	getch
    movz	w27,	#0
    mov	w12,	w0

main_224:
    cmp	w12,	#48
    blt	main_232

main_228:
    cmp	w12,	#57
    bgt	main_232

main_236:
    movz	w23,	#0

main_237:
    cmp	w12,	#48
    blt	main_250

main_241:
    cmp	w12,	#57
    bgt	main_250

main_243:
    lsl	w21,	w23,	#1
    add	w25,	w21,	w23,	lsl #3
    add	w26,	w12,	w25
    sub	w23,	w26,	#48
    bl	getch
    mov	w12,	w0
    b	main_237

main_250:
    movz	w18,	#0
    sub	w18,	w18,	w23
    cmp	w27,	#0
    csel	w25,	w18,	w23,	ne
    bl	getch
    movz	w9,	#0
    mov	w4,	w0
    mov	w26,	w9

main_255:
    cmp	w4,	#48
    blt	main_263

main_259:
    cmp	w4,	#57
    bgt	main_263

main_267:
    movz	w17,	#0

main_268:
    cmp	w4,	#48
    blt	main_281

main_272:
    cmp	w4,	#57
    bgt	main_281

main_274:
    lsl	w23,	w17,	#1
    add	w27,	w23,	w17,	lsl #3
    add	w28,	w4,	w27
    sub	w28,	w28,	#48
    bl	getch
    mov	w17,	w28
    mov	w4,	w0
    b	main_268

main_281:
    movz	w5,	#0
    sub	w5,	w5,	w17
    cmp	w26,	#0
    movz	w26,	#1
    movz	w0,	#0
    movz	w7,	#1
    lsl	w14,	w25,	#2
    movz	fp,	#20036
    csel	w2,	w5,	w17,	ne
    mov	x10,	x14
    movz	w5,	#0
    add	x10,	sp,	x10
    add	x10,	x10,	fp
    str	w7,	[x10]

    str	w25,	[x19]


main_292:
    add	w5,	w5,	#1
    movz	fp,	#24056
    lsl	w23,	w5,	#2
    mov	x21,	x23
    add	x21,	sp,	x21
    add	x21,	x21,	fp
    ldr	w21,	[x21]

    cmp	w21,	w2
    mov	w11,	w22
    movz	fp,	#28076
    lsl	w3,	w21,	#2
    movz	w10,	#1
    mov	x1,	x3
    csel	w0,	w10,	w0,	eq
    add	x1,	sp,	x1
    add	x1,	x1,	fp
    ldr	w6,	[x1]

    cmp	w6,	w11
    beq	main_288

main_306:
    lsl	w7,	w6,	#2
    movz	fp,	#20036
    mov	x4,	x7
    add	x4,	sp,	x4
    add	x4,	x4,	#16
    ldr	w1,	[x4]

    lsl	w10,	w1,	#2
    mov	x15,	x10
    add	x15,	sp,	x15
    add	x15,	x15,	fp
    ldr	w11,	[x15]

    cmp	w11,	#0
    bne	main_318

main_314:
    movz	w11,	#1
    add	w26,	w26,	#1
    movz	fp,	#24056
    str	w11,	[x15]

    lsl	w15,	w26,	#2
    mov	x14,	x15
    add	x14,	sp,	x14
    add	x14,	x14,	fp
    str	w1,	[x14]


main_318:
    lsl	w18,	w6,	#2
    movz	fp,	#32096
    mov	w21,	w22
    mov	x17,	x18
    add	x17,	sp,	x17
    add	x17,	x17,	fp
    ldr	w6,	[x17]

    cmp	w6,	w21
    bne	main_306

main_288:
    cmp	w5,	w26
    blt	main_292

main_323:
    movz	w4,	#0

main_324:
    cmp	w4,	w26
    bgt	main_332

main_327:
    lsl	w17,	w4,	#2
    movz	fp,	#24056
    movz	w25,	#0
    add	w4,	w4,	#1
    mov	x16,	x17
    add	x16,	sp,	x16
    add	x16,	x16,	fp
    movz	fp,	#20036
    ldr	w18,	[x16]

    lsl	w23,	w18,	#2
    mov	x3,	x23
    add	x3,	sp,	x3
    add	x3,	x3,	fp
    str	w25,	[x3]

    b	main_324

main_332:
    bl	putint
    movz	w0,	#10
    bl	putch
    mov	w26,	w20
    b	main_406

main_263:
    cmp	w4,	#45
    movz	w28,	#1
    csel	w21,	w28,	w26,	eq
    bl	getch
    mov	w26,	w21
    mov	w4,	w0
    b	main_255

main_232:
    cmp	w12,	#45
    movz	w21,	#1
    csel	w27,	w21,	w27,	eq
    bl	getch
    mov	w12,	w0
    b	main_224

main_333:
    bl	getch
    movz	w25,	#0
    mov	w7,	w0

main_335:
    cmp	w7,	#48
    blt	main_343

main_339:
    cmp	w7,	#57
    bgt	main_343

main_347:
    movz	w26,	#0

main_348:
    cmp	w7,	#48
    blt	main_361

main_352:
    cmp	w7,	#57
    bgt	main_361

main_354:
    lsl	w27,	w26,	#1
    add	w21,	w27,	w26,	lsl #3
    add	w23,	w7,	w21
    sub	w26,	w23,	#48
    bl	getch
    mov	w7,	w0
    b	main_348

main_361:
    movz	w23,	#0
    sub	w28,	w23,	w26
    cmp	w25,	#0
    csel	w23,	w28,	w26,	ne
    bl	getch
    movz	w3,	#0
    mov	w16,	w0
    mov	w27,	w3

main_366:
    cmp	w16,	#48
    blt	main_374

main_370:
    cmp	w16,	#57
    bgt	main_374

main_378:
    movz	w12,	#0

main_379:
    cmp	w16,	#48
    blt	main_392

main_383:
    cmp	w16,	#57
    bgt	main_392

main_385:
    lsl	w28,	w12,	#1
    add	w25,	w28,	w12,	lsl #3
    add	w26,	w16,	w25
    sub	w26,	w26,	#48
    bl	getch
    mov	w12,	w26
    mov	w16,	w0
    b	main_379

main_392:
    movz	w6,	#0
    sub	w13,	w6,	w12
    cmp	w27,	#0
    csel	w28,	w13,	w12,	ne
    lsl	w9,	w20,	#2
    lsl	w11,	w20,	#2
    add	w10,	w20,	#1
    movz	fp,	#32096
    lsl	w26,	w28,	#2
    lsl	w13,	w23,	#2
    mov	x8,	x9
    mov	x25,	x11
    lsl	w12,	w10,	#2
    mov	x15,	x26
    add	x8,	sp,	x8
    mov	x11,	x13
    add	x25,	sp,	x25
    add	w26,	w10,	#1
    add	x15,	sp,	x15
    add	x8,	x8,	#16
    add	x11,	sp,	x11
    add	x25,	x25,	fp
    movz	fp,	#28076
    str	w28,	[x8]

    add	x11,	x11,	fp
    movz	fp,	#32096
    ldr	w14,	[x11]

    str	w14,	[x25]

    str	w20,	[x11]

    mov	x11,	x12
    add	x11,	sp,	x11
    add	x11,	x11,	#16
    str	w23,	[x11]

    lsl	w23,	w10,	#2
    mov	x18,	x23
    add	x18,	sp,	x18
    add	x18,	x18,	fp
    movz	fp,	#28076
    add	x15,	x15,	fp
    ldr	w27,	[x15]

    str	w27,	[x18]

    str	w10,	[x15]


main_406:
    sub	w1,	w24,	#1
    cmp	w1,	#0
    beq	main_412

main_206:
    mov	w20,	w26
    mov	w24,	w1
    b	main_207

main_374:
    cmp	w16,	#45
    movz	w21,	#1
    csel	w27,	w21,	w27,	eq
    bl	getch
    mov	w16,	w0
    b	main_366

main_343:
    cmp	w7,	#45
    movz	w21,	#1
    csel	w25,	w21,	w25,	eq
    bl	getch
    mov	w7,	w0
    b	main_335

main_412:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#52128
    add	sp, sp, fp
    ret


main_36:
    cmp	w2,	#45
    movz	w20,	#1
    csel	w23,	w20,	w23,	eq
    bl	getch
    mov	w2,	w0
    b	main_28

main_14:
    bl	getch
    mov	w27,	w0
    b	main_7

