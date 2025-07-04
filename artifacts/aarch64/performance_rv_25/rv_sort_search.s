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
    blt	main_6

main_39:
    add	x23,	sp,	#16
    movz	w22,	#0

main_42:
    movz	w9,	#0

main_45:
    lsl	w21,	w9,	#2
    add	x17,	x23,	x21
    add	w21,	w9,	#1
    ldr	w1,	[x17]

    lsl	w12,	w21,	#2
    add	x25,	x23,	x12
    ldr	w13,	[x25]

    cmp	w1,	w13
    ble	main_55

main_53:
    str	w13,	[x17]

    str	w1,	[x25]


main_55:
    ldr	w0,	[x25]

    add	w1,	w21,	#1
    lsl	w18,	w1,	#2
    add	x2,	x23,	x18
    ldr	w19,	[x2]

    cmp	w0,	w19
    ble	main_63

main_61:
    str	w19,	[x25]

    str	w0,	[x2]


main_63:
    ldr	w6,	[x2]

    add	w7,	w1,	#1
    lsl	w26,	w7,	#2
    add	x10,	x23,	x26
    ldr	w27,	[x10]

    cmp	w6,	w27
    ble	main_71

main_69:
    str	w27,	[x2]

    str	w6,	[x10]


main_71:
    ldr	w14,	[x10]

    add	w15,	w7,	#1
    lsl	w3,	w15,	#2
    add	x17,	x23,	x3
    ldr	w4,	[x17]

    cmp	w14,	w4
    ble	main_79

main_77:
    str	w4,	[x10]

    str	w14,	[x17]


main_79:
    ldr	w20,	[x17]

    add	w24,	w15,	#1
    lsl	w9,	w24,	#2
    add	x28,	x23,	x9
    ldr	w10,	[x28]

    cmp	w20,	w10
    ble	main_87

main_85:
    str	w10,	[x17]

    str	w20,	[x28]


main_87:
    ldr	w1,	[x28]

    add	w2,	w24,	#1
    lsl	w15,	w2,	#2
    add	x5,	x23,	x15
    ldr	w16,	[x5]

    cmp	w1,	w16
    ble	main_95

main_93:
    str	w16,	[x28]

    str	w1,	[x5]


main_95:
    ldr	w7,	[x5]

    add	w8,	w2,	#1
    lsl	w21,	w8,	#2
    add	x13,	x23,	x21
    ldr	w24,	[x13]

    cmp	w7,	w24
    ble	main_103

main_101:
    str	w24,	[x5]

    str	w7,	[x13]


main_103:
    ldr	w15,	[x13]

    add	w16,	w8,	#1
    lsl	w0,	w16,	#2
    add	x21,	x23,	x0
    ldr	w1,	[x21]

    cmp	w15,	w1
    ble	main_111

main_109:
    str	w1,	[x13]

    str	w15,	[x21]


main_111:
    ldr	w24,	[x21]

    add	w26,	w16,	#1
    lsl	w6,	w26,	#2
    add	x4,	x23,	x6
    ldr	w7,	[x4]

    cmp	w24,	w7
    ble	main_119

main_117:
    str	w7,	[x21]

    str	w24,	[x4]


main_119:
    ldr	w2,	[x4]

    add	w3,	w26,	#1
    lsl	w12,	w3,	#2
    add	x10,	x23,	x12
    ldr	w13,	[x10]

    cmp	w2,	w13
    ble	main_127

main_125:
    str	w13,	[x4]

    str	w2,	[x10]


main_127:
    ldr	w8,	[x10]

    add	w9,	w3,	#1
    lsl	w18,	w9,	#2
    add	x15,	x23,	x18
    ldr	w19,	[x15]

    cmp	w8,	w19
    ble	main_135

main_133:
    str	w19,	[x10]

    str	w8,	[x15]


main_135:
    ldr	w14,	[x15]

    add	w24,	w9,	#1
    lsl	w26,	w24,	#2
    add	x28,	x23,	x26
    ldr	w27,	[x28]

    cmp	w14,	w27
    ble	main_143

main_141:
    str	w27,	[x15]

    str	w14,	[x28]


main_143:
    ldr	w26,	[x28]

    add	w6,	w24,	#1
    lsl	w3,	w6,	#2
    add	x7,	x23,	x3
    ldr	w4,	[x7]

    cmp	w26,	w4
    ble	main_151

