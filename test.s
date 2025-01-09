.arch armv7ve
.text
.arm
.globl main
main:
Lentry:
    push {r7, lr}
    sub sp, sp, #0
    add r7, sp, #0
    mov r10, r0
    mov r0, #72
    bl putch
    mov r0, r10
    mov r10, r0
    mov r0, #101
    bl putch
    mov r0, r10
    mov r10, r0
    mov r0, #108
    bl putch
    mov r0, r10
    mov r10, r0
    mov r0, #108
    bl putch
    mov r0, r10
    mov r10, r0
    mov r0, #111
    bl putch
    mov r0, r10
    mov r10, r0
    mov r0, #44
    bl putch
    mov r0, r10
    mov r10, r0
    mov r0, #32
    bl putch
    mov r0, r10
    mov r10, r0
    mov r0, #87
    bl putch
    mov r0, r10
    mov r10, r0
    mov r0, #111
    bl putch
    mov r0, r10
    mov r10, r0
    mov r0, #114
    bl putch
    mov r0, r10
    mov r10, r0
    mov r0, #108
    bl putch
    mov r0, r10
    mov r10, r0
    mov r0, #100
    bl putch
    mov r0, r10
    mov r10, r0
    mov r0, #33
    bl putch
    mov r0, r10
    mov r10, r0
    mov r0, #10
    bl putch
    mov r0, r10
    mov r0, #0
    add r7, r7, #0
    mov sp, r7
    pop {r7, pc}
