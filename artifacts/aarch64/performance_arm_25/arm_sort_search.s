.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#40016
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#40000
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    movz	w0,	#88
    bl	_sysy_starttime
    movz	w10,	#0
    movz	w3,	#0

main_2:
    movz	w1,	#10000
    cmp	w3,	w1
    bge	main_39

main_6:
    lsl	w8,	w3,	#2
    movz	w7,	#10000
    movz	w25,	#38831
    movz	w5,	#10000
    movz	w4,	#10000
    movz	w2,	#10000
    movz	w26,	#10000
    mov	x19,	x8
    movk	w25,	#152,	lsl #16
    movz	w8,	#10000
    add	x19,	sp,	x19
    add	w23,	w10,	w25
    sdiv	w28,	w10,	w8
    movz	w8,	#10000
    msub	w9,	w28,	w7,	w10

    add	x19,	x19,	#16
    movz	w7,	#10000
    add	w28,	w3,	#1
    sdiv	w0,	w23,	w8
    movz	w3,	#10000
    str	w9,	[x19]

    lsl	w18,	w28,	#2
    add	w10,	w28,	#1
    msub	w19,	w0,	w7,	w23

    mov	x6,	x18
    movz	w28,	#10000
    add	w0,	w23,	w25
    add	x6,	sp,	x6
    lsl	w23,	w10,	#2
    mov	x8,	x23
    add	w9,	w0,	w25
    add	x8,	sp,	x8
    add	x6,	x6,	#16
    sdiv	w20,	w9,	w4
    add	w14,	w9,	w25
    add	x8,	x8,	#16
    str	w19,	[x6]

    msub	w1,	w20,	w3,	w9

    movz	w6,	#10000
    sdiv	w16,	w14,	w2
    sdiv	w24,	w0,	w6
    msub	w24,	w24,	w5,	w0

    str	w24,	[x8]

    add	w8,	w10,	#1
    add	w13,	w8,	#1
    lsl	w0,	w8,	#2
    mov	x18,	x0
    movz	w0,	#10000
    add	x18,	sp,	x18
    add	w27,	w13,	#1
    lsl	w5,	w13,	#2
    mov	x24,	x5
    add	x18,	x18,	#16
    add	x24,	sp,	x24
    lsl	w10,	w27,	#2
    mov	x23,	x10
    str	w1,	[x18]

    add	x24,	x24,	#16
    add	x23,	sp,	x23
    add	w18,	w14,	w25
    movz	w1,	#10000
    add	x23,	x23,	#16
    sdiv	w11,	w18,	w0
    msub	w6,	w16,	w1,	w14

    msub	w11,	w11,	w28,	w18

    str	w6,	[x24]

    add	w28,	w18,	w25
    movz	w24,	#10000
    str	w11,	[x23]

    add	w23,	w27,	#1
    add	w11,	w28,	w25
    movz	w27,	#10000
    lsl	w15,	w23,	#2
    add	w4,	w23,	#1
    add	w10,	w11,	w25
    sdiv	w3,	w11,	w24
    sdiv	w7,	w28,	w27
    mov	x6,	x15
    movz	w23,	#10000
    lsl	w20,	w4,	#2
    msub	w16,	w7,	w26,	w28

    add	x6,	sp,	x6
    msub	w21,	w3,	w23,	w11

    mov	x12,	x20
    add	w3,	w4,	#1
    add	x12,	sp,	x12
    add	x6,	x6,	#16
    add	x12,	x12,	#16
    str	w16,	[x6]

    str	w21,	[x12]

    b	main_2

main_39:
    add	x24,	sp,	#16
    movz	w5,	#0

main_42:
    movz	w12,	#0

main_45:
    lsl	w9,	w12,	#2
    add	w13,	w12,	#1
    add	x14,	x24,	x9
    lsl	w27,	w13,	#2
    ldr	w23,	[x14]

    add	x19,	x24,	x27
    ldr	w28,	[x19]

    cmp	w23,	w28
    ble	main_55

main_53:
    str	w28,	[x14]

    str	w23,	[x19]


main_55:
    ldr	w21,	[x19]

    add	w23,	w13,	#1
    lsl	w4,	w23,	#2
    add	x2,	x24,	x4
    ldr	w6,	[x2]

    cmp	w21,	w6
    ble	main_63

