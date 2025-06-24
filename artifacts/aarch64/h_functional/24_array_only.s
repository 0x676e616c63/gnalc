.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl inc_impl
inc_impl:
inc_impl_2:
    sub	sp, sp, #48
    stp	x26, x27, [sp, #0]
    stp	x28, fp, [sp, #16]
    str	lr, [sp, 32]

    cmp	w1,	#0
    bne	inc_impl_8

inc_impl_4:
    ldr	w2,	[x0]

    add	w3,	w2,	#1
    str	w3,	[x0]

    b	inc_impl_19

inc_impl_8:
    ldr	w27,	[x0]

    sub	w1,	w1,	#1
    lsl	w28,	w27,	#1
    str	w28,	[x0]

    cmp	w1,	#0
    bne	inc_impl_16

inc_impl_14:
    add	w9,	w28,	#1
    str	w9,	[x0]

    b	inc_impl_19

inc_impl_16:
    lsl	w26,	w28,	#1
    sub	w1,	w1,	#1
    str	w26,	[x0]

    bl	inc_impl

inc_impl_19:
    ldp	x26, x27, [sp, #0]
    ldp	x28, fp, [sp, #16]
    ldr	lr, [sp, 32]

    add	sp, sp, #48
    ret


.globl add_impl
add_impl:
add_impl_3:
    sub	sp, sp, #64
    stp	x19, x20, [sp, #0]
    stp	x21, x25, [sp, #16]
    stp	x27, x28, [sp, #32]
    stp	fp, lr, [sp, #48]
    
    cmp	w2,	#0
    bne	add_impl_11

add_impl_5:
    ldr	w25,	[x0]

    ldr	w19,	[x1]

    add	w20,	w19,	w25
    str	w20,	[x0]

    b	add_impl_24

add_impl_11:
    ldr	w4,	[x0]

    sub	w5,	w2,	#1
    lsl	w14,	w4,	#1
    str	w14,	[x0]

    cmp	w5,	#0
    bne	add_impl_21

add_impl_17:
    ldr	w27,	[x1]

    add	w28,	w27,	w14
    str	w28,	[x0]

    b	add_impl_24

add_impl_21:
    lsl	w21,	w14,	#1
    sub	w2,	w5,	#1
    str	w21,	[x0]

    bl	add_impl

add_impl_24:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x25, [sp, #16]
    ldp	x27, x28, [sp, #32]
    ldp	fp, lr, [sp, #48]
    
    add	sp, sp, #64
    ret


.globl sub_impl
sub_impl:
sub_impl_3:
    sub	sp, sp, #48
    stp	x19, x23, [sp, #0]
    stp	x24, x28, [sp, #16]
    stp	fp, lr, [sp, #32]
    
    cmp	w2,	#0
    bne	sub_impl_11

sub_impl_5:
    ldr	w18,	[x0]

    ldr	w10,	[x1]

    sub	w11,	w18,	w10
    str	w11,	[x0]

    b	sub_impl_24

sub_impl_11:
    ldr	w23,	[x0]

    sub	w24,	w2,	#1
    lsl	w8,	w23,	#1
    str	w8,	[x0]

    cmp	w24,	#0
    bne	sub_impl_21

sub_impl_17:
    ldr	w18,	[x1]

    sub	w19,	w8,	w18
    str	w19,	[x0]

    b	sub_impl_24

sub_impl_21:
    lsl	w28,	w8,	#1
    sub	w2,	w24,	#1
    str	w28,	[x0]

    bl	sub_impl

sub_impl_24:
    ldp	x19, x23, [sp, #0]
    ldp	x24, x28, [sp, #16]
    ldp	fp, lr, [sp, #32]
    
    add	sp, sp, #48
    ret


.globl main
main:
main_0:
    sub	sp, sp, #48
    stp	fp, lr, [sp, #0]
    
    movz	w1,	#0
    movz	w2,	#4
    add	x0,	sp,	#24
    bl	memset
    movz	w18,	#0
    movz	w21,	#65535
    add	x27,	sp,	#16
    movk	w21,	#65535,	lsl #16
    add	x26,	x27,	#4
    str	w21,	[x27]

    str	w18,	[x26]

    bl	getint
    add	x21,	sp,	#28
    mov	w24,	w0
    bl	getint
    mov	w23,	w0
    mov	x0,	x27
    str	w23,	[x21]

    bl	getarray
    add	x25,	sp,	#24
    add	x20,	sp,	#24
    add	x22,	sp,	#32

main_16:
    cmp	w23,	#0
    beq	main_32

main_18:
    ldr	w1,	[x27]

    str	w1,	[x22]

    ldr	w28,	[x20]


main_21:
    ldr	w19,	[x22]

    cmp	w19,	#5
    bge	main_26

main_24:
    mov	w0,	w28
    bl	putint
    mov	w0,	w19
    bl	putint
    mov	w0,	w23
    bl	putint
    ldr	w0,	[x27]

    bl	putint
    mov	w2,	w24
    mov	x1,	x21
    mov	x0,	x27
    bl	add_impl
    mov	w2,	w24
    mov	x1,	x21
    mov	x0,	x22
    bl	add_impl
    mov	w2,	w24
    mov	x1,	x21
    mov	x0,	x27
    bl	sub_impl
    b	main_21

main_26:
    mov	x0,	x25
    mov	w1,	w24
    bl	inc_impl
    mov	w2,	w24
    mov	x1,	x27
    mov	x0,	x20
    bl	add_impl
    ldr	w14,	[x20]

    ldr	w7,	[x26]

    cmp	w14,	w7
    bne	main_16

main_32:
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #48
    ret


