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
    movz	fp,	#17696
    movk	fp,	#2,	lsl #16
    sub	sp, sp, fp
    stp	fp, lr, [sp, #0]
    
    movz	w1,	#0
    movz	w2,	#9628
    movz	fp,	#8056
    movk	w2,	#2,	lsl #16
    add	x0,	sp,	fp
    bl	memset
    movz	w1,	#0
    movz	w2,	#8040
    add	x0,	sp,	#16
    bl	memset
    bl	getint
    mov	w26,	w0
    bl	getint
    movz	w24,	#1
    mov	w20,	w0

main_5:
    cmp	w24,	w26
    ble	main_8

main_23:
    movz	w9,	#1
    cmp	w9,	w26
    bgt	main_63

main_25:
    movz	w8,	#1

main_27:
    movz	w27,	#1
    cmp	w27,	w20
    bgt	main_58

main_30:
    sub	w21,	w8,	#1
    movz	w1,	#140
    movz	fp,	#8056
    lsl	w25,	w8,	#3
    movz	w28,	#140
    movz	w5,	#1
    mul	w18,	w21,	w1
    mov	x25,	x25
    mul	w3,	w8,	w28
    mov	x15,	x18
    add	x25,	sp,	x25
    mov	x0,	x3
    add	x15,	sp,	x15
    add	x0,	sp,	x0
    add	x25,	x25,	#16
    add	x15,	x15,	fp
    movz	fp,	#8056
    add	x0,	x0,	fp

main_36:
    lsl	w4,	w5,	#2
    add	w13,	w5,	#1
    sub	w6,	w5,	#1
    add	x3,	x15,	x4
    asr	w14,	w13,	#31
    lsl	w9,	w6,	#2
    ldr	w11,	[x3]

    lsr	w16,	w14,	#31
    add	x7,	x15,	x9
    add	w17,	w13,	w16
    asr	w18,	w17,	#1
    lsl	w19,	w18,	#1
    sub	w28,	w13,	w19
    lsl	w2,	w28,	#2
    add	x1,	x25,	x2
    ldr	w22,	[x1]

    ldr	w10,	[x7]

    add	w4,	w22,	w11
    add	w6,	w10,	w22
    cmp	w4,	w6
    bgt	main_50

main_54:
    lsl	w23,	w5,	#2
    add	x22,	x0,	x23
    str	w6,	[x22]

    b	main_52

main_50:
    lsl	w27,	w5,	#2
    add	x24,	x0,	x27
    str	w4,	[x24]


main_52:
    cmp	w13,	w20
    ble	main_35

main_58:
    add	w8,	w8,	#1
    cmp	w8,	w26
    ble	main_27
    b	main_63

main_35:
    mov	w5,	w13
    b	main_36

main_63:
    movz	w22,	#140
    movz	fp,	#8056
    movz	w23,	#0
    movz	w0,	#0
    mul	w11,	w26,	w22
    mov	x18,	x11
    add	x18,	sp,	x18
    add	x18,	x18,	fp

main_65:
    cmp	w23,	w20
    ble	main_69

main_75:
    ldp	fp, lr, [sp, #0]
    
    movz	fp,	#17696
    movk	fp,	#2,	lsl #16
    add	sp, sp, fp
    ret


main_69:
    lsl	w25,	w23,	#2
    add	x24,	x18,	x25
    ldr	w26,	[x24]

    cmp	w0,	w26
    add	w23,	w23,	#1
    csel	w0,	w26,	w0,	lt
    b	main_65

main_8:
    bl	getint
    movz	w1,	#140
    movz	fp,	#8056
    movz	w2,	#1
    lsl	w10,	w24,	#3
    sub	w13,	w24,	#1
    asr	w7,	w0,	#31
    mul	w14,	w24,	w1
    mov	x22,	x10
    lsr	w8,	w7,	#31
    add	w24,	w24,	#1
    mov	x28,	x14
    add	x22,	sp,	x22
    add	w9,	w0,	w8
    add	x28,	sp,	x28
    add	x22,	x22,	#16
    asr	w25,	w9,	#1
    add	x28,	x28,	fp
    movz	fp,	#8056
    lsl	w27,	w25,	#1
    sub	w5,	w0,	w27
    movz	w27,	#140
    lsl	w12,	w5,	#2
    mul	w25,	w13,	w27
    mov	x27,	x25
    add	x17,	x22,	x12
    add	x27,	sp,	x27
    str	w2,	[x17]

    add	x27,	x27,	fp
    add	x2,	x22,	#4
    ldr	w5,	[x27]

    ldr	w3,	[x2]

    add	w4,	w3,	w5
    str	w4,	[x28]

    b	main_5

