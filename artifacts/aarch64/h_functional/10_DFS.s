.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global to
.align	2
to:
.type to, %object
    .zero	20020

.global next
.align	2
next:
.type next, %object
    .zero	20020

.global head
.align	2
head:
.type head, %object
    .zero	4020

.global vis
.align	2
vis:
.type vis, %object
    .zero	4020

.data

.text

.globl same
.align 2
.p2align 4,,11
.type same, %function
same:
same_2:
    sub	sp, sp, #80
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x24, x25, [sp, #32]
    stp	x26, x28, [sp, #48]
    stp	fp, lr, [sp, #64]
    
    movz	w6,	#1
    adrp	x2, :got:vis
    lsl	w14,	w0,	#2
    mov	w20,	w1
    ldr	x2, [x2, #:got_lo12:vis]
    add	x13,	x2,	x14
    str	w6,	[x13]

    cmp	w0,	w20
    bne	same_5

same_52:
    movz	w0,	#1
    b	same_53

same_5:
    lsl	w4,	w0,	#2
    adrp	x11, :got:head
    ldr	x11, [x11, #:got_lo12:head]
    add	x9,	x11,	x4
    ldr	w19,	[x9]


same_8:
    movz	w24,	#65535
    movk	w24,	#65535,	lsl #16
    cmp	w19,	w24
    bne	same_11

same_55:
    movz	w0,	#0
    b	same_53

same_11:
    lsl	w28,	w19,	#2
    adrp	x25, :got:to
    adrp	x0, :got:vis
    ldr	x25, [x25, #:got_lo12:to]
    add	x22,	x25,	x28
    ldr	w25,	[x22]

    ldr	x0, [x0, #:got_lo12:vis]
    lsl	w4,	w25,	#2
    add	x7,	x0,	x4
    ldr	w1,	[x7]

    cmp	w1,	#0
    bne	same_49

same_17:
    movz	w14,	#1
    str	w14,	[x7]

    cmp	w25,	w20
    bne	same_19

same_39:
    movz	w0,	#1
    b	same_40

same_19:
    lsl	w10,	w25,	#2
    adrp	x6, :got:head
    ldr	x6, [x6, #:got_lo12:head]
    add	x4,	x6,	x10
    ldr	w21,	[x4]


same_22:
    cmp	w21,	w24
    bne	same_25

same_43:
    movz	w0,	#0
    b	same_40

same_25:
    lsl	w22,	w21,	#2
    adrp	x15, :got:to
    adrp	x28, :got:vis
    ldr	x15, [x15, #:got_lo12:to]
    add	x13,	x15,	x22
    ldr	w0,	[x13]

    ldr	x28, [x28, #:got_lo12:vis]
    lsl	w14,	w0,	#2
    add	x26,	x28,	x14
    ldr	w1,	[x26]

    cmp	w1,	#0
    bne	same_36

same_31:
    mov	w1,	w20
    bl	same
    cmp	w0,	#0
    beq	same_36

same_44:
    movz	w0,	#1

same_40:
    cmp	w0,	#0
    beq	same_49

same_56:
    movz	w0,	#1

same_53:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x24, x25, [sp, #32]
    ldp	x26, x28, [sp, #48]
    ldp	fp, lr, [sp, #64]
    
    add	sp, sp, #80
    ret


same_49:
    lsl	w9,	w19,	#2
    adrp	x15, :got:next
    ldr	x15, [x15, #:got_lo12:next]
    add	x13,	x15,	x9
    ldr	w19,	[x13]

    b	same_8

same_36:
    lsl	w6,	w21,	#2
    adrp	x1, :got:next
    ldr	x1, [x1, #:got_lo12:next]
    add	x28,	x1,	x6
    ldr	w21,	[x28]

    b	same_22

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getch
    movz	w27,	#0
    mov	w24,	w0

main_2:
    cmp	w24,	#48
    blt	main_10

main_6:
    cmp	w24,	#57
    bgt	main_10

main_14:
    movz	w19,	#0

main_15:
    cmp	w24,	#48
    blt	main_28

main_19:
    cmp	w24,	#57
    ble	main_21

main_28:
    movz	w18,	#0
    sub	w22,	w18,	w19
    cmp	w27,	#0
    csel	w25,	w22,	w19,	ne
    cset	w20,	ne
    bl	getch
    movz	w21,	#0
    mov	w28,	w0

main_33:
    cmp	w28,	#48
    blt	main_41

main_37:
    cmp	w28,	#57
    bgt	main_41

main_45:
    movz	w24,	#0

main_46:
    cmp	w28,	#48
    blt	main_59

main_50:
    cmp	w28,	#57
    ble	main_52

main_59:
    movz	w3,	#0
    sub	w11,	w3,	w24
    cmp	w21,	#0
    movz	w19,	#0
    csel	w20,	w11,	w24,	ne
    cset	w26,	ne

main_63:
    movz	w1,	#65535
    movk	w1,	#65535,	lsl #16
    cmp	w19,	#952
    blt	main_66

main_181:
    lsl	w11,	w19,	#2
    adrp	x18, :got:head
    add	w28,	w19,	#1
    adrp	x15, :got:head
    adrp	x24, :got:head
    adrp	x2, :got:head
    adrp	x6, :got:head
    ldr	x18, [x18, #:got_lo12:head]
    adrp	x19, :got:head
    add	w5,	w28,	#1
    lsl	w23,	w28,	#2
    add	x16,	x18,	x11
    add	w10,	w5,	#1
    lsl	w28,	w5,	#2
    str	w1,	[x16]

    ldr	x15, [x15, #:got_lo12:head]
    lsl	w5,	w10,	#2
    add	x13,	x15,	x23
    add	w15,	w10,	#1
    str	w1,	[x13]

    add	w21,	w15,	#1
    lsl	w10,	w15,	#2
    ldr	x19, [x19, #:got_lo12:head]
    add	x17,	x19,	x28
    add	w26,	w21,	#1
    lsl	w14,	w21,	#2
    str	w1,	[x17]

    add	w3,	w26,	#1
    lsl	w18,	w26,	#2
    ldr	x24, [x24, #:got_lo12:head]
    add	x22,	x24,	x5
    add	w19,	w3,	#1
    lsl	w23,	w3,	#2
    str	w1,	[x22]

    ldr	x2, [x2, #:got_lo12:head]
    add	x27,	x2,	x10
    adrp	x10, :got:head
    str	w1,	[x27]

    ldr	x6, [x6, #:got_lo12:head]
    add	x4,	x6,	x14
    adrp	x14, :got:head
    str	w1,	[x4]

    ldr	x10, [x10, #:got_lo12:head]
    add	x8,	x10,	x18
    str	w1,	[x8]

    ldr	x14, [x14, #:got_lo12:head]
    add	x12,	x14,	x23
    str	w1,	[x12]

    cmp	w19,	#1000
    blt	main_181

main_202:
    lsl	w24,	w19,	#2
    adrp	x3, :got:head
    add	w19,	w19,	#1
    ldr	x3, [x3, #:got_lo12:head]
    add	x28,	x3,	x24
    str	w1,	[x28]

    cmp	w19,	#1005
    blt	main_202

main_207:
    cmp	w20,	#0
    beq	main_376

main_209:
    movz	w24,	#0

main_211:
    bl	getch
    mov	w17,	w0

main_215:
    cmp	w17,	#81
    beq	main_224

main_218:
    cmp	w17,	#85
    bne	main_220

main_224:
    cmp	w17,	#81
    beq	main_226

main_297:
    bl	getch
    movz	w26,	#0
    mov	w28,	w0

main_299:
    cmp	w28,	#48
    blt	main_307

main_303:
    cmp	w28,	#57
    bgt	main_307

main_311:
    movz	w19,	#0

main_312:
    cmp	w28,	#48
    blt	main_325

main_316:
    cmp	w28,	#57
    ble	main_318

main_325:
    movz	w22,	#0
    sub	w21,	w22,	w19
    cmp	w26,	#0
    csel	w23,	w21,	w19,	ne
    cset	w18,	ne
    bl	getch
    movz	w22,	#0
    mov	w4,	w0

main_330:
    cmp	w4,	#48
    blt	main_338

main_334:
    cmp	w4,	#57
    bgt	main_338

main_342:
    movz	w28,	#0

main_343:
    cmp	w4,	#48
    blt	main_356

main_347:
    cmp	w4,	#57
    ble	main_349

main_356:
    movz	w27,	#0
    sub	w8,	w27,	w28
    cmp	w22,	#0
    lsl	w6,	w23,	#2
    adrp	x10, :got:head
    lsl	w3,	w24,	#2
    csel	w1,	w8,	w28,	ne
    adrp	x7, :got:next
    adrp	x4, :got:to
    add	w22,	w24,	#1
    adrp	x26, :got:next
    cset	w21,	ne
    lsl	w28,	w24,	#2
    ldr	x4, [x4, #:got_lo12:to]
    lsl	w15,	w22,	#2
    add	x2,	x4,	x28
    str	w1,	[x2]

    ldr	x7, [x7, #:got_lo12:next]
    ldr	x10, [x10, #:got_lo12:head]
    add	x7,	x7,	x3
    add	x5,	x10,	x6
    ldr	w11,	[x5]

    str	w11,	[x7]

    lsl	w11,	w1,	#2
    lsl	w7,	w22,	#2
    str	w24,	[x5]

    adrp	x1, :got:head
    add	w24,	w22,	#1
    adrp	x5, :got:to
    ldr	x5, [x5, #:got_lo12:to]
    add	x3,	x5,	x15
    str	w23,	[x3]

    ldr	x26, [x26, #:got_lo12:next]
    ldr	x1, [x1, #:got_lo12:head]
    add	x6,	x26,	x7
    add	x10,	x1,	x11
    ldr	w2,	[x10]

    str	w2,	[x6]

    str	w22,	[x10]

    b	main_370

main_349:
    lsl	w27,	w28,	#1
    add	w28,	w27,	w28,	lsl #3
    add	w18,	w4,	w28
    sub	w28,	w18,	#48
    bl	getch
    mov	w4,	w0
    b	main_343

main_338:
    cmp	w4,	#45
    cset	w26,	eq
    movz	w26,	#1
    csel	w22,	w26,	w22,	eq
    bl	getch
    mov	w4,	w0
    b	main_330

main_318:
    lsl	w18,	w19,	#1
    add	w18,	w18,	w19,	lsl #3
    add	w27,	w28,	w18
    sub	w19,	w27,	#48
    bl	getch
    mov	w28,	w0
    b	main_312

main_307:
    cmp	w28,	#45
    movz	w28,	#1
    cset	w19,	eq
    csel	w26,	w28,	w26,	eq
    bl	getch
    mov	w28,	w0
    b	main_299

main_226:
    bl	getch
    movz	w22,	#0
    mov	w2,	w0

main_228:
    cmp	w2,	#48
    blt	main_236

main_232:
    cmp	w2,	#57
    bgt	main_236

main_240:
    movz	w23,	#0

main_241:
    cmp	w2,	#48
    blt	main_254

main_245:
    cmp	w2,	#57
    ble	main_247

main_254:
    movz	w21,	#0
    sub	w18,	w21,	w23
    cmp	w22,	#0
    csel	w28,	w18,	w23,	ne
    cset	w22,	ne
    bl	getch
    movz	w26,	#0
    mov	w12,	w0

main_259:
    cmp	w12,	#48
    blt	main_267

main_263:
    cmp	w12,	#57
    bgt	main_267

main_271:
    movz	w22,	#0

main_272:
    cmp	w12,	#48
    blt	main_285

main_276:
    cmp	w12,	#57
    ble	main_278

main_285:
    movz	w23,	#0
    sub	w17,	w23,	w22
    cmp	w26,	#0
    movz	w14,	#1
    csel	w1,	w17,	w22,	ne
    cset	w3,	ne

main_289:
    cmp	w14,	w25
    ble	main_292

main_295:
    mov	w0,	w28
    bl	same
    bl	putint
    movz	w0,	#10
    bl	putch

main_370:
    sub	w20,	w20,	#1
    cmp	w20,	#0
    bne	main_211
    b	main_376

main_292:
    lsl	w3,	w14,	#2
    adrp	x11, :got:vis
    movz	w12,	#0
    add	w14,	w14,	#1
    ldr	x11, [x11, #:got_lo12:vis]
    add	x2,	x11,	x3
    str	w12,	[x2]

    b	main_289

main_278:
    lsl	w19,	w22,	#1
    add	w19,	w19,	w22,	lsl #3
    add	w21,	w12,	w19
    sub	w22,	w21,	#48
    bl	getch
    mov	w12,	w0
    b	main_272

main_267:
    cmp	w12,	#45
    cset	w27,	eq
    movz	w27,	#1
    csel	w26,	w27,	w26,	eq
    bl	getch
    mov	w12,	w0
    b	main_259

main_247:
    lsl	w28,	w23,	#1
    add	w18,	w28,	w23,	lsl #3
    add	w19,	w2,	w18
    sub	w23,	w19,	#48
    bl	getch
    mov	w2,	w0
    b	main_241

main_236:
    cmp	w2,	#45
    movz	w23,	#1
    cset	w26,	eq
    csel	w22,	w23,	w22,	eq
    bl	getch
    mov	w2,	w0
    b	main_228

main_220:
    bl	getch
    mov	w17,	w0
    b	main_215

main_376:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_66:
    lsl	w7,	w19,	#2
    adrp	x8, :got:head
    add	w3,	w19,	#1
    adrp	x26, :got:head
    adrp	x15, :got:head
    adrp	x24, :got:head
    adrp	x2, :got:head
    adrp	x14, :got:head
    adrp	x18, :got:head
    ldr	x8, [x8, #:got_lo12:head]
    adrp	x19, :got:head
    lsl	w11,	w3,	#2
    add	x6,	x8,	x7
    adrp	x7, :got:head
    add	w8,	w3,	#1
    adrp	x3, :got:head
    str	w1,	[x6]

    lsl	w16,	w8,	#2
    add	w13,	w8,	#1
    adrp	x6, :got:head
    ldr	x26, [x26, #:got_lo12:head]
    add	x23,	x26,	x11
    add	w17,	w13,	#1
    lsl	w21,	w13,	#2
    adrp	x11, :got:head
    str	w1,	[x23]

    lsl	w26,	w17,	#2
    add	w23,	w17,	#1
    ldr	x3, [x3, #:got_lo12:head]
    add	x28,	x3,	x16
    lsl	w3,	w23,	#2
    str	w1,	[x28]

    add	w28,	w23,	#1
    ldr	x7, [x7, #:got_lo12:head]
    adrp	x23, :got:head
    add	x5,	x7,	x21
    lsl	w7,	w28,	#2
    str	w1,	[x5]

    add	w5,	w28,	#1
    ldr	x11, [x11, #:got_lo12:head]
    adrp	x28, :got:head
    add	x9,	x11,	x26
    add	w10,	w5,	#1
    lsl	w11,	w5,	#2
    str	w1,	[x9]

    adrp	x5, :got:head
    adrp	x9, :got:head
    ldr	x15, [x15, #:got_lo12:head]
    lsl	w16,	w10,	#2
    add	x13,	x15,	x3
    add	w15,	w10,	#1
    adrp	x10, :got:head
    str	w1,	[x13]

    lsl	w21,	w15,	#2
    adrp	x13, :got:head
    ldr	x19, [x19, #:got_lo12:head]
    add	x17,	x19,	x7
    add	w19,	w15,	#1
    str	w1,	[x17]

    lsl	w26,	w19,	#2
    ldr	x24, [x24, #:got_lo12:head]
    add	x22,	x24,	x11
    str	w1,	[x22]

    ldr	x2, [x2, #:got_lo12:head]
    add	x27,	x2,	x16
    str	w1,	[x27]

    adrp	x27, :got:head
    ldr	x6, [x6, #:got_lo12:head]
    add	x4,	x6,	x21
    str	w1,	[x4]

    adrp	x4, :got:head
    ldr	x10, [x10, #:got_lo12:head]
    add	x8,	x10,	x26
    add	w26,	w19,	#1
    str	w1,	[x8]

    lsl	w3,	w26,	#2
    adrp	x8, :got:head
    ldr	x14, [x14, #:got_lo12:head]
    add	x12,	x14,	x3
    add	w3,	w26,	#1
    str	w1,	[x12]

    lsl	w7,	w3,	#2
    adrp	x12, :got:head
    ldr	x18, [x18, #:got_lo12:head]
    add	x16,	x18,	x7
    add	w7,	w3,	#1
    str	w1,	[x16]

    lsl	w11,	w7,	#2
    adrp	x16, :got:head
    ldr	x23, [x23, #:got_lo12:head]
    add	x21,	x23,	x11
    add	w11,	w7,	#1
    str	w1,	[x21]

    add	w17,	w11,	#1
    lsl	w15,	w11,	#2
    ldr	x28, [x28, #:got_lo12:head]
    add	x26,	x28,	x15
    add	w22,	w17,	#1
    lsl	w21,	w17,	#2
    adrp	x17, :got:head
    str	w1,	[x26]

    add	w28,	w22,	#1
    lsl	w26,	w22,	#2
    ldr	x5, [x5, #:got_lo12:head]
    adrp	x22, :got:head
    add	x3,	x5,	x21
    add	w5,	w28,	#1
    str	w1,	[x3]

    lsl	w3,	w28,	#2
    ldr	x9, [x9, #:got_lo12:head]
    add	x7,	x9,	x26
    add	w9,	w5,	#1
    str	w1,	[x7]

    lsl	w7,	w5,	#2
    ldr	x13, [x13, #:got_lo12:head]
    add	x11,	x13,	x3
    add	w13,	w9,	#1
    str	w1,	[x11]

    lsl	w11,	w9,	#2
    ldr	x17, [x17, #:got_lo12:head]
    add	x15,	x17,	x7
    str	w1,	[x15]

    lsl	w15,	w13,	#2
    ldr	x22, [x22, #:got_lo12:head]
    add	x19,	x22,	x11
    str	w1,	[x19]

    add	w19,	w13,	#1
    ldr	x27, [x27, #:got_lo12:head]
    add	x24,	x27,	x15
    lsl	w21,	w19,	#2
    str	w1,	[x24]

    add	w24,	w19,	#1
    ldr	x4, [x4, #:got_lo12:head]
    adrp	x19, :got:head
    add	x2,	x4,	x21
    adrp	x21, :got:head
    lsl	w26,	w24,	#2
    add	w4,	w24,	#1
    str	w1,	[x2]

    adrp	x24, :got:head
    adrp	x2, :got:head
    ldr	x8, [x8, #:got_lo12:head]
    lsl	w3,	w4,	#2
    add	x6,	x8,	x26
    adrp	x26, :got:head
    add	w8,	w4,	#1
    str	w1,	[x6]

    lsl	w7,	w8,	#2
    ldr	x12, [x12, #:got_lo12:head]
    add	x10,	x12,	x3
    adrp	x3, :got:head
    add	w12,	w8,	#1
    str	w1,	[x10]

    lsl	w11,	w12,	#2
    ldr	x16, [x16, #:got_lo12:head]
    add	x14,	x16,	x7
    adrp	x7, :got:head
    add	w16,	w12,	#1
    str	w1,	[x14]

    add	w22,	w16,	#1
    lsl	w15,	w16,	#2
    ldr	x21, [x21, #:got_lo12:head]
    add	x18,	x21,	x11
    adrp	x11, :got:head
    lsl	w21,	w22,	#2
    str	w1,	[x18]

    ldr	x26, [x26, #:got_lo12:head]
    add	x23,	x26,	x15
    adrp	x15, :got:head
    str	w1,	[x23]

    adrp	x23, :got:head
    ldr	x3, [x3, #:got_lo12:head]
    add	x28,	x3,	x21
    str	w1,	[x28]

    ldr	x7, [x7, #:got_lo12:head]
    add	w28,	w22,	#1
    add	w6,	w28,	#1
    lsl	w26,	w28,	#2
    adrp	x28, :got:head
    add	x5,	x7,	x26
    add	w10,	w6,	#1
    lsl	w3,	w6,	#2
    adrp	x6, :got:head
    str	w1,	[x5]

    add	w14,	w10,	#1
    lsl	w7,	w10,	#2
    adrp	x5, :got:head
    ldr	x11, [x11, #:got_lo12:head]
    adrp	x10, :got:head
    add	x9,	x11,	x3
    add	w18,	w14,	#1
    lsl	w11,	w14,	#2
    adrp	x14, :got:head
    str	w1,	[x9]

    ldr	x15, [x15, #:got_lo12:head]
    add	x13,	x15,	x7
    lsl	w15,	w18,	#2
    str	w1,	[x13]

    ldr	x19, [x19, #:got_lo12:head]
    add	x17,	x19,	x11
    str	w1,	[x17]

    ldr	x24, [x24, #:got_lo12:head]
    add	x22,	x24,	x15
    add	w24,	w18,	#1
    adrp	x18, :got:head
    str	w1,	[x22]

    add	w3,	w24,	#1
    lsl	w21,	w24,	#2
    ldr	x2, [x2, #:got_lo12:head]
    add	x27,	x2,	x21
    add	w9,	w3,	#1
    lsl	w26,	w3,	#2
    str	w1,	[x27]

    add	w13,	w9,	#1
    lsl	w3,	w9,	#2
    ldr	x6, [x6, #:got_lo12:head]
    adrp	x9, :got:head
    add	x4,	x6,	x26
    add	w17,	w13,	#1
    lsl	w7,	w13,	#2
    adrp	x13, :got:head
    str	w1,	[x4]

    add	w22,	w17,	#1
    lsl	w11,	w17,	#2
    adrp	x4, :got:head
    ldr	x10, [x10, #:got_lo12:head]
    adrp	x17, :got:head
    add	x8,	x10,	x3
    add	w27,	w22,	#1
    lsl	w15,	w22,	#2
    adrp	x22, :got:head
    str	w1,	[x8]

    lsl	w19,	w27,	#2
    adrp	x8, :got:head
    ldr	x14, [x14, #:got_lo12:head]
    add	x12,	x14,	x7
    add	w7,	w27,	#1
    adrp	x27, :got:head
    str	w1,	[x12]

    add	w12,	w7,	#1
    ldr	x18, [x18, #:got_lo12:head]
    add	x16,	x18,	x11
    str	w1,	[x16]

    add	w16,	w12,	#1
    ldr	x23, [x23, #:got_lo12:head]
    add	x21,	x23,	x15
    str	w1,	[x21]

    add	w21,	w16,	#1
    ldr	x28, [x28, #:got_lo12:head]
    add	x26,	x28,	x19
    str	w1,	[x26]

    ldr	x5, [x5, #:got_lo12:head]
    lsl	w26,	w7,	#2
    add	x3,	x5,	x26
    add	w26,	w21,	#1
    str	w1,	[x3]

    ldr	x9, [x9, #:got_lo12:head]
    lsl	w3,	w12,	#2
    adrp	x12, :got:head
    add	x7,	x9,	x3
    add	w3,	w26,	#1
    str	w1,	[x7]

    add	w9,	w3,	#1
    ldr	x13, [x13, #:got_lo12:head]
    lsl	w7,	w16,	#2
    adrp	x16, :got:head
    add	w14,	w9,	#1
    add	x11,	x13,	x7
    add	w18,	w14,	#1
    str	w1,	[x11]

    ldr	x17, [x17, #:got_lo12:head]
    lsl	w11,	w21,	#2
    adrp	x21, :got:head
    add	w23,	w18,	#1
    lsl	w7,	w18,	#2
    add	x15,	x17,	x11
    add	w28,	w23,	#1
    lsl	w11,	w23,	#2
    str	w1,	[x15]

    ldr	x22, [x22, #:got_lo12:head]
    lsl	w15,	w26,	#2
    add	w5,	w28,	#1
    lsl	w26,	w9,	#2
    add	x19,	x22,	x15
    lsl	w15,	w28,	#2
    str	w1,	[x19]

    ldr	x27, [x27, #:got_lo12:head]
    lsl	w19,	w3,	#2
    lsl	w3,	w14,	#2
    add	x24,	x27,	x19
    lsl	w19,	w5,	#2
    str	w1,	[x24]

    ldr	x4, [x4, #:got_lo12:head]
    add	x2,	x4,	x26
    adrp	x26, :got:head
    str	w1,	[x2]

    ldr	x8, [x8, #:got_lo12:head]
    add	x6,	x8,	x3
    adrp	x3, :got:head
    str	w1,	[x6]

    ldr	x12, [x12, #:got_lo12:head]
    add	x10,	x12,	x7
    adrp	x7, :got:head
    str	w1,	[x10]

    add	w10,	w5,	#1
    ldr	x16, [x16, #:got_lo12:head]
    add	x14,	x16,	x11
    adrp	x11, :got:head
    add	w16,	w10,	#1
    str	w1,	[x14]

    ldr	x21, [x21, #:got_lo12:head]
    add	x18,	x21,	x15
    adrp	x15, :got:head
    add	w21,	w16,	#1
    str	w1,	[x18]

    ldr	x26, [x26, #:got_lo12:head]
    add	x23,	x26,	x19
    lsl	w26,	w10,	#2
    str	w1,	[x23]

    ldr	x3, [x3, #:got_lo12:head]
    add	x28,	x3,	x26
    add	w26,	w21,	#1
    lsl	w3,	w16,	#2
    str	w1,	[x28]

    add	w19,	w26,	#1
    ldr	x7, [x7, #:got_lo12:head]
    add	x5,	x7,	x3
    lsl	w7,	w21,	#2
    str	w1,	[x5]

    ldr	x11, [x11, #:got_lo12:head]
    add	x9,	x11,	x7
    lsl	w11,	w26,	#2
    str	w1,	[x9]

    ldr	x15, [x15, #:got_lo12:head]
    add	x13,	x15,	x11
    str	w1,	[x13]

    b	main_63

main_52:
    lsl	w22,	w24,	#1
    add	w23,	w22,	w24,	lsl #3
    add	w19,	w28,	w23
    sub	w24,	w19,	#48
    bl	getch
    mov	w28,	w0
    b	main_46

main_41:
    cmp	w28,	#45
    movz	w24,	#1
    cset	w23,	eq
    csel	w21,	w24,	w21,	eq
    bl	getch
    mov	w28,	w0
    b	main_33

main_21:
    lsl	w22,	w19,	#1
    add	w26,	w22,	w19,	lsl #3
    add	w26,	w24,	w26
    sub	w19,	w26,	#48
    bl	getch
    mov	w24,	w0
    b	main_15

main_10:
    cmp	w24,	#45
    movz	w26,	#1
    cset	w19,	eq
    csel	w27,	w26,	w27,	eq
    bl	getch
    mov	w24,	w0
    b	main_2