main_149:
    str	w4,	[x28]

    str	w26,	[x7]


main_151:
    ldr	w3,	[x7]

    add	w12,	w6,	#1
    lsl	w9,	w12,	#2
    add	x19,	x23,	x9
    ldr	w10,	[x19]

    cmp	w3,	w10
    ble	main_159

main_157:
    str	w10,	[x7]

    str	w3,	[x19]


main_159:
    ldr	w9,	[x19]

    add	w10,	w12,	#1
    lsl	w15,	w10,	#2
    add	x25,	x23,	x15
    ldr	w16,	[x25]

    cmp	w9,	w16
    ble	main_167

main_165:
    str	w16,	[x19]

    str	w9,	[x25]


main_167:
    ldr	w18,	[x25]

    add	w9,	w10,	#1
    lsl	w11,	w9,	#2
    add	x2,	x23,	x11
    ldr	w20,	[x2]

    cmp	w18,	w20
    ble	main_175

main_173:
    str	w20,	[x25]

    str	w18,	[x2]


main_175:
    movz	w15,	#9984
    cmp	w9,	w15
    blt	main_45

main_179:
    ldr	w8,	[x2]

    add	w13,	w9,	#1
    lsl	w18,	w13,	#2
    add	x27,	x23,	x18
    ldr	w19,	[x27]

    cmp	w8,	w19
    ble	main_189

main_187:
    str	w19,	[x2]

    str	w8,	[x27]


main_189:
    ldr	w5,	[x27]

    add	w6,	w13,	#1
    lsl	w7,	w6,	#2
    add	x21,	x23,	x7
    ldr	w8,	[x21]

    cmp	w5,	w8
    ble	main_197

main_195:
    str	w8,	[x27]

    str	w5,	[x21]


main_197:
    ldr	w12,	[x21]

    add	w15,	w6,	#1
    lsl	w13,	w15,	#2
    add	x0,	x23,	x13
    ldr	w14,	[x0]

    cmp	w12,	w14
    ble	main_205

main_203:
    str	w14,	[x21]

    str	w12,	[x0]


main_205:
    ldr	w18,	[x0]

    add	w24,	w15,	#1
    lsl	w19,	w24,	#2
    add	x8,	x23,	x19
    ldr	w20,	[x8]

    cmp	w18,	w20
    ble	main_213

main_211:
    str	w20,	[x0]

    str	w18,	[x8]


main_213:
    ldr	w0,	[x8]

    add	w1,	w24,	#1
    lsl	w27,	w1,	#2
    add	x16,	x23,	x27
    ldr	w28,	[x16]

    cmp	w0,	w28
    ble	main_221

main_219:
    str	w28,	[x8]

    str	w0,	[x16]


main_221:
    ldr	w8,	[x16]

    add	w9,	w1,	#1
    lsl	w4,	w9,	#2
    add	x26,	x23,	x4
    ldr	w5,	[x26]

    cmp	w8,	w5
    ble	main_229

main_227:
    str	w5,	[x16]

    str	w8,	[x26]


main_229:
    ldr	w15,	[x26]

    add	w16,	w9,	#1
    lsl	w10,	w16,	#2
    add	x4,	x23,	x10
    ldr	w11,	[x4]

    cmp	w15,	w11
    ble	main_237

main_235:
    str	w11,	[x26]

    str	w15,	[x4]


main_237:
    ldr	w24,	[x4]

    add	w9,	w16,	#1
    lsl	w7,	w9,	#2
    add	x2,	x23,	x7
    ldr	w19,	[x2]

    cmp	w24,	w19
    ble	main_245

main_243:
    str	w19,	[x4]

    str	w24,	[x2]


main_245:
    movz	w25,	#9992
    cmp	w9,	w25
    blt	main_179

main_249:
    ldr	w19,	[x2]

    add	w9,	w9,	#1
    lsl	w27,	w9,	#2
    add	x15,	x23,	x27
    ldr	w11,	[x15]

    cmp	w19,	w11
    ble	main_259

main_257:
    str	w11,	[x2]

    str	w19,	[x15]


main_259:
    movz	w27,	#9999
    cmp	w9,	w27
    bge	main_261