main_61:
    str	w6,	[x19]

    str	w21,	[x2]


main_63:
    ldr	w0,	[x2]

    add	w1,	w23,	#1
    lsl	w11,	w1,	#2
    add	x9,	x24,	x11
    ldr	w12,	[x9]

    cmp	w0,	w12
    ble	main_71

main_69:
    str	w12,	[x2]

    str	w0,	[x9]


main_71:
    ldr	w7,	[x9]

    add	w8,	w1,	#1
    lsl	w17,	w8,	#2
    add	x14,	x24,	x17
    ldr	w18,	[x14]

    cmp	w7,	w18
    ble	main_79

main_77:
    str	w18,	[x9]

    str	w7,	[x14]


main_79:
    ldr	w13,	[x14]

    add	w21,	w8,	#1
    lsl	w23,	w21,	#2
    add	x26,	x24,	x23
    ldr	w25,	[x26]

    cmp	w13,	w25
    ble	main_87

main_85:
    str	w25,	[x14]

    str	w13,	[x26]


main_87:
    ldr	w23,	[x26]

    add	w4,	w21,	#1
    lsl	w1,	w4,	#2
    add	x6,	x24,	x1
    ldr	w2,	[x6]

    cmp	w23,	w2
    ble	main_95

main_93:
    str	w2,	[x26]

    str	w23,	[x6]


main_95:
    ldr	w1,	[x6]

    add	w11,	w4,	#1
    lsl	w8,	w11,	#2
    add	x12,	x24,	x8
    ldr	w9,	[x12]

    cmp	w1,	w9
    ble	main_103

main_101:
    str	w9,	[x6]

    str	w1,	[x12]


main_103:
    ldr	w8,	[x12]

    add	w17,	w11,	#1
    lsl	w14,	w17,	#2
    add	x26,	x24,	x14
    ldr	w15,	[x26]

    cmp	w8,	w15
    ble	main_111

main_109:
    str	w15,	[x12]

    str	w8,	[x26]


main_111:
    ldr	w15,	[x26]

    add	w25,	w17,	#1
    lsl	w20,	w25,	#2
    add	x3,	x24,	x20
    ldr	w21,	[x3]

    cmp	w15,	w21
    ble	main_119

main_117:
    str	w21,	[x26]

    str	w15,	[x3]


main_119:
    ldr	w21,	[x3]

    add	w23,	w25,	#1
    lsl	w27,	w23,	#2
    add	x11,	x24,	x27
    ldr	w28,	[x11]

    cmp	w21,	w28
    ble	main_127

main_125:
    str	w28,	[x3]

    str	w21,	[x11]


main_127:
    ldr	w2,	[x11]

    add	w3,	w23,	#1
    lsl	w4,	w3,	#2
    add	x18,	x24,	x4
    ldr	w6,	[x18]

    cmp	w2,	w6
    ble	main_135

main_133:
    str	w6,	[x11]

    str	w2,	[x18]


main_135:
    ldr	w9,	[x18]

    add	w10,	w3,	#1
    lsl	w11,	w10,	#2
    add	x26,	x24,	x11
    ldr	w12,	[x26]

    cmp	w9,	w12
    ble	main_143

main_141:
    str	w12,	[x18]

    str	w9,	[x26]


main_143:
    ldr	w16,	[x26]

    add	w19,	w10,	#1
    lsl	w17,	w19,	#2
    add	x3,	x24,	x17
    ldr	w18,	[x3]

    cmp	w16,	w18
    ble	main_151

main_149:
    str	w18,	[x26]

    str	w16,	[x3]


main_151:
    ldr	w22,	[x3]

    add	w27,	w19,	#1
    lsl	w23,	w27,	#2
    add	x14,	x24,	x23
    ldr	w25,	[x14]

    cmp	w22,	w25
    ble	main_159

main_157:
    str	w25,	[x3]

    str	w22,	[x14]


main_159:
    ldr	w6,	[x14]

    add	w7,	w27,	#1
    lsl	w1,	w7,	#2
    add	x22,	x24,	x1
    ldr	w2,	[x22]

    cmp	w6,	w2
    ble	main_167

