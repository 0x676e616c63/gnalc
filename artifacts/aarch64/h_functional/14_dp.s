.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    movz	fp,	#17696
    movk	fp,	#2,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#9628
    movz	w1,	#0
    movz	fp,	#8056
    movk	w2,	#2,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    movz	w2,	#8040
    movz	w1,	#0
    add	x0,	sp,	#16
    bl	memset
    bl	getint
    mov	w25,	w0
    bl	getint
    movz	w20,	#1
    mov	w28,	w0

main_5:
    cmp	w20,	w25
    bgt	main_23

main_8:
    bl	getint
    movz	w27,	#1
    movz	fp,	#8056
    asr	w4,	w0,	#31
    lsl	w21,	w20,	#3
    mov	x12,	x21
    lsr	w5,	w4,	#31
    sub	w21,	w20,	#1
    add	x12,	sp,	x12
    add	w6,	w0,	w5
    add	x12,	x12,	#16
    asr	w9,	w6,	#1
    lsl	w10,	w9,	#1
    sub	w11,	w0,	w10
    movz	w10,	#140
    lsl	w23,	w11,	#2
    mul	w7,	w21,	w10
    add	x10,	x12,	#4
    mov	x8,	x7
    add	x26,	x12,	x23
    add	x8,	sp,	x8
    str	w27,	[x26]

    movz	w26,	#140
    mul	w26,	w20,	w26
    add	w20,	w20,	#1
    mov	x22,	x26
    add	x22,	sp,	x22
    add	x22,	x22,	fp
    movz	fp,	#8056
    add	x8,	x8,	fp
    ldr	w7,	[x8]

    ldr	w11,	[x10]

    add	w12,	w11,	w7
    str	w12,	[x22]

    b	main_5

main_23:
    movz	w16,	#1
    cmp	w16,	w25
    bgt	main_63

main_25:
    movz	w7,	#1

main_27:
    movz	w5,	#1
    cmp	w5,	w28
    bgt	main_58

main_30:
    sub	w12,	w7,	#1
    movz	w21,	#140
    movz	fp,	#8056
    lsl	w17,	w7,	#3
    movz	w19,	#140
    movz	w6,	#1
    mul	w10,	w12,	w21
    mul	w24,	w7,	w19
    mov	x21,	x17
    mov	x10,	x10
    mov	x23,	x24
    add	x21,	sp,	x21
    add	x10,	sp,	x10
    add	x23,	sp,	x23
    add	x21,	x21,	#16
    add	x10,	x10,	fp
    movz	fp,	#8056
    add	x23,	x23,	fp

main_36:
    lsl	w27,	w6,	#2
    add	w4,	w6,	#1
    sub	w1,	w6,	#1
    add	x26,	x10,	x27
    asr	w17,	w4,	#31
    lsl	w3,	w1,	#2
    ldr	w5,	[x26]

    lsr	w18,	w17,	#31
    add	x2,	x10,	x3
    add	w19,	w4,	w18
    asr	w27,	w19,	#1
    lsl	w0,	w27,	#1
    sub	w22,	w4,	w0
    lsl	w26,	w22,	#2
    add	x24,	x21,	x26
    ldr	w24,	[x24]

    add	w14,	w24,	w5
    ldr	w5,	[x2]

    add	w3,	w5,	w24
    cmp	w14,	w3
    ble	main_52

main_50:
    lsl	w17,	w6,	#2
    add	x16,	x23,	x17
    str	w14,	[x16]

    b	main_54

main_52:
    lsl	w19,	w6,	#2
    add	x18,	x23,	x19
    str	w3,	[x18]


main_54:
    cmp	w4,	w28
    bgt	main_58

main_35:
    mov	w6,	w4
    b	main_36

main_58:
    add	w7,	w7,	#1
    cmp	w7,	w25
    ble	main_27

main_63:
    movz	w10,	#140
    movz	fp,	#8056
    movz	w0,	#0
    mul	w1,	w25,	w10
    mov	x14,	x1
    movz	w1,	#0
    add	x14,	sp,	x14
    add	x14,	x14,	fp

main_65:
    cmp	w1,	w28
    bgt	main_75

main_69:
    lsl	w16,	w1,	#2
    add	x15,	x14,	x16
    ldr	w17,	[x15]

    cmp	w0,	w17
    add	w1,	w1,	#1
    csel	w0,	w17,	w0,	lt
    b	main_65

main_75:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#17696
    movk	fp,	#2,	lsl #16
    add	sp, sp, fp
    ret


