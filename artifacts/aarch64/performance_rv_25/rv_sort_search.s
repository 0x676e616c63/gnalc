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
    movz	w5,	#0
    movz	w19,	#0

main_2:
    movz	w1,	#10000
    cmp	w19,	w1
    bge	main_39

main_6:
    lsl	w8,	w19,	#2
    movz	w0,	#10000
    movz	w28,	#10000
    add	w2,	w19,	#1
    add	w21,	w5,	#303
    movz	w26,	#10000
    movz	w25,	#10000
    movz	w24,	#10000
    movz	w23,	#10000
    movz	w22,	#10000
    movz	w20,	#10000
    mov	x17,	x8
    sdiv	w18,	w5,	w0
    movz	w19,	#10000
    lsl	w27,	w2,	#2
    add	w10,	w21,	#303
    add	x17,	sp,	x17
    msub	w9,	w18,	w28,	w5

    mov	x1,	x27
    sdiv	w15,	w10,	w25
    add	w5,	w10,	#303
    add	x17,	x17,	#16
    movz	w27,	#10000
    add	x1,	sp,	x1
    msub	w4,	w15,	w24,	w10

    sdiv	w12,	w5,	w23
    sdiv	w18,	w21,	w27
    str	w9,	[x17]

    movz	w15,	#10000
    add	x1,	x1,	#16
    add	w23,	w5,	#303
    msub	w28,	w18,	w26,	w21

    movz	w17,	#10000
    add	w9,	w2,	#1
    movz	w21,	#10000
    add	w24,	w23,	#303
    str	w28,	[x1]

    add	w16,	w9,	#1
    lsl	w3,	w9,	#2
    add	w26,	w24,	#303
    sdiv	w6,	w24,	w19
    msub	w9,	w12,	w22,	w5

    mov	x7,	x3
    lsl	w8,	w16,	#2
    add	w22,	w16,	#1
    sdiv	w3,	w26,	w17
    add	x7,	sp,	x7
    mov	x13,	x8
    movz	w16,	#10000
    add	w28,	w22,	#1
    add	x13,	sp,	x13
    add	x7,	x7,	#16
    add	x13,	x13,	#16
    str	w4,	[x7]

    add	w4,	w26,	#303
    str	w9,	[x13]

    sdiv	w9,	w23,	w21
    lsl	w13,	w22,	#2
    add	w5,	w4,	#303
    sdiv	w0,	w4,	w15
    msub	w14,	w9,	w20,	w23

    mov	x18,	x13
    add	x18,	sp,	x18
    add	x18,	x18,	#16
    str	w14,	[x18]

    movz	w14,	#10000
    lsl	w18,	w28,	#2
    mov	x20,	x18
    msub	w0,	w0,	w14,	w4

    movz	w18,	#10000
    add	x20,	sp,	x20
    msub	w19,	w6,	w18,	w24

    msub	w24,	w3,	w16,	w26

    add	w6,	w28,	#1
    add	x20,	x20,	#16
    add	w3,	w6,	#1
    lsl	w23,	w6,	#2
    str	w19,	[x20]

    mov	x1,	x23
    add	x1,	sp,	x1
    lsl	w28,	w3,	#2
    add	w19,	w3,	#1
    mov	x2,	x28
    add	x1,	x1,	#16
    add	x2,	sp,	x2
    str	w24,	[x1]

    add	x2,	x2,	#16
    str	w0,	[x2]

    b	main_2

main_39:
    add	x21,	sp,	#16
    movz	w5,	#0

main_42:
    movz	w12,	#0

main_45:
    lsl	w9,	w12,	#2
    add	w13,	w12,	#1
    add	x14,	x21,	x9
    lsl	w27,	w13,	#2
    ldr	w24,	[x14]

    add	x19,	x21,	x27
    ldr	w28,	[x19]

    cmp	w24,	w28
    ble	main_55

main_53:
    str	w28,	[x14]

    str	w24,	[x19]


main_55:
    ldr	w22,	[x19]

    add	w24,	w13,	#1
    lsl	w4,	w24,	#2
    add	x2,	x21,	x4
    ldr	w6,	[x2]

    cmp	w22,	w6
    ble	main_63

main_61:
    str	w6,	[x19]

    str	w22,	[x2]


main_63:
    ldr	w0,	[x2]

    add	w1,	w24,	#1
    lsl	w11,	w1,	#2
    add	x9,	x21,	x11
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
    add	x14,	x21,	x17
    ldr	w18,	[x14]

    cmp	w7,	w18
    ble	main_79

main_77:
    str	w18,	[x9]

    str	w7,	[x14]


main_79:
    ldr	w13,	[x14]

    add	w22,	w8,	#1
    lsl	w24,	w22,	#2
    add	x26,	x21,	x24
    ldr	w25,	[x26]

    cmp	w13,	w25
    ble	main_87

main_85:
    str	w25,	[x14]

    str	w13,	[x26]


main_87:
    ldr	w24,	[x26]

    add	w4,	w22,	#1
    lsl	w1,	w4,	#2
    add	x6,	x21,	x1
    ldr	w2,	[x6]

    cmp	w24,	w2
    ble	main_95

main_93:
    str	w2,	[x26]

    str	w24,	[x6]


