.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#6800
    movk	fp,	#6,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#6784
    movz	w1,	#0
    add	x0,	sp,	#16
    movk	w2,	#6,	lsl #16
    bl	memset
    movz	w0,	#88
    bl	_sysy_starttime
    movz	w4,	#0
    movz	w19,	#0

main_2:
    movz	w8,	#34464
    movk	w8,	#1,	lsl #16
    cmp	w19,	w8
    bge	main_39

main_6:
    lsl	w22,	w19,	#2
    sdiv	w28,	w4,	w8
    add	w3,	w19,	#1
    movz	w25,	#38831
    mov	x0,	x22
    msub	w23,	w28,	w8,	w4

    movk	w25,	#152,	lsl #16
    add	x0,	sp,	x0
    add	w7,	w3,	#1
    lsl	w13,	w3,	#2
    add	w4,	w4,	w25
    mov	x2,	x13
    add	x0,	x0,	#16
    add	x2,	sp,	x2
    lsl	w18,	w7,	#2
    add	w13,	w7,	#1
    add	w9,	w4,	w25
    mov	x6,	x18
    str	w23,	[x0]

    add	x2,	x2,	#16
    add	w21,	w13,	#1
    add	x6,	sp,	x6
    sdiv	w24,	w9,	w8
    lsl	w23,	w13,	#2
    sdiv	w0,	w4,	w8
    msub	w19,	w24,	w8,	w9

    add	w28,	w21,	#1
    add	x6,	x6,	#16
    mov	x12,	x23
    msub	w14,	w0,	w8,	w4

    add	x12,	sp,	x12
    lsl	w0,	w21,	#2
    lsl	w5,	w28,	#2
    str	w14,	[x2]

    add	w14,	w9,	w25
    str	w19,	[x6]

    add	x12,	x12,	#16
    mov	x19,	x0
    add	x19,	sp,	x19
    add	w22,	w14,	w25
    sdiv	w20,	w14,	w8
    msub	w24,	w20,	w8,	w14

    add	x19,	x19,	#16
    str	w24,	[x12]

    sdiv	w16,	w22,	w8
    mov	x24,	x5
    msub	w1,	w16,	w8,	w22

    add	w5,	w28,	#1
    add	x24,	sp,	x24
    str	w1,	[x19]

    add	w19,	w22,	w25
    lsl	w11,	w5,	#2
    add	x24,	x24,	#16
    mov	x1,	x11
    add	w26,	w19,	w25
    sdiv	w12,	w19,	w8
    add	x1,	sp,	x1
    msub	w6,	w12,	w8,	w19

    str	w6,	[x24]

    add	w13,	w26,	w25
    sdiv	w7,	w26,	w8
    add	x1,	x1,	#16
    msub	w12,	w7,	w8,	w26

    add	w4,	w13,	w25
    sdiv	w3,	w13,	w8
    str	w12,	[x1]

    msub	w21,	w3,	w8,	w13

    add	w12,	w5,	#1
    add	w19,	w12,	#1
    lsl	w16,	w12,	#2
    mov	x7,	x16
    add	x7,	sp,	x7
    add	x7,	x7,	#16
    str	w21,	[x7]

    b	main_2

main_39:
    add	x14,	sp,	#16
    movz	w9,	#0

main_42:
    movz	w12,	#0

main_45:
    lsl	w8,	w12,	#2
    add	w13,	w12,	#1
    add	x15,	x14,	x8
    lsl	w27,	w13,	#2
    ldr	w24,	[x15]

    add	x20,	x14,	x27
    ldr	w28,	[x20]

    cmp	w24,	w28
    ble	main_55

main_53:
    str	w28,	[x15]

    str	w24,	[x20]


main_55:
    ldr	w22,	[x20]

    add	w24,	w13,	#1
    lsl	w4,	w24,	#2
    add	x2,	x14,	x4
    ldr	w5,	[x2]

    cmp	w22,	w5
    ble	main_63

main_61:
    str	w5,	[x20]

    str	w22,	[x2]


main_63:
    ldr	w0,	[x2]

    add	w1,	w24,	#1
    lsl	w11,	w1,	#2
    add	x8,	x14,	x11
    ldr	w12,	[x8]

    cmp	w0,	w12
    ble	main_71

main_69:
    str	w12,	[x2]

    str	w0,	[x8]


