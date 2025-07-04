.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data
.global __HELLO
.align	2
__HELLO:
.type __HELLO, %object
    .word	87
    .word	101
    .word	108
    .word	99
    .word	111
    .word	109
    .word	101
    .word	32
    .word	116
    .word	111
    .word	32
    .word	116
    .word	104
    .word	101
    .word	32
    .word	74
    .word	97
    .word	112
    .word	97
    .word	114
    .word	105
    .word	32
    .word	80
    .word	97
    .word	114
    .word	107
    .word	33
    .word	10
    .zero	288

.global N4__mE___
.align	2
N4__mE___:
.type N4__mE___, %object
    .word	83
    .word	97
    .word	97
    .word	98
    .word	97
    .word	114
    .word	117
    .zero	172
    .word	75
    .word	97
    .word	98
    .word	97
    .word	110
    .zero	180
    .word	72
    .word	97
    .word	115
    .word	104
    .word	105
    .word	98
    .word	105
    .word	114
    .word	111
    .word	107
    .word	111
    .word	117
    .zero	152
    .word	65
    .word	114
    .word	97
    .word	105
    .word	103
    .word	117
    .word	109
    .word	97
    .zero	168
    .word	72
    .word	117
    .word	110
    .word	98
    .word	111
    .word	114
    .word	117
    .word	116
    .word	111
    .word	32
    .word	80
    .word	101
    .word	110
    .word	103
    .word	105
    .word	110
    .zero	136
    .word	84
    .word	97
    .word	105
    .word	114
    .word	105
    .word	107
    .word	117
    .word	32
    .word	79
    .word	111
    .word	107
    .word	97
    .word	109
    .word	105
    .zero	144

.global saY_HeI10_To
.align	2
saY_HeI10_To:
.type saY_HeI10_To, %object
    .word	32
    .word	115
    .word	97
    .word	121
    .word	115
    .word	32
    .word	104
    .word	101
    .word	108
    .word	108
    .word	111
    .word	32
    .word	116
    .word	111
    .word	32
    .zero	100

.global RET
.align	2
RET:
.type RET, %object
    .word	10
    .zero	16


.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #1808
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#20
    adrp	x1, :got:RET
    add	x0,	sp,	#576
    ldr	x1, [x1, #:got_lo12:RET]
    bl	memcpy
    movz	w2,	#160
    adrp	x1, :got:saY_HeI10_To
    add	x0,	sp,	#16
    ldr	x1, [x1, #:got_lo12:saY_HeI10_To]
    bl	memcpy
    movz	w2,	#1200
    adrp	x1, :got:N4__mE___
    add	x0,	sp,	#596
    ldr	x1, [x1, #:got_lo12:N4__mE___]
    bl	memcpy
    movz	w2,	#400
    adrp	x1, :got:__HELLO
    add	x0,	sp,	#176
    ldr	x1, [x1, #:got_lo12:__HELLO]
    bl	memcpy
    movz	w20,	#0
    add	x25,	sp,	#176

main_6:
    lsl	w13,	w20,	#2
    add	x12,	x25,	x13
    ldr	w0,	[x12]

    cmp	w0,	#0
    bne	main_11

main_13:
    add	x27,	sp,	#16
    add	x25,	sp,	#576
    movz	w21,	#0

main_17:
    movz	w13,	#6
    movz	w28,	#6
    sdiv	w3,	w21,	w13
    sdiv	w17,	w21,	w28
    lsl	w2,	w17,	#1
    add	w12,	w2,	w17,	lsl #2
    sub	w26,	w21,	w12
    cmp	w3,	w26
    beq	main_60

main_22:
    movz	w19,	#200
    movz	w22,	#0
    mul	w6,	w3,	w19
    mov	x23,	x6
    add	x23,	sp,	x23
    add	x23,	x23,	#596

main_25:
    lsl	w4,	w22,	#2
    add	x3,	x23,	x4
    ldr	w0,	[x3]

    cmp	w0,	#0
    bne	main_30

main_32:
    movz	w23,	#0

main_33:
    lsl	w17,	w23,	#2
    add	x16,	x27,	x17
    ldr	w0,	[x16]

    cmp	w0,	#0
    bne	main_38

main_40:
    movz	w23,	#200
    movz	w20,	#0
    mul	w13,	w26,	w23
    mov	x26,	x13
    add	x26,	sp,	x26
    add	x26,	x26,	#596

main_43:
    lsl	w0,	w20,	#2
    add	x28,	x26,	x0
    ldr	w0,	[x28]

    cmp	w0,	#0
    bne	main_48

main_50:
    movz	w22,	#0

main_51:
    lsl	w28,	w22,	#2
    add	x26,	x25,	x28
    ldr	w0,	[x26]

    cmp	w0,	#0
    bne	main_56

main_60:
    lsl	w3,	w21,	#0
    add	w10,	w3,	w21,	lsl #4
    add	w10,	w10,	#23
    asr	w16,	w10,	#31
    lsr	w17,	w16,	#27
    add	w18,	w10,	w17
    asr	w6,	w18,	#5
    lsl	w7,	w6,	#5
    sub	w21,	w10,	w7
    cmp	w21,	#0
    bne	main_17

main_65:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #1808
    ret


main_56:
    bl	putch
    add	w22,	w22,	#1
    b	main_51

main_48:
    bl	putch
    add	w20,	w20,	#1
    b	main_43

main_38:
    bl	putch
    add	w23,	w23,	#1
    b	main_33

main_30:
    bl	putch
    add	w22,	w22,	#1
    b	main_25

main_11:
    bl	putch
    add	w20,	w20,	#1
    b	main_6

