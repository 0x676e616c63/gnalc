.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global buf
.align	2
buf:
    .zero	800


.text

.globl merge_sort
merge_sort:
merge_sort_2:
    sub	sp, sp, #96
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x24, x25, [sp, #32]
    stp	x26, x27, [sp, #48]
    stp	x28, fp, [sp, #64]
    str	lr, [sp, 80]

    mov	w24,	w1
    mov	w19,	w0
    add	w3,	w19,	#1
    cmp	w3,	w24
    bge	merge_sort_67

merge_sort_5:
    add	w25,	w24,	w19
    mov	w0,	w19
    asr	w18,	w25,	#31
    lsr	w20,	w18,	#31
    add	w21,	w25,	w20
    asr	w26,	w21,	#1
    mov	w1,	w26
    bl	merge_sort
    mov	w1,	w24
    mov	w0,	w26
    bl	merge_sort
    mov	w4,	w26
    mov	w28,	w19
    adrp	x0, :got:buf
    mov	w9,	w19
    adrp	x17, :got:buf
    ldr	x17, [x17, #:got_lo12:buf]
    ldr	x0, [x0, #:got_lo12:buf]
    add	x1,	x0,	#400

merge_sort_10:
    cmp	w9,	w26
    bge	merge_sort_35

merge_sort_15:
    cmp	w4,	w24
    bge	merge_sort_35

merge_sort_17:
    lsl	w27,	w9,	#2
    lsl	w3,	w4,	#2
    add	x25,	x17,	x27
    add	x2,	x17,	x3
    ldr	w16,	[x25]

    ldr	w27,	[x2]

    cmp	w16,	w27
    bge	merge_sort_26

merge_sort_23:
    lsl	w8,	w28,	#2
    add	w9,	w9,	#1
    add	x7,	x1,	x8
    str	w16,	[x7]

    b	merge_sort_29

merge_sort_26:
    lsl	w12,	w28,	#2
    add	w4,	w4,	#1
    add	x11,	x1,	x12
    str	w27,	[x11]


merge_sort_29:
    add	w28,	w28,	#1
    b	merge_sort_10

merge_sort_35:
    cmp	w9,	w26
    bge	merge_sort_46

merge_sort_39:
    lsl	w18,	w28,	#2
    lsl	w21,	w9,	#2
    add	w28,	w28,	#1
    add	w9,	w9,	#1
    add	x20,	x17,	x21
    add	x13,	x1,	x18
    ldr	w22,	[x20]

    str	w22,	[x13]

    b	merge_sort_35

merge_sort_46:
    cmp	w4,	w24
    bge	merge_sort_57

merge_sort_50:
    lsl	w27,	w28,	#2
    lsl	w2,	w4,	#2
    add	w28,	w28,	#1
    add	w4,	w4,	#1
    add	x0,	x17,	x2
    add	x11,	x1,	x27
    ldr	w3,	[x0]

    str	w3,	[x11]

    b	merge_sort_46

merge_sort_57:
    cmp	w19,	w24
    bge	merge_sort_67

merge_sort_60:
    lsl	w11,	w19,	#2
    lsl	w13,	w19,	#2
    add	w19,	w19,	#1
    add	x12,	x1,	x13
    add	x20,	x17,	x11
    ldr	w14,	[x12]

    str	w14,	[x20]

    b	merge_sort_57

merge_sort_67:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x24, x25, [sp, #32]
    ldp	x26, x27, [sp, #48]
    ldp	x28, fp, [sp, #64]
    ldr	lr, [sp, 80]

    add	sp, sp, #96
    ret


.globl main
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


