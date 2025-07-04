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
    sub	sp, sp, #1216
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#0
    movz	w19,	#2
    add	x28,	sp,	#1156
    movz	w18,	#7
    movz	w22,	#7
    movz	w20,	#1
    movz	w23,	#8
    add	x21,	sp,	#1160
    add	x24,	sp,	#1168
    add	x25,	sp,	#1172
    add	x0,	sp,	#1184
    movz	w1,	#1
    add	x27,	sp,	#1180
    add	x26,	sp,	#1176
    str	w23,	[x28]

    add	x23,	sp,	#1164
    str	w22,	[x21]

    movz	w22,	#0
    movz	w21,	#4
    str	w21,	[x23]

    movz	w23,	#7
    add	x21,	sp,	#1208
    str	w20,	[x24]

    movz	w24,	#3
    add	x20,	sp,	#1204
    str	w19,	[x25]

    movz	w25,	#8
    add	x19,	sp,	#1200
    str	w18,	[x26]

    movz	w26,	#4
    add	x18,	sp,	#1196
    str	w2,	[x27]

    movz	w27,	#3
    add	x2,	sp,	#1188
    str	w1,	[x0]

    movz	w1,	#1
    movz	w0,	#9
    str	w0,	[x2]

    movz	w0,	#4
    add	x2,	sp,	#1192
    str	w27,	[x2]

    add	x27,	sp,	#32
    movz	w2,	#7
    str	w26,	[x18]

    add	x26,	sp,	#28
    movz	w18,	#9
    str	w25,	[x19]

    add	x25,	sp,	#24
    movz	w19,	#3
    str	w24,	[x20]

    add	x24,	sp,	#20
    add	x20,	sp,	#56
    str	w23,	[x21]

    movz	w21,	#0
    add	x23,	sp,	#1212
    str	w22,	[x23]

    movz	w22,	#8
    add	x23,	sp,	#16
    str	w19,	[x23]

    add	x19,	sp,	#52
    str	w18,	[x24]

    movz	w24,	#6
    add	x18,	sp,	#48
    str	w2,	[x25]

    movz	w25,	#3
    add	x2,	sp,	#44
    str	w1,	[x26]

    movz	w26,	#4
    add	x1,	sp,	#40
    str	w0,	[x27]

    movz	w27,	#2
    add	x0,	sp,	#36
    str	w27,	[x0]

    add	x0,	sp,	#1092
    str	w26,	[x1]

    movz	w1,	#0
    str	w25,	[x2]

    movz	w2,	#64
    str	w24,	[x18]

    add	x24,	sp,	#64
    str	w22,	[x19]

    movz	w19,	#5
    add	x22,	sp,	#60
    str	w21,	[x20]

    movz	w20,	#1
    str	w20,	[x22]

    str	w19,	[x24]

    bl	memset
    movz	w7,	#2
    movz	w18,	#8
    add	x15,	sp,	#1096
    movz	w19,	#8
    add	x14,	sp,	#1092
    str	w19,	[x14]

    str	w18,	[x15]


main_36:
    cmp	w7,	#10
    blt	main_39

main_162:
    lsl	w19,	w7,	#2
    sub	w20,	w7,	#2
    lsl	w26,	w7,	#2
    sub	w1,	w7,	#1
    mov	x16,	x19
    lsl	w22,	w20,	#2
    add	x25,	x28,	x26
    lsl	w3,	w1,	#2
    add	x16,	sp,	x16
    mov	x21,	x22
    mov	x2,	x3
    add	x21,	sp,	x21
    add	x2,	sp,	x2
    add	x16,	x16,	#1092
    add	x21,	x21,	#1092
    add	x2,	x2,	#1092
    ldr	w22,	[x21]

    ldr	w27,	[x25]

    ldr	w11,	[x2]

    add	w9,	w27,	w22
    cmp	w9,	w11
    csel	w6,	w9,	w11,	gt
    cmp	w9,	w11
    add	w7,	w7,	#1
    csel	w9,	w9,	w6,	eq
    str	w9,	[x16]

    cmp	w7,	#15
    blt	main_162

main_180:
    add	x18,	sp,	#1148
    ldr	w0,	[x18]

    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w2,	#1024
    movz	w1,	#0
    add	x0,	sp,	#68
    bl	memset
    movz	w8,	#1