main_95:
    ldr	w1,	[x6]

    add	w11,	w4,	#1
    lsl	w8,	w11,	#2
    add	x12,	x21,	x8
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
    add	x26,	x21,	x14
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
    add	x3,	x21,	x20
    ldr	w22,	[x3]

    cmp	w15,	w22
    ble	main_119

main_117:
    str	w22,	[x26]

    str	w15,	[x3]


main_119:
    ldr	w22,	[x3]

    add	w24,	w25,	#1
    lsl	w27,	w24,	#2
    add	x11,	x21,	x27
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
    add	x18,	x21,	x4
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
    add	x26,	x21,	x11
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
    add	x3,	x21,	x17
    ldr	w18,	[x3]

    cmp	w16,	w18
    ble	main_151

main_149:
    str	w18,	[x26]

    str	w16,	[x3]


main_151:
    ldr	w23,	[x3]

    add	w27,	w19,	#1
    lsl	w24,	w27,	#2
    add	x14,	x21,	x24
    ldr	w25,	[x14]

    cmp	w23,	w25
    ble	main_159

main_157:
    str	w25,	[x3]

    str	w23,	[x14]


main_159:
    ldr	w6,	[x14]

    add	w7,	w27,	#1
    lsl	w1,	w7,	#2
    add	x23,	x21,	x1
    ldr	w2,	[x23]

    cmp	w6,	w2
    ble	main_167

main_165:
    str	w2,	[x14]

    str	w6,	[x23]


main_167:
    ldr	w16,	[x23]

    add	w12,	w7,	#1
    lsl	w27,	w12,	#2
    add	x27,	x21,	x27
    ldr	w9,	[x27]

    cmp	w16,	w9
    ble	main_175

main_173:
    str	w9,	[x23]

    str	w16,	[x27]


main_175:
    movz	w13,	#9984
    cmp	w12,	w13
    blt	main_45

main_179:
    ldr	w8,	[x27]

    add	w10,	w12,	#1
    lsl	w6,	w10,	#2
    add	x25,	x21,	x6
    ldr	w7,	[x25]

    cmp	w8,	w7
    ble	main_189

main_187:
    str	w7,	[x27]

    str	w8,	[x25]


main_189:
    ldr	w28,	[x25]

    add	w0,	w10,	#1
    lsl	w22,	w0,	#2
    add	x17,	x21,	x22
    ldr	w23,	[x17]

    cmp	w28,	w23
    ble	main_197

main_195:
    str	w23,	[x25]

    str	w28,	[x17]


main_197:
    ldr	w7,	[x17]

    add	w8,	w0,	#1
    lsl	w28,	w8,	#2
    add	x27,	x21,	x28
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
    add	x4,	x21,	x6
    ldr	w7,	[x4]

    cmp	w15,	w7
    ble	main_213

main_211:
    str	w7,	[x27]

    str	w15,	[x4]


main_213:
    ldr	w22,	[x4]

    add	w24,	w16,	#1
    lsl	w12,	w24,	#2
    add	x14,	x21,	x12
    ldr	w13,	[x14]

    cmp	w22,	w13
    ble	main_221

main_219:
    str	w13,	[x4]

    str	w22,	[x14]


main_221:
    ldr	w0,	[x14]

    add	w1,	w24,	#1
    lsl	w18,	w1,	#2
    add	x22,	x21,	x18
    ldr	w19,	[x22]

    cmp	w0,	w19
    ble	main_229

main_227:
    str	w19,	[x14]

    str	w0,	[x22]


main_229:
    ldr	w8,	[x22]

    add	w9,	w1,	#1
    lsl	w25,	w9,	#2
    add	x1,	x21,	x25
    ldr	w26,	[x1]

    cmp	w8,	w26
    ble	main_237

main_235:
    str	w26,	[x22]

    str	w8,	[x1]


main_237:
    ldr	w15,	[x1]

    add	w12,	w9,	#1
    lsl	w24,	w12,	#2
    add	x27,	x21,	x24
    ldr	w8,	[x27]

    cmp	w15,	w8
    ble	main_245

main_243:
    str	w8,	[x1]

    str	w15,	[x27]


main_245:
    movz	w22,	#9992
    cmp	w12,	w22
    blt	main_179

main_249:
    ldr	w16,	[x27]

    add	w12,	w12,	#1
    lsl	w15,	w12,	#2
    add	x7,	x21,	x15
    ldr	w1,	[x7]

    cmp	w16,	w1
    ble	main_259

main_257:
    str	w1,	[x27]

    str	w16,	[x7]


main_259:
    movz	w25,	#9999
    cmp	w12,	w25
    blt	main_248

main_261:
    add	w5,	w5,	#1
    movz	w26,	#9999
    cmp	w5,	w26
    blt	main_42

main_264:
    movz	w7,	#0
    movz	w2,	#9999

main_265:
    cmp	w7,	w2
    bgt	main_284

main_269:
    add	w11,	w2,	w7
    asr	w6,	w11,	#31
    lsr	w8,	w6,	#31
    add	w9,	w11,	w8
    asr	w22,	w9,	#1
    lsl	w27,	w22,	#2
    add	x26,	x21,	x27
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

