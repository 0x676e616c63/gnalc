.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl func
func:
func_9:
    sub	sp, sp, #96
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, fp, [sp, #64]
    str	lr, [sp, 80]

    mov	w27,	w0
    mov	x20,	x1
    mov	w24,	w2
    mov	x21,	x3
    mov	w25,	w4
    mov	w23,	w5
    mov	x22,	x6
    ldr	w19,	[sp, #96]

    movz	w26,	#0

func_10:
    cmp	w26,	#10
    bge	func_18

func_13:
    movz	w0,	#236
    mul	w0,	w27,	w0
    add	x0,	x20,	x0
    lsl	w18,	w26,	#2
    add	x0,	x0,	x18
    ldr	w0,	[x0]

    bl	putint
    add	w26,	w26,	#1
    b	func_10

func_18:
    movz	w0,	#10
    bl	putch
    lsl	w0,	w24,	#2
    add	x0,	x21,	x0
    ldr	w0,	[x0]

    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w20,	#0

func_21:
    cmp	w19,	#10
    bge	func_32

func_25:
    lsl	w0,	w19,	#2
    add	x18,	x22,	x0
    movz	w0,	#18373
    movk	w0,	#3273,	lsl #16
    smull	x0,	w20,	w0

    lsr	x0,	x0,	#32
    add	w0,	w0,	w20
    asr	w0,	w0,	#11
    add	w0,	w0,	w20,	lsr #31
    str	w0,	[x18]

    lsl	w0,	w19,	#2
    add	x0,	x22,	x0
    ldr	w0,	[x0]

    bl	putint
    add	w19,	w19,	#1
    movz	w0,	#63339
    movk	w0,	#1,	lsl #16
    mul	w20,	w19,	w0
    movz	w0,	#32
    bl	putch
    b	func_21

func_32:
    movz	w0,	#10
    bl	putch
    add	w0,	w25,	w23
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, fp, [sp, #64]
    ldr	lr, [sp, 80]

    add	sp, sp, #96
    ret


.globl main
main:
main_0:
    movz	fp,	#28896
    sub	sp, sp, fp
    stp	fp, lr, [sp, #16]
    
    add	x0,	sp,	#32
    movz	w1,	#0
    movz	w2,	#16348
    bl	memset
    movz	fp,	#16380
    add	x0,	sp,	fp
    movz	w1,	#0
    movz	w2,	#12508
    bl	memset
    movz	fp,	#4588
    add	x0,	sp,	fp
    add	x1,	x0,	#4
    movz	w0,	#6
    str	w0,	[x1]

    movz	fp,	#4588
    add	x0,	sp,	fp
    add	x1,	x0,	#12
    movz	w0,	#7
    str	w0,	[x1]

    movz	fp,	#4588
    add	x0,	sp,	fp
    add	x1,	x0,	#16
    movz	w0,	#4
    str	w0,	[x1]

    movz	fp,	#4588
    add	x0,	sp,	fp
    add	x1,	x0,	#28
    movz	w0,	#9
    str	w0,	[x1]

    movz	fp,	#4588
    add	x0,	sp,	fp
    add	x1,	x0,	#44
    movz	w0,	#11
    str	w0,	[x1]

    movz	fp,	#17796
    add	x0,	sp,	fp
    add	x1,	x0,	#4
    movz	w0,	#1
    str	w0,	[x1]

    movz	fp,	#17796
    add	x0,	sp,	fp
    add	x1,	x0,	#8
    movz	w0,	#2
    str	w0,	[x1]

    movz	fp,	#17796
    add	x0,	sp,	fp
    add	x1,	x0,	#12
    movz	w0,	#3
    str	w0,	[x1]

    movz	fp,	#17796
    add	x0,	sp,	fp
    add	x1,	x0,	#36
    movz	w0,	#9
    str	w0,	[x1]

    movz	fp,	#4588
    add	x0,	sp,	fp
    add	x0,	x0,	#4
    ldr	w0,	[x0]

    movz	fp,	#4588
    add	x1,	sp,	fp
    add	x1,	x1,	#12
    ldr	w2,	[x1]

    movz	fp,	#4588
    add	x3,	sp,	fp
    movz	fp,	#17796
    add	x1,	sp,	fp
    add	x1,	x1,	#12
    ldr	w4,	[x1]

    movz	fp,	#17796
    add	x1,	sp,	fp
    ldr	w5,	[x1]

    movz	fp,	#17796
    add	x6,	sp,	fp
    movz	fp,	#24404
    add	x1,	sp,	fp
    add	x1,	x1,	#16
    ldr	w7,	[x1]

    movz	fp,	#28416
    add	x1,	sp,	fp
    add	x1,	x1,	#72
    ldr	w18,	[x1]

    movz	fp,	#16380
    add	x1,	sp,	fp
    str	w18,	[sp, #0]

    bl	func
    lsl	w18,	w0,	#0
    add	w0,	w18,	w0,	lsl #1
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #16]
    
    movz	fp,	#28896
    add	sp, sp, fp
    ret