main_71:
    ldr	w6,	[x8]

    add	w7,	w1,	#1
    lsl	w18,	w7,	#2
    add	x15,	x14,	x18
    ldr	w19,	[x15]

    cmp	w6,	w19
    ble	main_79

main_77:
    str	w19,	[x8]

    str	w6,	[x15]


main_79:
    ldr	w13,	[x15]

    add	w22,	w7,	#1
    lsl	w24,	w22,	#2
    add	x26,	x14,	x24
    ldr	w25,	[x26]

    cmp	w13,	w25
    ble	main_87

main_85:
    str	w25,	[x15]

    str	w13,	[x26]


main_87:
    ldr	w24,	[x26]

    add	w4,	w22,	#1
    lsl	w1,	w4,	#2
    add	x5,	x14,	x1
    ldr	w2,	[x5]

    cmp	w24,	w2
    ble	main_95

main_93:
    str	w2,	[x26]

    str	w24,	[x5]


main_95:
    ldr	w1,	[x5]

    add	w11,	w4,	#1
    lsl	w7,	w11,	#2
    add	x12,	x14,	x7
    ldr	w8,	[x12]

    cmp	w1,	w8
    ble	main_103

main_101:
    str	w8,	[x5]

    str	w1,	[x12]


main_103:
    ldr	w7,	[x12]

    add	w18,	w11,	#1
    lsl	w15,	w18,	#2
    add	x26,	x14,	x15
    ldr	w16,	[x26]

    cmp	w7,	w16
    ble	main_111

main_109:
    str	w16,	[x12]

    str	w7,	[x26]


main_111:
    ldr	w16,	[x26]

    add	w25,	w18,	#1
    lsl	w21,	w25,	#2
    add	x3,	x14,	x21
    ldr	w22,	[x3]

    cmp	w16,	w22
    ble	main_119

main_117:
    str	w22,	[x26]

    str	w16,	[x3]


main_119:
    ldr	w22,	[x3]

    add	w24,	w25,	#1
    lsl	w27,	w24,	#2
    add	x11,	x14,	x27
    ldr	w28,	[x11]

    cmp	w22,	w28
    ble	main_127

main_125:
    str	w28,	[x3]

    str	w22,	[x11]


main_127:
    ldr	w2,	[x11]

    add	w3,	w24,	#1
    lsl	w4,	w3,	#2
    add	x19,	x14,	x4
    ldr	w5,	[x19]

    cmp	w2,	w5
    ble	main_135

main_133:
    str	w5,	[x11]

    str	w2,	[x19]


main_135:
    ldr	w8,	[x19]

    add	w10,	w3,	#1
    lsl	w11,	w10,	#2
    add	x26,	x14,	x11
    ldr	w12,	[x26]

    cmp	w8,	w12
    ble	main_143

main_141:
    str	w12,	[x19]

    str	w8,	[x26]


main_143:
    ldr	w17,	[x26]

    add	w20,	w10,	#1
    lsl	w18,	w20,	#2
    add	x3,	x14,	x18
    ldr	w19,	[x3]

    cmp	w17,	w19
    ble	main_151

main_149:
    str	w19,	[x26]

    str	w17,	[x3]


main_151:
    ldr	w23,	[x3]

    add	w27,	w20,	#1
    lsl	w24,	w27,	#2
    add	x15,	x14,	x24
    ldr	w25,	[x15]

    cmp	w23,	w25
    ble	main_159

main_157:
    str	w25,	[x3]

    str	w23,	[x15]


main_159:
    ldr	w5,	[x15]

    add	w6,	w27,	#1
    lsl	w1,	w6,	#2
    add	x23,	x14,	x1
    ldr	w2,	[x23]

    cmp	w5,	w2
    ble	main_167

main_165:
    str	w2,	[x15]

    str	w5,	[x23]


main_167:
    ldr	w17,	[x23]

    add	w12,	w6,	#1
    lsl	w27,	w12,	#2
    add	x27,	x14,	x27
    ldr	w8,	[x27]

    cmp	w17,	w8
    ble	main_175

main_173:
    str	w8,	[x23]

    str	w17,	[x27]


main_175:
    movz	w21,	#34448
    movk	w21,	#1,	lsl #16
    cmp	w12,	w21
    blt	main_45