main_185:
    sub	w22,	w8,	#1
    lsl	w27,	w8,	#6
    mov	x14,	x27
    add	x14,	sp,	x14
    lsl	w7,	w22,	#6
    lsl	w17,	w22,	#2
    mov	x15,	x7
    add	x14,	x14,	#68
    add	x16,	x28,	x17
    add	x15,	sp,	x15
    ldr	w24,	[x16]

    add	x15,	x15,	#68
    cmp	w24,	#3
    beq	main_193

main_198:
    add	x16,	x14,	#4
    add	x3,	x15,	#4
    ldr	w10,	[x3]

    ldr	w19,	[x14]

    cmp	w10,	w19
    csel	w9,	w10,	w19,	gt
    cmp	w10,	w19
    csel	w11,	w10,	w9,	eq
    str	w11,	[x16]

    b	main_208

main_193:
    add	x20,	x14,	#4
    ldr	w16,	[x15]

    add	w17,	w16,	#1
    str	w17,	[x20]


main_208:
    cmp	w24,	#9
    beq	main_210

main_215:
    add	x21,	x14,	#8
    add	x20,	x15,	#8
    add	x22,	x14,	#4
    ldr	w11,	[x20]

    ldr	w7,	[x22]

    cmp	w11,	w7
    csel	w27,	w11,	w7,	gt
    cmp	w11,	w7
    csel	w1,	w11,	w27,	eq
    str	w1,	[x21]

    b	main_225

main_210:
    add	x22,	x14,	#8
    add	x3,	x15,	#4
    ldr	w4,	[x3]

    add	w5,	w4,	#1
    str	w5,	[x22]


main_225:
    cmp	w24,	#7
    beq	main_227

main_232:
    add	x19,	x14,	#12
    add	x9,	x15,	#12
    add	x11,	x14,	#8
    ldr	w3,	[x9]

    ldr	w27,	[x11]

    cmp	w3,	w27
    csel	w16,	w3,	w27,	gt
    cmp	w3,	w27
    csel	w18,	w3,	w16,	eq
    str	w18,	[x19]

    b	main_242

main_227:
    add	x11,	x14,	#12
    add	x20,	x15,	#8
    ldr	w21,	[x20]

    add	w22,	w21,	#1
    str	w22,	[x11]


main_242:
    cmp	w24,	#1
    beq	main_244

main_249:
    add	x12,	x14,	#16
    add	x27,	x15,	#16
    add	x1,	x14,	#12
    ldr	w25,	[x27]

    ldr	w17,	[x1]

    cmp	w25,	w17
    csel	w4,	w25,	w17,	gt
    cmp	w25,	w17
    csel	w6,	w25,	w4,	eq
    str	w6,	[x12]

    b	main_259

main_244:
    add	x4,	x14,	#16
    add	x9,	x15,	#12
    ldr	w10,	[x9]

    add	w11,	w10,	#1
    str	w11,	[x4]


main_259:
    cmp	w24,	#4
    beq	main_261

main_266:
    add	x6,	x14,	#20
    add	x16,	x15,	#20
    add	x18,	x14,	#16
    ldr	w13,	[x16]

    ldr	w5,	[x18]

    cmp	w13,	w5
    csel	w21,	w13,	w5,	gt
    cmp	w13,	w5
    csel	w25,	w13,	w21,	eq
    str	w25,	[x6]

    b	main_276

main_261:
    add	x25,	x14,	#20
    add	x27,	x15,	#16
    ldr	w0,	[x27]

    add	w1,	w0,	#1
    str	w1,	[x25]


main_276:
    cmp	w24,	#2
    beq	main_278

main_283:
    add	x2,	x14,	#24
    add	x4,	x15,	#24
    add	x6,	x14,	#20
    ldr	w5,	[x4]

    ldr	w25,	[x6]

    cmp	w5,	w25
    csel	w10,	w5,	w25,	gt
    cmp	w5,	w25
    csel	w12,	w5,	w10,	eq
    str	w12,	[x2]

    b	main_293

main_278:
    add	x13,	x14,	#24
    add	x16,	x15,	#20
    ldr	w17,	[x16]

    add	w18,	w17,	#1
    str	w18,	[x13]


main_293:
    cmp	w24,	#4
    beq	main_295

main_300:
    add	x26,	x14,	#28
    add	x21,	x15,	#28
    add	x25,	x14,	#24
    ldr	w27,	[x21]

    ldr	w13,	[x25]

    cmp	w27,	w13
    csel	w0,	w27,	w13,	gt
    cmp	w27,	w13
    csel	w2,	w27,	w0,	eq
    movz	w0,	#8
    str	w2,	[x26]

    b	main_311

