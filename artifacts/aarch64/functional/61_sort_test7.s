.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global buf
.align	2
buf:
.type buf, %object
    .zero	800

.data

.text

.globl merge_sort
.align 2
.p2align 4,,11
.type merge_sort, %function
merge_sort:
merge_sort_2:
    sub	sp, sp, #96
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, fp, [sp, #64]
    str	lr, [sp, 80]

    mov	w23,	w1
    mov	w27,	w0
    add	w3,	w27,	#1
    cmp	w3,	w23
    bge	merge_sort_67

merge_sort_5:
    add	w24,	w23,	w27
    mov	w0,	w27
    asr	w18,	w24,	#31
    lsr	w19,	w18,	#31
    add	w20,	w24,	w19
    asr	w25,	w20,	#1
    mov	w1,	w25
    bl	merge_sort
    mov	w1,	w23
    mov	w0,	w25
    bl	merge_sort
    mov	w6,	w25
    mov	w14,	w27
    mov	w26,	w27
    adrp	x0, :got:buf
    adrp	x17, :got:buf
    ldr	x17, [x17, #:got_lo12:buf]
    ldr	x0, [x0, #:got_lo12:buf]
    add	x1,	x0,	#400

merge_sort_10:
    cmp	w14,	w25
    bge	merge_sort_35

merge_sort_15:
    cmp	w6,	w23
    blt	merge_sort_17

merge_sort_35:
    cmp	w14,	w25
    blt	merge_sort_39

merge_sort_46:
    cmp	w6,	w23
    blt	merge_sort_50

merge_sort_57:
    cmp	w27,	w23
    blt	merge_sort_60

merge_sort_67:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, fp, [sp, #64]
    ldr	lr, [sp, 80]

    add	sp, sp, #96
    ret


merge_sort_60:
    lsl	w8,	w27,	#2
    lsl	w10,	w27,	#2
    add	w27,	w27,	#1
    add	x9,	x1,	x10
    add	x12,	x17,	x8
    ldr	w11,	[x9]

    str	w11,	[x12]

    b	merge_sort_57

merge_sort_50:
    lsl	w10,	w26,	#2
    lsl	w12,	w6,	#2
    add	w26,	w26,	#1
    add	w6,	w6,	#1
    add	x11,	x17,	x12
    add	x18,	x1,	x10
    ldr	w13,	[x11]

    str	w13,	[x18]

    b	merge_sort_46

merge_sort_39:
    lsl	w19,	w26,	#2
    lsl	w21,	w14,	#2
    add	w26,	w26,	#1
    add	w14,	w14,	#1
    add	x20,	x17,	x21
    add	x13,	x1,	x19
    ldr	w22,	[x20]

    str	w22,	[x13]

    b	merge_sort_35

merge_sort_17:
    lsl	w2,	w14,	#2
    lsl	w5,	w6,	#2
    add	x0,	x17,	x2
    add	x4,	x17,	x5
    ldr	w16,	[x0]

    ldr	w4,	[x4]

    cmp	w16,	w4
    blt	merge_sort_23

merge_sort_26:
    lsl	w10,	w26,	#2
    add	w6,	w6,	#1
    add	x9,	x1,	x10
    str	w4,	[x9]

    b	merge_sort_29

merge_sort_23:
    lsl	w13,	w26,	#2
    add	w14,	w14,	#1
    add	x12,	x1,	x13
    str	w16,	[x12]


merge_sort_29:
    add	w26,	w26,	#1
    b	merge_sort_10

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    adrp	x21, :got:buf
    ldr	x21, [x21, #:got_lo12:buf]
    mov	x0,	x21
    bl	getarray
    mov	w28,	w0
    mov	w1,	w28
    movz	w0,	#0
    bl	merge_sort
    mov	x1,	x21
    mov	w0,	w28
    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