main_179:
    ldr	w7,	[x27]

    add	w10,	w12,	#1
    lsl	w5,	w10,	#2
    add	x25,	x14,	x5
    ldr	w6,	[x25]

    cmp	w7,	w6
    ble	main_189

main_187:
    str	w6,	[x27]

    str	w7,	[x25]


main_189:
    ldr	w28,	[x25]

    add	w0,	w10,	#1
    lsl	w22,	w0,	#2
    add	x18,	x14,	x22
    ldr	w23,	[x18]

    cmp	w28,	w23
    ble	main_197

main_195:
    str	w23,	[x25]

    str	w28,	[x18]


main_197:
    ldr	w6,	[x18]

    add	w7,	w0,	#1
    lsl	w28,	w7,	#2
    add	x27,	x14,	x28
    ldr	w0,	[x27]

    cmp	w6,	w0
    ble	main_205

main_203:
    str	w0,	[x18]

    str	w6,	[x27]


main_205:
    ldr	w16,	[x27]

    add	w17,	w7,	#1
    lsl	w5,	w17,	#2
    add	x4,	x14,	x5
    ldr	w6,	[x4]

    cmp	w16,	w6
    ble	main_213

main_211:
    str	w6,	[x27]

    str	w16,	[x4]


main_213:
    ldr	w22,	[x4]

    add	w24,	w17,	#1
    lsl	w12,	w24,	#2
    add	x15,	x14,	x12
    ldr	w13,	[x15]

    cmp	w22,	w13
    ble	main_221

main_219:
    str	w13,	[x4]

    str	w22,	[x15]


main_221:
    ldr	w0,	[x15]

    add	w1,	w24,	#1
    lsl	w19,	w1,	#2
    add	x22,	x14,	x19
    ldr	w20,	[x22]

    cmp	w0,	w20
    ble	main_229

main_227:
    str	w20,	[x15]

    str	w0,	[x22]


main_229:
    ldr	w7,	[x22]

    add	w8,	w1,	#1
    lsl	w25,	w8,	#2
    add	x1,	x14,	x25
    ldr	w26,	[x1]

    cmp	w7,	w26
    ble	main_237

main_235:
    str	w26,	[x22]

    str	w7,	[x1]


main_237:
    ldr	w16,	[x1]

    add	w12,	w8,	#1
    lsl	w24,	w12,	#2
    add	x27,	x14,	x24
    ldr	w7,	[x27]

    cmp	w16,	w7
    ble	main_245

main_243:
    str	w7,	[x1]

    str	w16,	[x27]


main_245:
    movz	w2,	#34456
    movk	w2,	#1,	lsl #16
    cmp	w12,	w2
    blt	main_179

main_249:
    ldr	w17,	[x27]

    add	w12,	w12,	#1
    lsl	w16,	w12,	#2
    add	x7,	x14,	x16
    ldr	w1,	[x7]

    cmp	w17,	w1
    ble	main_259

main_257:
    str	w1,	[x27]

    str	w17,	[x7]


main_259:
    movz	w16,	#34463
    movk	w16,	#1,	lsl #16
    cmp	w12,	w16
    blt	main_248

main_261:
    add	w9,	w9,	#1
    cmp	w9,	w16
    blt	main_42

main_264:
    movz	w7,	#0

main_265:
    cmp	w7,	w16
    bgt	main_284

main_269:
    add	w8,	w16,	w7
    asr	w15,	w8,	#31
    lsr	w17,	w15,	#31
    add	w18,	w8,	w17
    asr	w22,	w18,	#1
    lsl	w27,	w22,	#2
    add	x26,	x14,	x27
    ldr	w28,	[x26]

    cmp	w28,	#303
    beq	main_286

main_275:
    cmp	w28,	#303
    bge	main_279

main_277:
    add	w7,	w22,	#1
    b	main_265

main_279:
    sub	w16,	w22,	#1
    b	main_265

main_284:
    movz	w22,	#65535
    movk	w22,	#65535,	lsl #16

main_286:
    movz	w0,	#303
    bl	putint
    movz	w0,	#32
    bl	putch
    mov	w0,	w22
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#15
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#5
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#50
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#2
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#0
    bl	putint
    movz	w0,	#32
    bl	putch
    movz	w0,	#92
    bl	_sysy_stoptime
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#6800
    movk	fp,	#6,	lsl #16
    add	sp, sp, fp
    ret


main_248:
    mov	x27,	x7
    b	main_249

