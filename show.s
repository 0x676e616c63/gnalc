.arch armv7ve
.data
    .align 4
    .global a
    a:
        .word 1
    .global b
    b:
        .word 1
        .word 2
    .global c
    c:
        .word 1
        .word 2
        .word 3
        .word 4
    .global d
    d:
        .zero 4
    .global e
    e:
        .zero 8
    .global f
    f:
        .zero 24
.text
.arm
.globl main
main:
Lentry:
    push {r7, lr}
    sub sp, sp, #0
    add r7, sp, #0
    movw r10, #:lower16:a
    movt r10, #:upper16:a
    ldr r9, [r10, #0]
    movw r10, #:lower16:d
    movt r10, #:upper16:d
    str r9, [r10, #0]
    movw r10, #:lower16:c
    movt r10, #:upper16:c
    ldr r9, [r10, #8]
    movw r10, #:lower16:a
    movt r10, #:upper16:a
    str r9, [r10, #0]
    mov r0, #0
    add r7, r7, #0
    mov sp, r7
    pop {r7, pc}
