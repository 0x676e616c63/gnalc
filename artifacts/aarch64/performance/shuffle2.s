.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global head
.align	2
head:
    .zero	40000000

.global next
.align	2
next:
    .zero	40000000

.global nextvalue
.align	2
nextvalue:
    .zero	40000000

.global key
.align	2
key:
    .zero	40000000

.global value
.align	2
value:
    .zero	40000000

.global keys
.align	2
keys:
    .zero	40000000

.global values
.align	2
values:
    .zero	40000000

.global requests
.align	2
requests:
    .zero	40000000

.global ans
.align	2
ans:
    .zero	40000000


.text

.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w21,	w0
    adrp	x0, :got:keys
    ldr	x0, [x0, #:got_lo12:keys]
    bl	getarray
    mov	w23,	w0
    adrp	x0, :got:values
    ldr	x0, [x0, #:got_lo12:values]
    bl	getarray
    adrp	x0, :got:requests
    ldr	x0, [x0, #:got_lo12:requests]
    bl	getarray
    mov	w28,	w0
    movz	w0,	#78
    bl	_sysy_starttime
    movz	w19,	#0
    cmp	w19,	w23
    bge	main_57

main_9:
    movz	w18,	#0
    movz	w4,	#0

main_11:
    lsl	w25,	w18,	#2
    adrp	x8, :got:keys
    lsl	w10,	w18,	#2
    adrp	x2, :got:values
    adrp	x16, :got:head
    ldr	x8, [x8, #:got_lo12:keys]
    add	x6,	x8,	x25
    ldr	w27,	[x6]

    sdiv	w22,	w27,	w21
    ldr	x2, [x2, #:got_lo12:values]
    msub	w12,	w22,	w21,	w27

    add	x0,	x2,	x10
    lsl	w7,	w12,	#2
    ldr	w13,	[x0]

    ldr	x16, [x16, #:got_lo12:head]
    add	x5,	x16,	x7
    ldr	w9,	[x5]

    cmp	w9,	#0
    bne	main_28

main_22:
    add	w4,	w4,	#1
    adrp	x25, :got:key
    adrp	x19, :got:value
    movz	w20,	#0
    adrp	x8, :got:nextvalue
    movz	w17,	#0
    lsl	w26,	w4,	#2
    lsl	w14,	w4,	#2
    lsl	w0,	w4,	#2
    str	w4,	[x5]

    adrp	x5, :got:next
    ldr	x25, [x25, #:got_lo12:key]
    add	x22,	x25,	x14
    str	w27,	[x22]

    lsl	w22,	w4,	#2
    ldr	x19, [x19, #:got_lo12:value]
    add	x16,	x19,	x0
    str	w13,	[x16]

    ldr	x5, [x5, #:got_lo12:next]
    add	x19,	x5,	x22
    str	w20,	[x19]

    ldr	x8, [x8, #:got_lo12:nextvalue]
    add	x25,	x8,	x26
    str	w17,	[x25]

    b	main_51

main_28:
    mov	w12,	w9

main_29:
    cmp	w12,	#0
    beq	main_45

main_32:
    lsl	w2,	w12,	#2
    adrp	x15, :got:key
    ldr	x15, [x15, #:got_lo12:key]
    add	x11,	x15,	x2
    ldr	w16,	[x11]

    cmp	w16,	w27
    beq	main_36

main_42:
    lsl	w20,	w12,	#2
    adrp	x12, :got:next
    ldr	x12, [x12, #:got_lo12:next]
    add	x10,	x12,	x20
    ldr	w12,	[x10]

    b	main_29

main_36:
    add	w4,	w4,	#1
    adrp	x27, :got:nextvalue
    lsl	w1,	w12,	#2
    adrp	x19, :got:nextvalue
    adrp	x25, :got:value
    ldr	x27, [x27, #:got_lo12:nextvalue]
    lsl	w6,	w4,	#2
    lsl	w17,	w4,	#2
    ldr	x19, [x19, #:got_lo12:nextvalue]
    add	x22,	x27,	x17
    add	x0,	x19,	x1
    ldr	w20,	[x0]

    str	w20,	[x22]

    str	w4,	[x0]

    ldr	x25, [x25, #:got_lo12:value]
    add	x22,	x25,	x6
    str	w13,	[x22]

    b	main_51

main_45:
    add	w4,	w4,	#1
    adrp	x6, :got:next
    movz	w22,	#0
    ldr	x6, [x6, #:got_lo12:next]
    lsl	w10,	w4,	#2
    lsl	w8,	w4,	#2
    lsl	w19,	w4,	#2
    lsl	w15,	w4,	#2
    add	x3,	x6,	x15
    adrp	x15, :got:key
    str	w9,	[x3]

    str	w4,	[x5]

    ldr	x15, [x15, #:got_lo12:key]
    add	x12,	x15,	x8
    adrp	x8, :got:value
    str	w27,	[x12]

    ldr	x8, [x8, #:got_lo12:value]
    add	x6,	x8,	x19
    adrp	x19, :got:nextvalue
    str	w13,	[x6]

    ldr	x19, [x19, #:got_lo12:nextvalue]
    add	x9,	x19,	x10
    str	w22,	[x9]


main_51:
    add	w18,	w18,	#1
    cmp	w18,	w23
    blt	main_11

main_57:
    movz	w27,	#0
    cmp	w27,	w28
    bge	main_98

main_59:
    movz	w1,	#0

main_61:
    lsl	w18,	w1,	#2
    adrp	x12, :got:ans
    lsl	w2,	w1,	#2
    adrp	x22, :got:requests
    adrp	x0, :got:head
    ldr	x12, [x12, #:got_lo12:ans]
    ldr	x22, [x22, #:got_lo12:requests]
    add	x24,	x12,	x18
    add	x19,	x22,	x2
    ldr	w5,	[x19]

    ldr	x0, [x0, #:got_lo12:head]
    sdiv	w2,	w5,	w21
    msub	w25,	w2,	w21,	w5

    lsl	w8,	w25,	#2
    add	x26,	x0,	x8
    ldr	w11,	[x26]


main_69:
    cmp	w11,	#0
    beq	main_90

main_72:
    lsl	w6,	w11,	#2
    adrp	x14, :got:key
    ldr	x14, [x14, #:got_lo12:key]
    add	x12,	x14,	x6
    ldr	w15,	[x12]

    cmp	w15,	w5
    beq	main_76

main_87:
    lsl	w18,	w11,	#2
    adrp	x11, :got:next
    ldr	x11, [x11, #:got_lo12:next]
    add	x9,	x11,	x18
    ldr	w11,	[x9]

    b	main_69

main_76:
    movz	w27,	#0

main_77:
    cmp	w11,	#0
    beq	main_92

main_81:
    lsl	w4,	w11,	#2
    adrp	x18, :got:value
    lsl	w23,	w11,	#2
    ldr	x18, [x18, #:got_lo12:value]
    add	x16,	x18,	x4
    adrp	x4, :got:nextvalue
    ldr	w19,	[x16]

    ldr	x4, [x4, #:got_lo12:nextvalue]
    add	w27,	w19,	w27
    add	x2,	x4,	x23
    ldr	w11,	[x2]

    b	main_77

main_90:
    movz	w27,	#0

main_92:
    str	w27,	[x24]

    add	w1,	w1,	#1
    cmp	w1,	w28
    blt	main_61

main_98:
    movz	w0,	#90
    bl	_sysy_stoptime
    mov	w0,	w28
    adrp	x1, :got:ans
    ldr	x1, [x1, #:got_lo12:ans]
    bl	putarray
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


