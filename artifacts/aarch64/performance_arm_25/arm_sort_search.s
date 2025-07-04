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
    movz	w10,	#0
    movz	w3,	#0

main_2:
    movz	w1,	#10000
    cmp	w3,	w1
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
    asr	w14,	w19,	#31
    lsr	w15,	w14,	#31
    add	w16,	w19,	w15
    asr	w20,	w16,	#1
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
    lsl	w15,	w3,	#2
    movz	w8,	#10000
    movz	w7,	#10000
    add	w11,	w3,	#1
    movz	w14,	#38831
    movz	w6,	#10000
    movz	w4,	#10000
    movz	w2,	#10000
    movz	w26,	#10000
    mov	x27,	x15
    sdiv	w23,	w10,	w8
    movz	w3,	#10000
    add	w28,	w11,	#1
    lsl	w19,	w11,	#2
    movk	w14,	#152,	lsl #16
    add	x27,	sp,	x27
    movz	w8,	#10000
    msub	w16,	w23,	w7,	w10

    lsl	w24,	w28,	#2
    mov	x5,	x19
    add	x27,	x27,	#16
    movz	w7,	#10000
    add	w23,	w10,	w14
    mov	x12,	x24
    add	x5,	sp,	x5
    add	x12,	sp,	x12
    str	w16,	[x27]

    add	w0,	w23,	w14
    sdiv	w22,	w23,	w8
    add	x5,	x5,	#16
    add	x12,	x12,	#16
    movz	w27,	#10000
    add	w8,	w28,	#1
    msub	w20,	w22,	w7,	w23

    add	w9,	w0,	w14
    sdiv	w18,	w0,	w6
    movz	w28,	#10000
    add	w15,	w8,	#1
    str	w20,	[x5]

    add	w16,	w9,	w14
    sdiv	w13,	w9,	w4
    movz	w5,	#10000
    msub	w1,	w13,	w3,	w9

    add	w21,	w16,	w14
    msub	w25,	w18,	w5,	w0

    sdiv	w9,	w16,	w2
    lsl	w5,	w15,	#2
    lsl	w0,	w8,	#2
    str	w25,	[x12]

    mov	x20,	x0
    mov	x25,	x5
    movz	w0,	#10000
    add	x20,	sp,	x20
    add	x25,	sp,	x25
    sdiv	w4,	w21,	w0
    add	x20,	x20,	#16
    msub	w11,	w4,	w28,	w21

    add	x25,	x25,	#16
    add	w28,	w21,	w14
    str	w1,	[x20]

    sdiv	w0,	w28,	w27
    add	w20,	w15,	#1
    movz	w1,	#10000
    msub	w17,	w0,	w26,	w28

    add	w24,	w20,	#1
    lsl	w10,	w20,	#2
    msub	w6,	w9,	w1,	w16

    mov	x2,	x10
    str	w6,	[x25]

    add	x2,	sp,	x2
    add	w1,	w24,	#1
    lsl	w16,	w24,	#2
    movz	w25,	#10000
    movz	w24,	#10000
    add	x2,	x2,	#16
    mov	x7,	x16
    add	w3,	w1,	#1
    lsl	w21,	w1,	#2
    add	x7,	sp,	x7
    str	w11,	[x2]

    add	w2,	w28,	w14
    add	x7,	x7,	#16
    mov	x28,	x21
    add	x28,	sp,	x28
    add	w10,	w2,	w14
    sdiv	w25,	w2,	w25
    str	w17,	[x7]

    msub	w22,	w25,	w24,	w2

    add	x28,	x28,	#16
    str	w22,	[x28]

    b	main_2

