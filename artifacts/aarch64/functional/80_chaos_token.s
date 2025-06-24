.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global __HELLO
.align	2
__HELLO:
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
    .word	10
    .zero	16


.text

.globl main
main:
main_0:
    sub	sp, sp, #1808
    stp	fp, lr, [sp, #0]
    
    movz	w2,	#20
    adrp	x1, :got:RET
    add	x0,	sp,	#16
    ldr	x1, [x1, #:got_lo12:RET]
    bl	memcpy
    movz	w2,	#160
    adrp	x1, :got:saY_HeI10_To
    add	x0,	sp,	#36
    ldr	x1, [x1, #:got_lo12:saY_HeI10_To]
    bl	memcpy
    movz	w2,	#1200
    adrp	x1, :got:N4__mE___
    add	x0,	sp,	#596
    ldr	x1, [x1, #:got_lo12:N4__mE___]
    bl	memcpy
    movz	w2,	#400
    adrp	x1, :got:__HELLO
    add	x0,	sp,	#196
    ldr	x1, [x1, #:got_lo12:__HELLO]
    bl	memcpy
    movz	w20,	#0
    add	x25,	sp,	#196

main_6:
    lsl	w13,	w20,	#2
    add	x12,	x25,	x13
    ldr	w0,	[x12]

    cmp	w0,	#0
    beq	main_13

main_11:
    bl	putch
    add	w20,	w20,	#1
    b	main_6

main_13:
    add	x28,	sp,	#36
    add	x26,	sp,	#16
    movz	w21,	#0

main_17:
    movz	w13,	#6
    movz	w27,	#6
    sdiv	w4,	w21,	w13
    sdiv	w17,	w21,	w27
    lsl	w2,	w17,	#1
    add	w12,	w2,	w17,	lsl #2
    sub	w23,	w21,	w12
    cmp	w4,	w23
    beq	main_60

main_22:
    movz	w19,	#200
    movz	w27,	#0
    mul	w7,	w4,	w19
    mov	x24,	x7
    add	x24,	sp,	x24
    add	x24,	x24,	#596

main_25:
    lsl	w5,	w27,	#2
    add	x4,	x24,	x5
    ldr	w0,	[x4]

    cmp	w0,	#0
    beq	main_32

main_30:
    bl	putch
    add	w27,	w27,	#1
    b	main_25

main_32:
    movz	w19,	#0

main_33:
    lsl	w20,	w19,	#2
    add	x18,	x28,	x20
    ldr	w0,	[x18]

    cmp	w0,	#0
    beq	main_40

main_38:
    bl	putch
    add	w19,	w19,	#1
    b	main_33

main_40:
    movz	w17,	#200
    movz	w24,	#0
    mul	w16,	w23,	w17
    mov	x20,	x16
    add	x20,	sp,	x20
    add	x20,	x20,	#596

main_43:
    lsl	w3,	w24,	#2
    add	x2,	x20,	x3
    ldr	w0,	[x2]

    cmp	w0,	#0
    beq	main_50

main_48:
    bl	putch
    add	w24,	w24,	#1
    b	main_43

main_50:
    movz	w25,	#0

main_51:
    lsl	w3,	w25,	#2
    add	x2,	x26,	x3
    ldr	w0,	[x2]

    cmp	w0,	#0
    beq	main_60

main_56:
    bl	putch
    add	w25,	w25,	#1
    b	main_51

main_60:
    lsl	w3,	w21,	#0
    add	w15,	w3,	w21,	lsl #4
    add	w15,	w15,	#23
    asr	w16,	w15,	#31
    lsr	w17,	w16,	#27
    add	w18,	w15,	w17
    asr	w6,	w18,	#5
    lsl	w7,	w6,	#5
    sub	w21,	w15,	w7
    cmp	w21,	#0
    bne	main_17

main_65:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #1808
    ret


