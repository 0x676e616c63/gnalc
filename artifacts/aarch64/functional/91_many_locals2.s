.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    bl	getint
    mov	w20,	w0

main_3:
    cmp	w20,	#5
    beq	main_2

main_6:
    movz	w0,	#0
    bl	putint
    movz	w0,	#1
    bl	putint
    movz	w0,	#2
    bl	putint
    movz	w0,	#3
    bl	putint
    movz	w0,	#4
    bl	putint
    movz	w0,	#5
    bl	putint
    movz	w0,	#6
    bl	putint
    movz	w0,	#7
    bl	putint
    movz	w0,	#8
    bl	putint
    movz	w0,	#9
    bl	putint
    movz	w0,	#10
    bl	putint
    movz	w0,	#11
    bl	putint
    movz	w0,	#12
    bl	putint
    movz	w0,	#13
    bl	putint
    movz	w0,	#14
    bl	putint
    movz	w0,	#15
    bl	putint
    movz	w0,	#16
    bl	putint
    movz	w0,	#17
    bl	putint
    movz	w0,	#18
    bl	putint
    movz	w0,	#19
    bl	putint
    movz	w0,	#20
    bl	putint
    movz	w0,	#21
    bl	putint
    movz	w0,	#22
    bl	putint
    movz	w0,	#23
    bl	putint
    movz	w0,	#24
    bl	putint
    movz	w0,	#25
    bl	putint
    movz	w0,	#26
    bl	putint
    movz	w0,	#27
    bl	putint
    movz	w0,	#28
    bl	putint
    movz	w0,	#29
    bl	putint
    movz	w0,	#10
    bl	putch
    mov	w0,	w20
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#25
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


main_2:
    movz	w20,	#6
    b	main_3