main_295:
    add	x10,	x14,	#28
    add	x4,	x15,	#24
    movz	w0,	#8
    ldr	w5,	[x4]

    add	w6,	w5,	#1
    str	w6,	[x10]


main_311:
    sub	w25,	w0,	#1
    lsl	w1,	w25,	#2
    add	x27,	x23,	x1
    ldr	w2,	[x27]

    cmp	w24,	w2
    beq	main_317

main_325:
    lsl	w5,	w0,	#2
    lsl	w7,	w0,	#2
    lsl	w11,	w25,	#2
    add	x4,	x14,	x5
    add	x6,	x15,	x7
    add	x10,	x14,	x11
    ldr	w9,	[x6]

    ldr	w12,	[x10]

    cmp	w9,	w12
    csel	w16,	w9,	w12,	gt
    cmp	w9,	w12
    csel	w18,	w9,	w16,	eq
    str	w18,	[x4]

    b	main_322

main_317:
    lsl	w20,	w0,	#2
    lsl	w22,	w25,	#2
    add	x19,	x14,	x20
    add	x21,	x15,	x22
    ldr	w25,	[x21]

    add	w26,	w25,	#1
    str	w26,	[x19]


main_322:
    add	w0,	w0,	#1
    cmp	w0,	#13
    ble	main_311

main_335:
    add	w8,	w8,	#1
    cmp	w8,	#15
    ble	main_185

main_338:
    add	x18,	sp,	#1028
    add	x19,	x18,	#52
    ldr	w0,	[x19]

    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #1216
    ret


