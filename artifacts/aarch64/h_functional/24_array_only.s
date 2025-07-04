.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.bss
.data

.text

.globl inc_impl
.align 2
.p2align 4,,11
.type inc_impl, %function
inc_impl:
inc_impl_2:
    sub	sp, sp, #48
    stp	x22, x24, [sp, #0]
    stp	x26, fp, [sp, #16]
    str	lr, [sp, 32]

    cmp	w1,	#0
    beq	inc_impl_4

inc_impl_8:
    ldr	w24,	[x0]

    sub	w26,	w1,	#1
    lsl	w10,	w24,	#1
    str	w10,	[x0]

    cmp	w26,	#0
    beq	inc_impl_14

inc_impl_16:
    lsl	w22,	w10,	#1
    sub	w1,	w26,	#1
    str	w22,	[x0]

    bl	inc_impl
    b	inc_impl_19

inc_impl_14:
    add	w8,	w10,	#1
    str	w8,	[x0]

    b	inc_impl_19

inc_impl_4:
    ldr	w10,	[x0]

    add	w11,	w10,	#1
    str	w11,	[x0]


inc_impl_19:
    ldp	x22, x24, [sp, #0]
    ldp	x26, fp, [sp, #16]
    ldr	lr, [sp, 32]

    add	sp, sp, #48
    ret


.globl add_impl
.align 2
.p2align 4,,11
.type add_impl, %function
add_impl:
add_impl_3:
    sub	sp, sp, #48
    stp	x22, x24, [sp, #0]
    stp	x25, x27, [sp, #16]
    stp	fp, lr, [sp, #32]
    
    cmp	w2,	#0
    beq	add_impl_5

add_impl_11:
    ldr	w25,	[x0]

    sub	w27,	w2,	#1
    lsl	w8,	w25,	#1
    str	w8,	[x0]

    cmp	w27,	#0
    beq	add_impl_17

add_impl_21:
    lsl	w25,	w8,	#1
    sub	w2,	w27,	#1
    str	w25,	[x0]

    bl	add_impl
    b	add_impl_24

add_impl_17:
    ldr	w24,	[x1]

    add	w25,	w24,	w8
    str	w25,	[x0]

    b	add_impl_24

add_impl_5:
    ldr	w22,	[x0]

    ldr	w1,	[x1]

    add	w2,	w1,	w22
    str	w2,	[x0]


add_impl_24:
    ldp	x22, x24, [sp, #0]
    ldp	x25, x27, [sp, #16]
    ldp	fp, lr, [sp, #32]
    
    add	sp, sp, #48
    ret


.globl sub_impl
.align 2
.p2align 4,,11
.type sub_impl, %function
sub_impl:
sub_impl_3:
    sub	sp, sp, #48
    stp	x19, x20, [sp, #0]
    stp	x21, x28, [sp, #16]
    stp	fp, lr, [sp, #32]
    
    cmp	w2,	#0
    beq	sub_impl_5

sub_impl_11:
    ldr	w18,	[x0]

    sub	w19,	w2,	#1
    lsl	w3,	w18,	#1
    str	w3,	[x0]

    cmp	w19,	#0
    beq	sub_impl_17

sub_impl_21:
    lsl	w20,	w3,	#1
    sub	w2,	w19,	#1
    str	w20,	[x0]

    bl	sub_impl
    b	sub_impl_24

sub_impl_17:
    ldr	w15,	[x1]

    sub	w16,	w3,	w15
    str	w16,	[x0]

    b	sub_impl_24

sub_impl_5:
    ldr	w28,	[x0]

    ldr	w20,	[x1]

    sub	w21,	w28,	w20
    str	w21,	[x0]


sub_impl_24:
    ldp	x19, x20, [sp, #0]
    ldp	x21, x28, [sp, #16]
    ldp	fp, lr, [sp, #32]
    
    add	sp, sp, #48
    ret


.globl main
.align 2
.p2align 4,,11
.type main, %function
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
    add	x24,	sp,	#16
    movk	w21,	#65535,	lsl #16
    str	w21,	[x24]

    add	x21,	x24,	#4
    str	w18,	[x21]

    bl	getint
    add	x22,	sp,	#28
    mov	w19,	w0
    bl	getint
    mov	w26,	w0
    mov	x0,	x24
    str	w26,	[x22]

    bl	getarray
    add	x27,	sp,	#24
    add	x23,	sp,	#24
    add	x20,	sp,	#32

main_16:
    cmp	w26,	#0
    beq	main_32

main_18:
    ldr	w1,	[x24]

    str	w1,	[x20]

    ldr	w28,	[x23]


main_21:
    ldr	w25,	[x20]

    cmp	w25,	#5
    blt	main_24

main_26:
    mov	x0,	x27
    mov	w1,	w19
    bl	inc_impl
    mov	w2,	w19
    mov	x1,	x24
    mov	x0,	x23
    bl	add_impl
    ldr	w13,	[x23]

    ldr	w6,	[x21]

    cmp	w13,	w6
    bne	main_16

main_32:
    movz	w0,	#10
    bl	putch
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #48
    ret


main_24:
    mov	w0,	w28
    bl	putint
    mov	w0,	w25
    bl	putint
    mov	w0,	w26
    bl	putint
    ldr	w0,	[x24]

    bl	putint
    mov	w2,	w19
    mov	x1,	x22
    mov	x0,	x24
    bl	add_impl
    mov	w2,	w19
    mov	x1,	x22
    mov	x0,	x20
    bl	add_impl
    mov	w2,	w19
    mov	x1,	x22
    mov	x0,	x24
    bl	sub_impl
    b	main_21

