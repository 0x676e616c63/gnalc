.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #1216
    stp	fp, lr, [sp, #0]
    
    movz	w1,	#1
    movz	w24,	#8
    movz	w2,	#0
    add	x20,	sp,	#1092
    movz	w23,	#7
    add	x28,	sp,	#1116
    add	x27,	sp,	#1112
    add	x25,	sp,	#1104
    movz	w18,	#7
    movz	w21,	#1
    movz	w19,	#2
    add	x26,	sp,	#1108
    add	x22,	sp,	#1096
    add	x0,	sp,	#1120
    str	w24,	[x20]

    add	x24,	sp,	#1100
    str	w23,	[x22]

    movz	w23,	#0
    movz	w22,	#4
    str	w22,	[x24]

    movz	w24,	#7
    add	x22,	sp,	#1144
    str	w21,	[x25]

    movz	w25,	#3
    add	x21,	sp,	#1140
    str	w19,	[x26]

    movz	w26,	#8
    add	x19,	sp,	#1136
    str	w18,	[x27]

    movz	w27,	#4
    add	x18,	sp,	#1132
    str	w2,	[x28]

    movz	w28,	#3
    add	x2,	sp,	#1124
    str	w1,	[x0]

    movz	w1,	#1
    movz	w0,	#9
    str	w0,	[x2]

    movz	w0,	#4
    add	x2,	sp,	#1128
    str	w28,	[x2]

    add	x28,	sp,	#1056
    movz	w2,	#7
    str	w27,	[x18]

    add	x27,	sp,	#1052
    movz	w18,	#9
    str	w26,	[x19]

    add	x26,	sp,	#1048
    movz	w19,	#3
    str	w25,	[x21]

    add	x21,	sp,	#1080
    add	x25,	sp,	#1044
    str	w24,	[x22]

    movz	w22,	#0
    add	x24,	sp,	#1148
    str	w23,	[x24]

    movz	w23,	#8
    add	x24,	sp,	#1040
    str	w19,	[x24]

    add	x19,	sp,	#1076
    str	w18,	[x25]

    movz	w25,	#6
    add	x18,	sp,	#1072
    str	w2,	[x26]

    movz	w26,	#3
    add	x2,	sp,	#1068
    str	w1,	[x27]

    movz	w27,	#4
    add	x1,	sp,	#1064
    str	w0,	[x28]

    movz	w28,	#2
    add	x0,	sp,	#1060
    str	w28,	[x0]

    add	x0,	sp,	#1152
    str	w27,	[x1]

    movz	w1,	#0
    str	w26,	[x2]

    movz	w2,	#64
    str	w25,	[x18]

    add	x25,	sp,	#1088
    str	w23,	[x19]

    movz	w19,	#5
    add	x23,	sp,	#1084
    str	w22,	[x21]

    movz	w21,	#1
    str	w21,	[x23]

    str	w19,	[x25]

    bl	memset
    movz	w7,	#2
    movz	w18,	#8
    add	x15,	sp,	#1156
    movz	w19,	#8
    add	x14,	sp,	#1152
    str	w19,	[x14]

    str	w18,	[x15]


main_36:
    cmp	w7,	#10
    bge	main_162

main_39:
    lsl	w19,	w7,	#2
    sub	w21,	w7,	#2
    lsl	w27,	w7,	#2
    sub	w1,	w7,	#1
    mov	x16,	x19
    lsl	w23,	w21,	#2
    add	x26,	x20,	x27
    lsl	w3,	w1,	#2
    add	x16,	sp,	x16
    mov	x22,	x23
    mov	x2,	x3
    add	x22,	sp,	x22
    add	x2,	sp,	x2
    add	x16,	x16,	#1152
    add	x22,	x22,	#1152
    add	x2,	x2,	#1152
    ldr	w23,	[x22]

    ldr	w28,	[x26]

    add	w9,	w28,	w23
    ldr	w11,	[x2]

    cmp	w9,	w11
    csel	w6,	w9,	w11,	gt
    cmp	w9,	w11
    add	w18,	w7,	#1
    csel	w9,	w9,	w6,	eq
    str	w9,	[x16]

    sub	w6,	w18,	#1
    lsl	w26,	w18,	#2
    sub	w27,	w18,	#2
    lsl	w3,	w18,	#2
    mov	x22,	x26
    lsl	w8,	w6,	#2
    add	x2,	x20,	x3
    lsl	w0,	w27,	#2
    add	x22,	sp,	x22
    mov	x7,	x8
    mov	x28,	x0
    add	x7,	sp,	x7
    add	x28,	sp,	x28
    add	x22,	x22,	#1152
    add	x7,	x7,	#1152
    add	x28,	x28,	#1152
    ldr	w1,	[x28]

    ldr	w4,	[x2]

    ldr	w26,	[x7]

    add	w10,	w4,	w1
    cmp	w10,	w26
    csel	w11,	w10,	w26,	gt
    cmp	w10,	w26
    add	w4,	w18,	#1
    csel	w13,	w10,	w11,	eq
    str	w13,	[x22]

    lsl	w16,	w4,	#2
    sub	w17,	w4,	#2
    lsl	w23,	w4,	#2
    sub	w27,	w4,	#1
    mov	x9,	x16
    lsl	w19,	w17,	#2
    add	x22,	x20,	x23
    lsl	w0,	w27,	#2
    add	x9,	sp,	x9
    mov	x18,	x19
    mov	x28,	x0
    add	x18,	sp,	x18
    add	x28,	sp,	x28
    add	x9,	x9,	#1152
    add	x18,	x18,	#1152
    add	x28,	x28,	#1152
    ldr	w21,	[x18]

    ldr	w25,	[x22]

    add	w6,	w25,	w21
    ldr	w17,	[x28]

    cmp	w6,	w17
    csel	w3,	w6,	w17,	gt
    cmp	w6,	w17
    add	w16,	w4,	#1
    csel	w5,	w6,	w3,	eq
    str	w5,	[x9]

    lsl	w8,	w16,	#2
    lsl	w14,	w16,	#2
    sub	w17,	w16,	#1
    sub	w9,	w16,	#2
    mov	x27,	x8
    add	x13,	x20,	x14
    add	x27,	sp,	x27
    lsl	w19,	w17,	#2
    lsl	w11,	w9,	#2
    mov	x10,	x11
    add	x27,	x27,	#1152
    add	x10,	sp,	x10
    add	x10,	x10,	#1152
    ldr	w18,	[x10]

    ldr	w15,	[x13]

    add	w1,	w15,	w18
    mov	x18,	x19
    add	x18,	sp,	x18
    add	x18,	x18,	#1152
    ldr	w9,	[x18]

    cmp	w1,	w9
    csel	w23,	w1,	w9,	gt
    cmp	w1,	w9
    add	w18,	w16,	#1
    csel	w26,	w1,	w23,	eq
    str	w26,	[x27]

    lsl	w0,	w18,	#2
    lsl	w6,	w18,	#2
    sub	w9,	w18,	#1
    sub	w1,	w18,	#2
    mov	x4,	x0
    add	x5,	x20,	x6
    add	x4,	sp,	x4
    lsl	w11,	w9,	#2
    lsl	w3,	w1,	#2
    mov	x10,	x11
    mov	x2,	x3
    add	x4,	x4,	#1152
    add	x10,	sp,	x10
    add	x2,	sp,	x2
    add	x10,	x10,	#1152
    add	x2,	x2,	#1152
    ldr	w13,	[x2]

    ldr	w7,	[x5]

    ldr	w2,	[x10]

    add	w27,	w7,	w13
    cmp	w27,	w2
    csel	w14,	w27,	w2,	gt
    cmp	w27,	w2
    csel	w16,	w27,	w14,	eq
    add	w14,	w18,	#1
    str	w16,	[x4]

    sub	w21,	w14,	#2
    lsl	w27,	w14,	#2
    sub	w1,	w14,	#1
    lsl	w19,	w14,	#2
    add	x26,	x20,	x27
    mov	x12,	x19
    lsl	w23,	w21,	#2
    add	x12,	sp,	x12
    lsl	w3,	w1,	#2
    mov	x22,	x23
    mov	x2,	x3
    add	x22,	sp,	x22
    add	x12,	x12,	#1152
    add	x2,	sp,	x2
    add	x22,	x22,	#1152
    add	x2,	x2,	#1152
    ldr	w5,	[x22]

    ldr	w28,	[x26]

    ldr	w23,	[x2]

    add	w22,	w28,	w5
    cmp	w22,	w23
    csel	w6,	w22,	w23,	gt
    cmp	w22,	w23
    add	w19,	w14,	#1
    csel	w8,	w22,	w6,	eq
    str	w8,	[x12]

    sub	w21,	w19,	#1
    lsl	w17,	w19,	#2
    lsl	w11,	w19,	#2
    sub	w12,	w19,	#2
    add	x16,	x20,	x17
    mov	x11,	x11
    lsl	w23,	w21,	#2
    add	x11,	sp,	x11
    lsl	w14,	w12,	#2
    mov	x22,	x23
    mov	x13,	x14
    add	x22,	sp,	x22
    add	x11,	x11,	#1152
    add	x13,	sp,	x13
    add	x22,	x22,	#1152
    add	x13,	x13,	#1152
    ldr	w0,	[x13]

    ldr	w18,	[x16]

    ldr	w14,	[x22]

    add	w15,	w18,	w0
    cmp	w15,	w14
    csel	w27,	w15,	w14,	gt
    cmp	w15,	w14
    csel	w0,	w15,	w27,	eq
    add	w1,	w19,	#1
    str	w0,	[x11]

    sub	w12,	w1,	#1
    lsl	w9,	w1,	#2
    sub	w4,	w1,	#2
    lsl	w3,	w1,	#2
    add	x8,	x20,	x9
    mov	x21,	x3
    lsl	w14,	w12,	#2
    add	x21,	sp,	x21
    lsl	w6,	w4,	#2
    mov	x13,	x14
    mov	x5,	x6
    add	x13,	sp,	x13
    add	x21,	x21,	#1152
    add	x5,	sp,	x5
    add	x13,	x13,	#1152
    add	x5,	x5,	#1152
    ldr	w23,	[x5]

    ldr	w10,	[x8]

    ldr	w7,	[x13]

    add	w15,	w10,	w23
    cmp	w15,	w7
    csel	w17,	w15,	w7,	gt
    cmp	w15,	w7
    add	w7,	w1,	#1
    csel	w19,	w15,	w17,	eq
    str	w19,	[x21]

    b	main_36

main_162:
    lsl	w15,	w7,	#2
    sub	w16,	w7,	#2
    lsl	w22,	w7,	#2
    sub	w26,	w7,	#1
    mov	x0,	x15
    lsl	w18,	w16,	#2
    add	x21,	x20,	x22
    lsl	w28,	w26,	#2
    add	x0,	sp,	x0
    mov	x17,	x18
    mov	x27,	x28
    add	x17,	sp,	x17
    add	x27,	sp,	x27
    add	x0,	x0,	#1152
    add	x17,	x17,	#1152
    add	x27,	x27,	#1152
    ldr	w13,	[x17]

    ldr	w23,	[x21]

    add	w11,	w23,	w13
    ldr	w13,	[x27]

    cmp	w11,	w13
    csel	w2,	w11,	w13,	gt
    cmp	w11,	w13
    add	w7,	w7,	#1
    csel	w4,	w11,	w2,	eq
    str	w4,	[x0]

    cmp	w7,	#15
    blt	main_162

main_180:
    add	x21,	sp,	#1208
    ldr	w0,	[x21]

    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w2,	#1024
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    movz	w28,	#1

main_185:
    sub	w0,	w28,	#1
    lsl	w1,	w28,	#6
    mov	x13,	x1
    add	x13,	sp,	x13
    lsl	w17,	w0,	#6
    lsl	w12,	w0,	#2
    mov	x21,	x17
    add	x13,	x13,	#16
    add	x11,	x20,	x12
    add	x21,	sp,	x21
    ldr	w11,	[x11]

    add	x21,	x21,	#16
    cmp	w11,	#3
    bne	main_198

main_193:
    add	x12,	x13,	#4
    ldr	w22,	[x21]

    add	w23,	w22,	#1
    str	w23,	[x12]

    b	main_208

main_198:
    add	x4,	x13,	#4
    add	x26,	x21,	#4
    ldr	w23,	[x26]

    ldr	w22,	[x13]

    cmp	w23,	w22
    csel	w3,	w23,	w22,	gt
    cmp	w23,	w22
    csel	w5,	w23,	w3,	eq
    str	w5,	[x4]


main_208:
    cmp	w11,	#9
    bne	main_215

main_210:
    add	x27,	x13,	#8
    add	x8,	x21,	#4
    ldr	w9,	[x8]

    add	w10,	w9,	#1
    str	w10,	[x27]

    b	main_225

main_215:
    add	x0,	x13,	#8
    add	x14,	x21,	#8
    add	x16,	x13,	#4
    ldr	w5,	[x14]

    ldr	w9,	[x16]

    cmp	w5,	w9
    csel	w19,	w5,	w9,	gt
    cmp	w5,	w9
    csel	w23,	w5,	w19,	eq
    str	w23,	[x0]


main_225:
    cmp	w11,	#7
    bne	main_232

main_227:
    add	x17,	x13,	#12
    add	x27,	x21,	#8
    ldr	w0,	[x27]

    add	w1,	w0,	#1
    str	w1,	[x17]

    b	main_242

main_232:
    add	x23,	x13,	#12
    add	x3,	x21,	#12
    add	x5,	x13,	#8
    ldr	w27,	[x3]

    ldr	w1,	[x5]

    cmp	w27,	w1
    csel	w8,	w27,	w1,	gt
    cmp	w27,	w1
    csel	w10,	w27,	w8,	eq
    str	w10,	[x23]


main_242:
    cmp	w11,	#1
    bne	main_249

main_244:
    add	x7,	x13,	#16
    add	x15,	x21,	#12
    ldr	w16,	[x15]

    add	w17,	w16,	#1
    str	w17,	[x7]

    b	main_259

main_249:
    add	x14,	x13,	#16
    add	x19,	x21,	#16
    add	x23,	x13,	#12
    ldr	w15,	[x19]

    ldr	w17,	[x23]

    cmp	w15,	w17
    csel	w27,	w15,	w17,	gt
    cmp	w15,	w17
    csel	w1,	w15,	w27,	eq
    str	w1,	[x14]


main_259:
    cmp	w11,	#4
    bne	main_266

main_261:
    add	x1,	x13,	#20
    add	x4,	x21,	#16
    ldr	w5,	[x4]

    add	w6,	w5,	#1
    str	w6,	[x1]

    b	main_276

main_266:
    add	x5,	x13,	#20
    add	x8,	x21,	#20
    add	x10,	x13,	#16
    ldr	w8,	[x8]

    ldr	w7,	[x10]

    cmp	w8,	w7
    csel	w15,	w8,	w7,	gt
    cmp	w8,	w7
    csel	w17,	w8,	w15,	eq
    str	w17,	[x5]


main_276:
    cmp	w11,	#2
    bne	main_283

main_278:
    add	x17,	x13,	#24
    add	x22,	x21,	#20
    ldr	w23,	[x22]

    add	w25,	w23,	#1
    str	w25,	[x17]

    b	main_293

main_283:
    add	x3,	x13,	#24
    add	x27,	x21,	#24
    add	x1,	x13,	#20
    ldr	w2,	[x27]

    ldr	w27,	[x1]

    cmp	w2,	w27
    csel	w4,	w2,	w27,	gt
    cmp	w2,	w27
    csel	w6,	w2,	w4,	eq
    str	w6,	[x3]


main_293:
    cmp	w11,	#4
    bne	main_300

main_295:
    add	x14,	x13,	#28
    add	x9,	x21,	#24
    ldr	w10,	[x9]

    movz	w9,	#8
    add	w12,	w10,	#1
    str	w12,	[x14]

    b	main_311

main_300:
    add	x23,	x13,	#28
    add	x15,	x21,	#28
    add	x17,	x13,	#24
    ldr	w19,	[x15]

    ldr	w15,	[x17]

    cmp	w19,	w15
    csel	w22,	w19,	w15,	gt
    cmp	w19,	w15
    movz	w9,	#8
    csel	w25,	w19,	w22,	eq
    str	w25,	[x23]


main_311:
    sub	w15,	w9,	#1
    lsl	w26,	w15,	#2
    add	x25,	x24,	x26
    ldr	w27,	[x25]

    cmp	w11,	w27
    bne	main_325

main_317:
    lsl	w2,	w9,	#2
    lsl	w4,	w15,	#2
    add	x18,	x13,	x2
    add	x3,	x21,	x4
    ldr	w5,	[x3]

    add	w6,	w5,	#1
    str	w6,	[x18]

    b	main_322

main_325:
    lsl	w8,	w9,	#2
    lsl	w12,	w9,	#2
    lsl	w16,	w15,	#2
    add	x14,	x13,	x8
    add	x10,	x21,	x12
    add	x15,	x13,	x16
    ldr	w4,	[x10]

    ldr	w0,	[x15]

    cmp	w4,	w0
    csel	w19,	w4,	w0,	gt
    cmp	w4,	w0
    csel	w23,	w4,	w19,	eq
    str	w23,	[x14]


main_322:
    add	w9,	w9,	#1
    cmp	w9,	#13
    ble	main_311

main_335:
    add	w28,	w28,	#1
    cmp	w28,	#15
    ble	main_185

main_338:
    add	x26,	sp,	#976
    add	x27,	x26,	#52
    ldr	w0,	[x27]

    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #1216
    ret


