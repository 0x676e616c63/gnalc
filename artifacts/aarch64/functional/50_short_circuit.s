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
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w26,	w0
    cmp	w26,	#10
    bgt	main_3

main_4:
    movz	w26,	#0
    b	main_5

main_3:
    mov	w0,	w26
    bl	putint

main_5:
    bl	getint
    cmp	w0,	#11
    ble	main_17

main_9:
    add	w26,	w0,	w26
    mov	w0,	w26
    bl	putint

main_17:
    bl	getint
    cmp	w0,	#99
    ble	main_29

main_21:
    add	w26,	w0,	w26
    mov	w0,	w26
    bl	putint

main_29:
    bl	getint
    cmp	w0,	#100
    ble	main_41

main_33:
    add	w26,	w0,	w26
    mov	w0,	w26
    bl	putint

main_41:
    add	w21,	w26,	#99
    mov	w0,	w21
    bl	putint
    cmp	w21,	#0
    bne	main_47

main_45:
    movz	w0,	#100
    bl	putint

main_47:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