main_165:
    str	w2,	[x14]

    str	w6,	[x22]


main_167:
    ldr	w16,	[x22]

    add	w12,	w7,	#1
    lsl	w27,	w12,	#2
    add	x27,	x24,	x27
    ldr	w9,	[x27]

    cmp	w16,	w9
    ble	main_175

main_173:
    str	w9,	[x22]

    str	w16,	[x27]


main_175:
    movz	w21,	#9984
    cmp	w12,	w21
    blt	main_45

main_179:
    ldr	w8,	[x27]

    add	w10,	w12,	#1
    lsl	w6,	w10,	#2
    add	x25,	x24,	x6
    ldr	w7,	[x25]

    cmp	w8,	w7
    ble	main_189

main_187:
    str	w7,	[x27]

    str	w8,	[x25]


main_189:
    ldr	w28,	[x25]

    add	w0,	w10,	#1
    lsl	w21,	w0,	#2
    add	x17,	x24,	x21
    ldr	w22,	[x17]

    cmp	w28,	w22
    ble	main_197

main_195:
    str	w22,	[x25]

    str	w28,	[x17]


main_197:
    ldr	w7,	[x17]

    add	w8,	w0,	#1
    lsl	w28,	w8,	#2
    add	x27,	x24,	x28
    ldr	w0,	[x27]

    cmp	w7,	w0
    ble	main_205

main_203:
    str	w0,	[x17]

    str	w7,	[x27]


main_205:
    ldr	w15,	[x27]

    add	w16,	w8,	#1
    lsl	w6,	w16,	#2
    add	x4,	x24,	x6
    ldr	w7,	[x4]

    cmp	w15,	w7
    ble	main_213

main_211:
    str	w7,	[x27]

    str	w15,	[x4]


main_213:
    ldr	w21,	[x4]

    add	w23,	w16,	#1
    lsl	w12,	w23,	#2
    add	x14,	x24,	x12
    ldr	w13,	[x14]

    cmp	w21,	w13
    ble	main_221

main_219:
    str	w13,	[x4]

    str	w21,	[x14]


main_221:
    ldr	w0,	[x14]

    add	w1,	w23,	#1
    lsl	w18,	w1,	#2
    add	x21,	x24,	x18
    ldr	w19,	[x21]

    cmp	w0,	w19
    ble	main_229

main_227:
    str	w19,	[x14]

    str	w0,	[x21]


main_229:
    ldr	w8,	[x21]

    add	w9,	w1,	#1
    lsl	w25,	w9,	#2
    add	x1,	x24,	x25
    ldr	w26,	[x1]

    cmp	w8,	w26
    ble	main_237

main_235:
    str	w26,	[x21]

    str	w8,	[x1]


main_237:
    ldr	w15,	[x1]

    add	w12,	w9,	#1
    lsl	w23,	w12,	#2
    add	x27,	x24,	x23
    ldr	w8,	[x27]

    cmp	w15,	w8
    ble	main_245

main_243:
    str	w8,	[x1]

    str	w15,	[x27]


main_245:
    movz	w2,	#9992
    cmp	w12,	w2
    blt	main_179

main_249:
    ldr	w16,	[x27]

    add	w12,	w12,	#1
    lsl	w15,	w12,	#2
    add	x7,	x24,	x15
    ldr	w1,	[x7]

    cmp	w16,	w1
    ble	main_259

main_257:
    str	w1,	[x27]

    str	w16,	[x7]


main_259:
    movz	w4,	#9999
    cmp	w12,	w4
    blt	main_248

main_261:
    add	w5,	w5,	#1
    movz	w6,	#9999
    cmp	w5,	w6
    blt	main_42

main_264:
    movz	w7,	#0
    movz	w2,	#9999

main_265:
    cmp	w7,	w2
    bgt	main_284

main_269:
    add	w9,	w2,	w7
    asr	w15,	w9,	#31
    lsr	w16,	w15,	#31
    add	w17,	w9,	w16
    asr	w22,	w17,	#1
    lsl	w27,	w22,	#2
    add	x26,	x24,	x27
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
    sub	w2,	w22,	#1
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
    
    movz	fp,	#40016
    add	sp, sp, fp
    ret


main_248:
    mov	x27,	x7
    b	main_249

