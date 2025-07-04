.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.global head
.align	2
head:
.type head, %object
    .zero	40000000

.global next
.align	2
next:
.type next, %object
    .zero	40000000

.global nextvalue
.align	2
nextvalue:
.type nextvalue, %object
    .zero	40000000

.global key
.align	2
key:
.type key, %object
    .zero	40000000

.global value
.align	2
value:
.type value, %object
    .zero	40000000

.global keys
.align	2
keys:
.type keys, %object
    .zero	40000000

.global values
.align	2
values:
.type values, %object
    .zero	40000000

.global requests
.align	2
requests:
.type requests, %object
    .zero	40000000

.global ans
.align	2
ans:
.type ans, %object
    .zero	40000000

.data

.text

.globl main
.align 2
.p2align 4,,11
.type main, %function
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w21,	w0
    adrp	x0, :got:keys
    ldr	x0, [x0, #:got_lo12:keys]
    bl	getarray
    mov	w25,	w0
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
    cmp	w19,	w25
    bge	main_57

main_9:
    movz	w18,	#0
    movz	w4,	#0

main_11:
    lsl	w24,	w18,	#2
    adrp	x8, :got:keys
    lsl	w10,	w18,	#2
    adrp	x2, :got:values
    adrp	x16, :got:head
    ldr	x8, [x8, #:got_lo12:keys]
    add	x6,	x8,	x24
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
    beq	main_22

main_28:
    mov	w12,	w9

main_29:
    cmp	w12,	#0
    bne	main_32

main_45:
    add	w4,	w4,	#1
    adrp	x17, :got:next
    adrp	x2, :got:key
    ldr	x17, [x17, #:got_lo12:next]
    lsl	w20,	w4,	#2
    lsl	w24,	w4,	#2
    add	x15,	x17,	x24
    movz	w17,	#0
    adrp	x24, :got:value
    str	w9,	[x15]

    adrp	x9, :got:nextvalue
    str	w4,	[x5]

    lsl	w5,	w4,	#2
    ldr	x2, [x2, #:got_lo12:key]
    add	x0,	x2,	x20
    str	w27,	[x0]

    lsl	w27,	w4,	#2
    ldr	x24, [x24, #:got_lo12:value]
    add	x22,	x24,	x5
    str	w13,	[x22]

    ldr	x9, [x9, #:got_lo12:nextvalue]
    add	x26,	x9,	x27
    str	w17,	[x26]

    b	main_51

main_32:
    lsl	w2,	w12,	#2
    adrp	x15, :got:key
    ldr	x15, [x15, #:got_lo12:key]
    add	x11,	x15,	x2
    ldr	w16,	[x11]

    cmp	w16,	w27
    bne	main_42

main_36:
    add	w4,	w4,	#1
    adrp	x22, :got:nextvalue
    lsl	w24,	w12,	#2
    adrp	x14, :got:nextvalue
    adrp	x19, :got:value
    ldr	x22, [x22, #:got_lo12:nextvalue]
    lsl	w1,	w4,	#2
    lsl	w11,	w4,	#2
    ldr	x14, [x14, #:got_lo12:nextvalue]
    add	x10,	x22,	x11
    add	x23,	x14,	x24
    ldr	w15,	[x23]

    str	w15,	[x10]

    str	w4,	[x23]

    ldr	x19, [x19, #:got_lo12:value]
    add	x16,	x19,	x1
    str	w13,	[x16]

    b	main_51

main_42:
    lsl	w8,	w12,	#2
    adrp	x0, :got:next
    ldr	x0, [x0, #:got_lo12:next]
    add	x24,	x0,	x8
    ldr	w12,	[x24]

    b	main_29

main_22:
    add	w4,	w4,	#1
    adrp	x11, :got:key
    movz	w23,	#0
    adrp	x19, :got:nextvalue
    movz	w20,	#0
    lsl	w10,	w4,	#2
    lsl	w15,	w4,	#2
    lsl	w7,	w4,	#2
    str	w4,	[x5]

    ldr	x11, [x11, #:got_lo12:key]
    lsl	w5,	w4,	#2
    add	x9,	x11,	x5
    adrp	x5, :got:value
    str	w27,	[x9]

    ldr	x5, [x5, #:got_lo12:value]
    add	x2,	x5,	x15
    adrp	x15, :got:next
    str	w13,	[x2]

    ldr	x15, [x15, #:got_lo12:next]
    add	x6,	x15,	x7
    str	w23,	[x6]

    ldr	x19, [x19, #:got_lo12:nextvalue]
    add	x9,	x19,	x10
    str	w20,	[x9]


main_51:
    add	w18,	w18,	#1
    cmp	w18,	w25
    blt	main_11

main_57:
    movz	w27,	#0
    cmp	w27,	w28
    bge	main_98

main_59:
    movz	w8,	#0

main_61:
    lsl	w18,	w8,	#2
    adrp	x12, :got:ans
    lsl	w1,	w8,	#2
    adrp	x22, :got:requests
    adrp	x0, :got:head
    ldr	x12, [x12, #:got_lo12:ans]
    ldr	x22, [x22, #:got_lo12:requests]
    add	x24,	x12,	x18
    add	x19,	x22,	x1
    ldr	w9,	[x19]

    ldr	x0, [x0, #:got_lo12:head]
    sdiv	w1,	w9,	w21
    msub	w25,	w1,	w21,	w9

    lsl	w7,	w25,	#2
    add	x26,	x0,	x7
    ldr	w4,	[x26]


main_69:
    cmp	w4,	#0
    bne	main_72

main_90:
    movz	w27,	#0
    b	main_92

main_72:
    lsl	w6,	w4,	#2
    adrp	x14, :got:key
    ldr	x14, [x14, #:got_lo12:key]
    add	x12,	x14,	x6
    ldr	w15,	[x12]

    cmp	w15,	w9
    bne	main_87

main_76:
    movz	w27,	#0

main_77:
    cmp	w4,	#0
    bne	main_81

main_92:
    str	w27,	[x24]

    add	w8,	w8,	#1
    cmp	w8,	w28
    blt	main_61
    b	main_98

main_81:
    lsl	w1,	w4,	#2
    adrp	x16, :got:value
    lsl	w20,	w4,	#2
    ldr	x16, [x16, #:got_lo12:value]
    add	x14,	x16,	x1
    adrp	x1, :got:nextvalue
    ldr	w17,	[x14]

    ldr	x1, [x1, #:got_lo12:nextvalue]
    add	w27,	w17,	w27
    add	x26,	x1,	x20
    ldr	w4,	[x26]

    b	main_77

main_87:
    lsl	w4,	w4,	#2
    adrp	x25, :got:next
    ldr	x25, [x25, #:got_lo12:next]
    add	x22,	x25,	x4
    ldr	w4,	[x22]

    b	main_69

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