main_248:
    mov	x2,	x15
    b	main_249

main_261:
    add	w22,	w22,	#1
    movz	w1,	#9999
    cmp	w22,	w1
    blt	main_42

main_264:
    movz	w17,	#0
    movz	w9,	#9999

main_265:
    cmp	w17,	w9
    ble	main_269

main_284:
    movz	w20,	#65535
    movk	w20,	#65535,	lsl #16
    b	main_286

main_269:
    add	w19,	w9,	w17
    asr	w5,	w19,	#31
    lsr	w6,	w5,	#31
    add	w7,	w19,	w6
    asr	w20,	w7,	#1
    lsl	w8,	w20,	#2
    add	x7,	x23,	x8
    ldr	w10,	[x7]

    cmp	w10,	#303
    bne	main_275

main_286:
    movz	w0,	#303
    bl	putint
    movz	w0,	#32
    bl	putch
    mov	w0,	w20
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


main_275:
    cmp	w10,	#303
    blt	main_277

main_279:
    sub	w9,	w20,	#1
    b	main_265

main_277:
    add	w17,	w20,	#1
    b	main_265

main_6:
    lsl	w14,	w19,	#2
    movz	w0,	#10000
    movz	w28,	#10000
    add	w18,	w19,	#1
    add	w2,	w5,	#303
    movz	w27,	#10000
    movz	w25,	#10000
    movz	w24,	#10000
    mov	x26,	x14
    sdiv	w13,	w5,	w0
    movz	w19,	#10000
    lsl	w21,	w18,	#2
    add	w23,	w2,	#303
    sdiv	w9,	w2,	w27
    movz	w14,	#10000
    add	x26,	sp,	x26
    msub	w15,	w13,	w28,	w5

    mov	x20,	x21
    sdiv	w6,	w23,	w25
    add	w21,	w18,	#1
    add	x26,	x26,	#16
    add	x20,	sp,	x20
    msub	w27,	w6,	w24,	w23

    movz	w18,	#10000
    add	w13,	w21,	#1
    str	w15,	[x26]

    add	x20,	x20,	#16
    add	w15,	w23,	#303
    movz	w26,	#10000
    add	w12,	w13,	#1
    movz	w23,	#10000
    msub	w22,	w9,	w26,	w2

    sdiv	w3,	w15,	w23
    lsl	w2,	w13,	#2
    add	w16,	w12,	#1
    lsl	w7,	w12,	#2
    lsl	w26,	w21,	#2
    str	w22,	[x20]

    add	w13,	w15,	#303
    mov	x11,	x7
    lsl	w12,	w16,	#2
    movz	w21,	#10000
    mov	x28,	x26
    movz	w22,	#10000
    mov	x20,	x2
    add	x11,	sp,	x11
    sdiv	w0,	w13,	w21
    add	x28,	sp,	x28
    msub	w3,	w3,	w22,	w15

    add	x20,	sp,	x20
    add	x11,	x11,	#16
    mov	x15,	x12
    add	x28,	x28,	#16
    add	x15,	sp,	x15
    add	x20,	x20,	#16
    str	w27,	[x28]

    add	x15,	x15,	#16
    str	w3,	[x20]

    add	w3,	w16,	#1
    movz	w20,	#10000
    movz	w16,	#10000
    msub	w8,	w0,	w20,	w13

    add	w1,	w3,	#1
    lsl	w17,	w3,	#2
    add	w20,	w13,	#303
    str	w8,	[x11]

    mov	x22,	x17
    movz	w17,	#10000
    add	x22,	sp,	x22
    add	w5,	w20,	#303
    sdiv	w26,	w20,	w19
    add	w19,	w1,	#1
    msub	w13,	w26,	w18,	w20

    add	x22,	x22,	#16
    str	w13,	[x15]

    add	w2,	w5,	#303
    sdiv	w23,	w5,	w17
    movz	w15,	#10000
    msub	w18,	w23,	w16,	w5

    str	w18,	[x22]

    sdiv	w20,	w2,	w15
    add	w5,	w2,	#303
    lsl	w22,	w1,	#2
    msub	w23,	w20,	w14,	w2

    mov	x28,	x22
    add	x28,	sp,	x28
    add	x28,	x28,	#16
    str	w23,	[x28]

    b	main_2