main_39:
    lsl	w22,	w7,	#2
    sub	w24,	w7,	#2
    lsl	w1,	w7,	#2
    sub	w4,	w7,	#1
    mov	x16,	x22
    lsl	w26,	w24,	#2
    add	x0,	x28,	x1
    lsl	w6,	w4,	#2
    add	x16,	sp,	x16
    mov	x25,	x26
    mov	x5,	x6
    add	x25,	sp,	x25
    add	x5,	sp,	x5
    add	x16,	x16,	#1092
    add	x25,	x25,	#1092
    add	x5,	x5,	#1092
    ldr	w24,	[x25]

    ldr	w2,	[x0]

    add	w22,	w2,	w24
    ldr	w20,	[x5]

    cmp	w22,	w20
    csel	w10,	w22,	w20,	gt
    cmp	w22,	w20
    add	w20,	w7,	#1
    csel	w12,	w22,	w10,	eq
    str	w12,	[x16]

    sub	w22,	w20,	#2
    lsl	w21,	w20,	#2
    lsl	w0,	w20,	#2
    sub	w3,	w20,	#1
    mov	x12,	x21
    lsl	w25,	w22,	#2
    add	x27,	x28,	x0
    lsl	w5,	w3,	#2
    add	x12,	sp,	x12
    mov	x24,	x25
    mov	x4,	x5
    add	x24,	sp,	x24
    add	x4,	sp,	x4
    add	x12,	x12,	#1092
    add	x24,	x24,	#1092
    add	x4,	x4,	#1092
    ldr	w18,	[x24]

    ldr	w1,	[x27]

    add	w17,	w1,	w18
    ldr	w0,	[x4]

    cmp	w17,	w0
    csel	w8,	w17,	w0,	gt
    cmp	w17,	w0
    add	w7,	w20,	#1
    csel	w10,	w17,	w8,	eq
    str	w10,	[x12]

    sub	w14,	w7,	#2
    lsl	w19,	w7,	#2
    lsl	w13,	w7,	#2
    sub	w22,	w7,	#1
    add	x18,	x28,	x19
    mov	x17,	x13
    lsl	w16,	w14,	#2
    add	x17,	sp,	x17
    lsl	w25,	w22,	#2
    mov	x15,	x16
    mov	x24,	x25
    add	x15,	sp,	x15
    add	x17,	x17,	#1092
    add	x24,	sp,	x24
    add	x15,	x15,	#1092
    add	x24,	x24,	#1092
    ldr	w11,	[x15]

    ldr	w20,	[x18]

    add	w10,	w20,	w11
    ldr	w20,	[x24]

    cmp	w10,	w20
    csel	w0,	w10,	w20,	gt
    cmp	w10,	w20
    csel	w2,	w10,	w0,	eq
    str	w2,	[x17]

    add	w0,	w7,	#1
    lsl	w5,	w0,	#2
    lsl	w11,	w0,	#2
    sub	w6,	w0,	#2
    sub	w14,	w0,	#1
    mov	x1,	x5
    add	x10,	x28,	x11
    add	x1,	sp,	x1
    lsl	w8,	w6,	#2
    lsl	w16,	w14,	#2
    mov	x7,	x8
    mov	x15,	x16
    add	x1,	x1,	#1092
    add	x7,	sp,	x7
    add	x15,	sp,	x15
    add	x7,	x7,	#1092
    add	x15,	x15,	#1092
    ldr	w6,	[x7]

    ldr	w12,	[x10]

    add	w6,	w12,	w6
    ldr	w12,	[x15]

    cmp	w6,	w12
    csel	w19,	w6,	w12,	gt
    cmp	w6,	w12
    csel	w21,	w6,	w19,	eq
    add	w19,	w0,	#1
    str	w21,	[x1]

    sub	w26,	w19,	#2
    lsl	w3,	w19,	#2
    sub	w6,	w19,	#1
    lsl	w25,	w19,	#2
    add	x2,	x28,	x3
    mov	x17,	x25
    lsl	w0,	w26,	#2
    add	x17,	sp,	x17
    lsl	w8,	w6,	#2
    mov	x27,	x0
    mov	x7,	x8
    add	x27,	sp,	x27
    add	x17,	x17,	#1092
    add	x7,	sp,	x7
    add	x27,	x27,	#1092
    add	x7,	x7,	#1092
    ldr	w1,	[x27]

    ldr	w4,	[x2]

    ldr	w5,	[x7]

    add	w3,	w4,	w1
    cmp	w3,	w5
    csel	w11,	w3,	w5,	gt
    cmp	w3,	w5
    add	w14,	w19,	#1
    csel	w13,	w3,	w11,	eq
    str	w13,	[x17]

    lsl	w22,	w14,	#2
    sub	w26,	w14,	#1
    lsl	w16,	w14,	#2
    sub	w17,	w14,	#2
    add	x21,	x28,	x22
    mov	x1,	x16
    lsl	w0,	w26,	#2
    add	x1,	sp,	x1
    lsl	w19,	w17,	#2
    mov	x27,	x0
    mov	x18,	x19
    add	x27,	sp,	x27
    add	x1,	x1,	#1092
    add	x18,	sp,	x18
    add	x27,	x27,	#1092
    add	x18,	x18,	#1092
    ldr	w20,	[x18]

    ldr	w24,	[x21]

    ldr	w26,	[x27]

    add	w5,	w24,	w20
    cmp	w5,	w26
    csel	w3,	w5,	w26,	gt
    cmp	w5,	w26
    csel	w5,	w5,	w3,	eq
    add	w3,	w14,	#1
    str	w5,	[x1]

    lsl	w14,	w3,	#2
    sub	w9,	w3,	#2
    sub	w17,	w3,	#1
    lsl	w8,	w3,	#2
    add	x13,	x28,	x14
    mov	x4,	x8
    lsl	w11,	w9,	#2
    add	x4,	sp,	x4
    lsl	w19,	w17,	#2
    mov	x10,	x11
    add	x10,	sp,	x10
    add	x4,	x4,	#1092
    add	x10,	x10,	#1092
    ldr	w18,	[x10]

    ldr	w15,	[x13]

    add	w27,	w15,	w18
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	#1092
    ldr	w17,	[x18]

    cmp	w27,	w17
    csel	w22,	w27,	w17,	gt
    cmp	w27,	w17
    csel	w25,	w27,	w22,	eq
    add	w17,	w3,	#1
    str	w25,	[x4]

    sub	w9,	w17,	#1
    lsl	w6,	w17,	#2
    sub	w1,	w17,	#2
    lsl	w0,	w17,	#2
    add	x5,	x28,	x6
    mov	x19,	x0
    lsl	w11,	w9,	#2
    add	x19,	sp,	x19
    lsl	w3,	w1,	#2
    mov	x10,	x11
    mov	x2,	x3
    add	x10,	sp,	x10
    add	x19,	x19,	#1092
    add	x2,	sp,	x2
    add	x10,	x10,	#1092
    add	x2,	x2,	#1092
    ldr	w13,	[x2]

    ldr	w7,	[x5]

    ldr	w10,	[x10]

    add	w22,	w7,	w13
    cmp	w22,	w10
    csel	w14,	w22,	w10,	gt
    cmp	w22,	w10
    add	w7,	w17,	#1
    csel	w16,	w22,	w14,	eq
    str	w16,	[x19]

    b	main_36

