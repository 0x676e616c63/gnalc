.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data
.global memo.lut.fib
.align	2
memo.lut.fib:
    .zero	524288


.text

.globl fib
fib:
fib_1:
    sub	sp, sp, #1344
    stp	x19, x20, [sp, #0]
    stp	x21, x22, [sp, #16]
    stp	x23, x24, [sp, #32]
    stp	x25, x26, [sp, #48]
    stp	x27, x28, [sp, #64]
    stp	fp, lr, [sp, #80]
    
    movz	x6,	#40763
    movz	x17,	#65535
    movz	x7,	#40763
    mov	w14,	w0
    adrp	x15, :got:memo.lut.fib
    movk	x6,	#1117,	lsl #16
    movk	x7,	#1117,	lsl #16
    lsr	w0,	w14,	#16
    eor	w25,	w14,	w0
    mul	w26,	w25,	w7
    lsr	w3,	w26,	#16
    eor	w0,	w26,	w3
    mul	w0,	w0,	w6
    lsr	w7,	w0,	#16
    eor	w16,	w0,	w7
    str	w16,	[sp, #152]

    ldr	w16,	[sp, #152]

    ldr	x15, [x15, #:got_lo12:memo.lut.fib]
    and	w8,	w16,	w17
    lsl	w9,	w8,	#3
    lsl	w5,	w9,	#0
    add	x9,	x15,	x5
    str	x9,	[sp, #144]

    ldr	x5,	[sp, #144]

    str	x5,	[sp, #136]

    ldr	x6,	[sp, #136]

    ldr	w10,	[x6]

    ldr	x11,	[sp, #144]

    add	x2,	x11,	#8
    cmp	w10,	#0
    beq	fib_25

fib_17:
    ldr	w15,	[x2]

    ldr	w19,	[sp, #152]

    cmp	w15,	w19
    bne	fib_27

fib_21:
    ldr	x12,	[sp, #144]

    add	x1,	x12,	#4
    ldr	w0,	[x1]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #1344
    ret


fib_27:
    str	x2,	[sp, #128]

    b	fib_28

fib_25:
    str	x2,	[sp, #128]


fib_28:
    cmp	w14,	#2
    ble	fib_1891

fib_31:
    asr	w25,	w14,	#31
    movz	w23,	#0
    lsr	w0,	w25,	#31
    add	w28,	w14,	w0
    asr	w24,	w28,	#1
    lsl	w25,	w24,	#1
    sub	w20,	w14,	w25
    str	w20,	[sp, #104]

    ldr	w20,	[sp, #104]

    sub	w19,	w23,	w20
    str	w19,	[sp, #604]

    ldr	w0,	[sp, #104]

    cmp	w0,	#0
    ldr	w20,	[sp, #604]

    asr	w24,	w14,	#31
    ldr	w22,	[sp, #104]

    lsr	w25,	w24,	#31
    csel	w0,	w20,	w22,	lt
    str	w0,	[sp, #480]

    add	w19,	w14,	w25
    asr	w22,	w19,	#1
    movz	w19,	#0
    asr	w28,	w22,	#31
    lsr	w0,	w28,	#31
    add	w18,	w22,	w0
    asr	w28,	w18,	#1
    lsl	w0,	w28,	#1
    sub	w0,	w22,	w0
    str	w0,	[sp, #112]

    ldr	w24,	[sp, #112]

    sub	w26,	w19,	w24
    str	w26,	[sp, #620]

    ldr	w24,	[sp, #112]

    cmp	w24,	#0
    ldr	w27,	[sp, #620]

    asr	w25,	w22,	#31
    movz	w21,	#0
    ldr	w24,	[sp, #112]

    lsr	w26,	w25,	#31
    csel	w18,	w27,	w24,	lt
    str	w18,	[sp, #484]

    add	w23,	w22,	w26
    asr	w25,	w23,	#1
    asr	w0,	w25,	#31
    lsr	w18,	w0,	#31
    add	w0,	w25,	w18
    asr	w26,	w0,	#1
    lsl	w27,	w26,	#1
    sub	w0,	w25,	w27
    str	w0,	[sp, #116]

    ldr	w20,	[sp, #116]

    sub	w0,	w21,	w20
    str	w0,	[sp, #636]

    ldr	w19,	[sp, #116]

    cmp	w19,	#0
    ldr	w18,	[sp, #636]

    asr	w19,	w25,	#31
    ldr	w24,	[sp, #116]

    lsr	w21,	w19,	#31
    csel	w24,	w18,	w24,	lt
    str	w24,	[sp, #976]

    add	w23,	w25,	w21
    asr	w24,	w23,	#1
    asr	w25,	w24,	#31
    lsr	w0,	w25,	#31
    add	w26,	w24,	w0
    movz	w0,	#0
    asr	w22,	w26,	#1
    lsl	w23,	w22,	#1
    sub	w21,	w24,	w23
    str	w21,	[sp, #124]

    ldr	w26,	[sp, #124]

    sub	w22,	w0,	w26
    str	w22,	[sp, #648]

    ldr	w23,	[sp, #124]

    cmp	w23,	#0
    ldr	w23,	[sp, #648]

    movz	w25,	#0
    asr	w0,	w24,	#31
    ldr	w27,	[sp, #124]

    csel	w21,	w23,	w27,	lt
    lsr	w18,	w0,	#31
    str	w21,	[sp, #972]

    add	w0,	w24,	w18
    asr	w18,	w0,	#1
    asr	w26,	w18,	#31
    lsr	w19,	w26,	#31
    add	w19,	w18,	w19
    asr	w26,	w19,	#1
    lsl	w19,	w26,	#1
    sub	w26,	w18,	w19
    str	w26,	[sp, #120]

    ldr	w24,	[sp, #120]

    sub	w24,	w25,	w24
    str	w24,	[sp, #660]

    ldr	w20,	[sp, #120]

    cmp	w20,	#0
    asr	w26,	w18,	#31
    ldr	w25,	[sp, #660]

    ldr	w0,	[sp, #120]

    lsr	w19,	w26,	#31
    csel	w20,	w25,	w0,	lt
    str	w20,	[sp, #204]

    add	w0,	w18,	w19
    asr	w24,	w0,	#1
    movz	w0,	#0
    asr	w18,	w24,	#31
    lsr	w19,	w18,	#31
    add	w23,	w24,	w19
    asr	w18,	w23,	#1
    lsl	w19,	w18,	#1
    sub	w25,	w24,	w19
    str	w25,	[sp, #108]

    ldr	w23,	[sp, #108]

    sub	w0,	w0,	w23
    str	w0,	[sp, #672]

    ldr	w0,	[sp, #108]

    cmp	w0,	#0
    asr	w23,	w24,	#31
    ldr	w20,	[sp, #672]

    ldr	w25,	[sp, #108]

    lsr	w0,	w23,	#31
    csel	w25,	w20,	w25,	lt
    str	w25,	[sp, #180]

    add	w0,	w24,	w0
    asr	w19,	w0,	#1
    asr	w0,	w19,	#31
    lsr	w18,	w0,	#31
    add	w20,	w19,	w18
    asr	w0,	w20,	#1
    lsl	w18,	w0,	#1
    movz	w0,	#0
    sub	w23,	w19,	w18
    str	w23,	[sp, #100]

    ldr	w18,	[sp, #100]

    sub	w26,	w0,	w18
    str	w26,	[sp, #664]

    ldr	w25,	[sp, #100]

    cmp	w25,	#0
    ldr	w0,	[sp, #664]

    ldr	w18,	[sp, #100]

    csel	w22,	w0,	w18,	lt
    asr	w0,	w19,	#31
    str	w22,	[sp, #236]

    lsr	w18,	w0,	#31
    add	w0,	w19,	w18
    asr	w18,	w0,	#1
    str	w18,	[sp, #184]

    ldr	w19,	[sp, #184]

    asr	w0,	w19,	#31
    ldr	w19,	[sp, #184]

    lsr	w25,	w0,	#31
    ldr	w21,	[sp, #184]

    add	w0,	w19,	w25
    asr	w0,	w0,	#1
    lsl	w25,	w0,	#1
    sub	w22,	w21,	w25
    movz	w21,	#0
    str	w22,	[sp, #668]

    ldr	w25,	[sp, #668]

    sub	w23,	w21,	w25
    str	w23,	[sp, #652]

    ldr	w24,	[sp, #668]

    cmp	w24,	#0
    movz	w21,	#0
    ldr	w22,	[sp, #652]

    ldr	w25,	[sp, #668]

    csel	w25,	w22,	w25,	lt
    str	w25,	[sp, #212]

    ldr	w0,	[sp, #184]

    ldr	w24,	[sp, #184]

    asr	w0,	w0,	#31
    lsr	w0,	w0,	#31
    add	w25,	w24,	w0
    asr	w25,	w25,	#1
    str	w25,	[sp, #188]

    ldr	w26,	[sp, #188]

    ldr	w27,	[sp, #188]

    asr	w0,	w26,	#31
    ldr	w28,	[sp, #188]

    lsr	w22,	w0,	#31
    add	w25,	w27,	w22
    asr	w0,	w25,	#1
    lsl	w22,	w0,	#1
    sub	w25,	w28,	w22
    str	w25,	[sp, #656]

    ldr	w18,	[sp, #656]

    sub	w26,	w21,	w18
    str	w26,	[sp, #640]

    ldr	w0,	[sp, #656]

    cmp	w0,	#0
    movz	w24,	#0
    ldr	w0,	[sp, #640]

    ldr	w20,	[sp, #656]

    csel	w21,	w0,	w20,	lt
    str	w21,	[sp, #208]

    ldr	w0,	[sp, #188]

    ldr	w18,	[sp, #188]

    asr	w25,	w0,	#31
    lsr	w22,	w25,	#31
    add	w25,	w18,	w22
    asr	w20,	w25,	#1
    asr	w25,	w20,	#31
    lsr	w18,	w25,	#31
    add	w25,	w20,	w18
    asr	w25,	w25,	#1
    lsl	w18,	w25,	#1
    sub	w25,	w20,	w18
    str	w25,	[sp, #644]

    ldr	w21,	[sp, #644]

    sub	w26,	w24,	w21
    str	w26,	[sp, #628]

    ldr	w0,	[sp, #644]

    cmp	w0,	#0
    ldr	w21,	[sp, #628]

    ldr	w18,	[sp, #644]

    csel	w25,	w21,	w18,	lt
    asr	w18,	w20,	#31
    str	w25,	[sp, #240]

    lsr	w18,	w18,	#31
    add	w25,	w20,	w18
    asr	w27,	w25,	#1
    str	w27,	[sp, #468]

    ldr	w28,	[sp, #468]

    asr	w0,	w28,	#31
    ldr	w25,	[sp, #468]

    ldr	w26,	[sp, #468]

    lsr	w0,	w0,	#31
    add	w0,	w25,	w0
    asr	w0,	w0,	#1
    lsl	w0,	w0,	#1
    sub	w25,	w26,	w0
    str	w25,	[sp, #632]

    ldr	w23,	[sp, #632]

    movz	w25,	#0
    sub	w26,	w25,	w23
    str	w26,	[sp, #616]

    ldr	w0,	[sp, #632]

    cmp	w0,	#0
    ldr	w24,	[sp, #616]

    movz	w23,	#0
    ldr	w20,	[sp, #632]

    csel	w26,	w24,	w20,	lt
    str	w26,	[sp, #720]

    ldr	w19,	[sp, #468]

    ldr	w18,	[sp, #468]

    asr	w0,	w19,	#31
    lsr	w0,	w0,	#31
    add	w25,	w18,	w0
    asr	w24,	w25,	#1
    asr	w18,	w24,	#31
    lsr	w18,	w18,	#31
    add	w18,	w24,	w18
    asr	w18,	w18,	#1
    lsl	w18,	w18,	#1
    sub	w0,	w24,	w18
    str	w0,	[sp, #624]

    ldr	w21,	[sp, #624]

    sub	w0,	w23,	w21
    str	w0,	[sp, #608]

    ldr	w18,	[sp, #624]

    cmp	w18,	#0
    ldr	w21,	[sp, #608]

    asr	w18,	w24,	#31
    ldr	w19,	[sp, #624]

    lsr	w18,	w18,	#31
    csel	w26,	w21,	w19,	lt
    str	w26,	[sp, #500]

    add	w25,	w24,	w18
    asr	w0,	w25,	#1
    movz	w25,	#0
    str	w0,	[sp, #472]

    ldr	w23,	[sp, #472]

    ldr	w22,	[sp, #472]

    asr	w0,	w23,	#31
    ldr	w23,	[sp, #472]

    lsr	w0,	w0,	#31
    add	w0,	w22,	w0
    asr	w0,	w0,	#1
    lsl	w0,	w0,	#1
    sub	w21,	w23,	w0
    str	w21,	[sp, #612]

    ldr	w24,	[sp, #612]

    sub	w22,	w25,	w24
    str	w22,	[sp, #596]

    ldr	w23,	[sp, #612]

    cmp	w23,	#0
    ldr	w23,	[sp, #596]

    ldr	w24,	[sp, #612]

    csel	w20,	w23,	w24,	lt
    str	w20,	[sp, #516]

    movz	w24,	#0
    ldr	w26,	[sp, #472]

    mov	w21,	w24
    asr	w0,	w26,	#31
    ldr	w18,	[sp, #472]

    lsr	w0,	w0,	#31
    add	w25,	w18,	w0
    asr	w0,	w25,	#1
    asr	w19,	w0,	#31
    lsr	w19,	w19,	#31
    add	w19,	w0,	w19
    asr	w19,	w19,	#1
    lsl	w19,	w19,	#1
    sub	w18,	w0,	w19
    str	w18,	[sp, #600]

    ldr	w18,	[sp, #600]

    sub	w24,	w21,	w18
    str	w24,	[sp, #588]

    ldr	w19,	[sp, #600]

    cmp	w19,	#0
    asr	w19,	w0,	#31
    ldr	w26,	[sp, #588]

    movz	w21,	#0
    ldr	w20,	[sp, #600]

    lsr	w19,	w19,	#31
    csel	w18,	w26,	w20,	lt
    str	w18,	[sp, #544]

    add	w25,	w0,	w19
    asr	w25,	w25,	#1
    str	w25,	[sp, #488]

    ldr	w26,	[sp, #488]

    ldr	w24,	[sp, #488]

    asr	w25,	w26,	#31
    ldr	w26,	[sp, #488]

    lsr	w25,	w25,	#31
    add	w25,	w24,	w25
    asr	w25,	w25,	#1
    lsl	w25,	w25,	#1
    sub	w25,	w26,	w25
    str	w25,	[sp, #592]

    ldr	w0,	[sp, #592]

    sub	w20,	w21,	w0
    str	w20,	[sp, #580]

    ldr	w25,	[sp, #592]

    cmp	w25,	#0
    ldr	w0,	[sp, #580]

    movz	w21,	#0
    ldr	w26,	[sp, #592]

    csel	w22,	w0,	w26,	lt
    str	w22,	[sp, #564]

    ldr	w0,	[sp, #488]

    asr	w25,	w0,	#31
    ldr	w28,	[sp, #488]

    lsr	w25,	w25,	#31
    add	w25,	w28,	w25
    asr	w24,	w25,	#1
    str	w24,	[sp, #244]

    ldr	w25,	[sp, #244]

    ldr	w19,	[sp, #244]

    asr	w25,	w25,	#31
    ldr	w20,	[sp, #244]

    lsr	w25,	w25,	#31
    add	w25,	w19,	w25
    asr	w25,	w25,	#1
    lsl	w25,	w25,	#1
    sub	w24,	w20,	w25
    str	w24,	[sp, #584]

    ldr	w25,	[sp, #584]

    sub	w0,	w21,	w25
    str	w0,	[sp, #576]

    ldr	w0,	[sp, #584]

    cmp	w0,	#0
    ldr	w26,	[sp, #576]

    ldr	w25,	[sp, #584]

    csel	w0,	w26,	w25,	lt
    str	w0,	[sp, #560]

    ldr	w18,	[sp, #480]

    cmp	w18,	#0
    cset	w25,	ne
    cmp	w25,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w25,	ne
    cmp	w25,	#0
    cset	w25,	ne
    cmp	w25,	#0
    cset	w21,	ne
    mov	w24,	w21
    str	w24,	[sp, #568]

    ldr	w19,	[sp, #480]

    cmp	w19,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w25,	ne
    mov	w19,	w25
    str	w19,	[sp, #948]

    ldr	w0,	[sp, #484]

    cmp	w0,	#0
    cset	w25,	ne
    cmp	w25,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w24,	ne
    mov	w26,	w24
    str	w26,	[sp, #96]

    ldr	w20,	[sp, #948]

    cmp	w20,	#0
    ldr	w26,	[sp, #96]

    cset	w24,	ne
    mov	w0,	w24
    cmp	w26,	#0
    movz	w19,	#1
    csel	w26,	w19,	w0,	ne
    str	w26,	[sp, #888]

    ldr	w21,	[sp, #948]

    cmp	w21,	#0
    cset	w25,	ne
    str	w25,	[sp, #760]

    ldr	w0,	[sp, #96]

    cmp	w0,	#0
    ldr	w19,	[sp, #760]

    movz	w25,	#0
    csel	w0,	w19,	w25,	ne
    cmp	w0,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w25,	ne
    ldr	w0,	[sp, #888]

    cmp	w0,	#0
    movz	w0,	#0
    csel	w23,	w25,	w0,	ne
    str	w23,	[sp, #552]

    ldr	w23,	[sp, #484]

    cmp	w23,	#0
    cset	w24,	ne
    mov	w21,	w24
    str	w21,	[sp, #1160]

    ldr	w0,	[sp, #948]

    cmp	w0,	#0
    ldr	w18,	[sp, #96]

    cset	w20,	ne
    cmp	w18,	#0
    movz	w26,	#0
    csel	w0,	w20,	w26,	ne
    cmp	w0,	#0
    cset	w21,	ne
    ldr	w23,	[sp, #1160]

    mov	w26,	w21
    cmp	w23,	#0
    movz	w20,	#1
    csel	w27,	w20,	w26,	ne
    str	w27,	[sp, #956]

    ldr	w28,	[sp, #976]

    cmp	w28,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w21,	eq
    cmp	w21,	#0
    cset	w24,	ne
    mov	w20,	w24
    str	w20,	[sp, #960]

    ldr	w28,	[sp, #956]

    cmp	w28,	#0
    ldr	w19,	[sp, #960]

    cset	w21,	ne
    mov	w0,	w21
    cmp	w19,	#0
    movz	w21,	#1
    csel	w24,	w21,	w0,	ne
    str	w24,	[sp, #952]

    ldr	w0,	[sp, #956]

    cmp	w0,	#0
    cset	w21,	ne
    str	w21,	[sp, #716]

    ldr	w0,	[sp, #960]

    cmp	w0,	#0
    ldr	w18,	[sp, #716]

    movz	w21,	#0
    csel	w25,	w18,	w21,	ne
    cmp	w25,	#0
    cset	w21,	eq
    cmp	w21,	#0
    cset	w21,	ne
    mov	w25,	w21
    ldr	w21,	[sp, #952]

    cmp	w21,	#0
    movz	w24,	#0
    csel	w23,	w25,	w24,	ne
    str	w23,	[sp, #528]

    ldr	w0,	[sp, #976]

    cmp	w0,	#0
    cset	w22,	ne
    mov	w0,	w22
    str	w0,	[sp, #288]

    ldr	w18,	[sp, #956]

    cmp	w18,	#0
    ldr	w21,	[sp, #960]

    cset	w19,	ne
    cmp	w21,	#0
    movz	w0,	#0
    csel	w21,	w19,	w0,	ne
    cmp	w21,	#0
    ldr	w18,	[sp, #288]

    cset	w24,	ne
    mov	w0,	w24
    cmp	w18,	#0
    movz	w22,	#1
    csel	w25,	w22,	w0,	ne
    str	w25,	[sp, #964]

    ldr	w24,	[sp, #972]

    cmp	w24,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w23,	ne
    mov	w18,	w23
    str	w18,	[sp, #968]

    ldr	w26,	[sp, #964]

    cmp	w26,	#0
    cset	w23,	ne
    ldr	w18,	[sp, #968]

    mov	w0,	w23
    cmp	w18,	#0
    movz	w18,	#1
    csel	w28,	w18,	w0,	ne
    str	w28,	[sp, #944]

    ldr	w27,	[sp, #964]

    cmp	w27,	#0
    ldr	w18,	[sp, #968]

    cset	w23,	ne
    mov	w28,	w23
    cmp	w18,	#0
    movz	w24,	#0
    csel	w26,	w28,	w24,	ne
    cmp	w26,	#0
    cset	w24,	eq
    cmp	w24,	#0
    ldr	w0,	[sp, #944]

    cset	w24,	ne
    cmp	w0,	#0
    movz	w28,	#0
    csel	w24,	w24,	w28,	ne
    str	w24,	[sp, #492]

    ldr	w25,	[sp, #972]

    cmp	w25,	#0
    cset	w25,	ne
    mov	w28,	w25
    str	w28,	[sp, #1144]

    ldr	w28,	[sp, #964]

    cmp	w28,	#0
    cset	w0,	ne
    ldr	w19,	[sp, #968]

    cmp	w19,	#0
    movz	w25,	#0
    csel	w20,	w0,	w25,	ne
    cmp	w20,	#0
    ldr	w25,	[sp, #1144]

    cset	w23,	ne
    mov	w28,	w23
    cmp	w25,	#0
    movz	w25,	#1
    csel	w0,	w25,	w28,	ne
    str	w0,	[sp, #216]

    ldr	w18,	[sp, #204]

    cmp	w18,	#0
    cset	w23,	ne
    cmp	w23,	#0
    cset	w28,	eq
    cmp	w28,	#0
    cset	w20,	ne
    str	w20,	[sp, #292]

    ldr	w18,	[sp, #216]

    cmp	w18,	#0
    ldr	w21,	[sp, #292]

    cset	w23,	ne
    mov	w0,	w23
    cmp	w21,	#0
    movz	w28,	#1
    csel	w20,	w28,	w0,	ne
    str	w20,	[sp, #192]

    ldr	w19,	[sp, #216]

    cmp	w19,	#0
    ldr	w21,	[sp, #292]

    cset	w25,	ne
    mov	w28,	w25
    cmp	w21,	#0
    movz	w25,	#0
    csel	w25,	w28,	w25,	ne
    cmp	w25,	#0
    cset	w23,	eq
    cmp	w23,	#0
    ldr	w23,	[sp, #192]

    cset	w28,	ne
    mov	w20,	w28
    cmp	w23,	#0
    movz	w25,	#0
    csel	w23,	w20,	w25,	ne
    str	w23,	[sp, #748]

    ldr	w19,	[sp, #204]

    cmp	w19,	#0
    cset	w25,	ne
    mov	w21,	w25
    str	w21,	[sp, #1132]

    ldr	w20,	[sp, #216]

    cmp	w20,	#0
    ldr	w23,	[sp, #292]

    cset	w28,	ne
    mov	w21,	w28
    cmp	w23,	#0
    movz	w0,	#0
    csel	w26,	w21,	w0,	ne
    cmp	w26,	#0
    cset	w0,	ne
    ldr	w18,	[sp, #1132]

    mov	w21,	w0
    cmp	w18,	#0
    movz	w28,	#1
    csel	w0,	w28,	w21,	ne
    str	w0,	[sp, #932]

    ldr	w27,	[sp, #180]

    cmp	w27,	#0
    cset	w25,	ne
    cmp	w25,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w20,	ne
    mov	w19,	w20
    str	w19,	[sp, #1148]

    ldr	w18,	[sp, #932]

    cmp	w18,	#0
    cset	w23,	ne
    ldr	w0,	[sp, #1148]

    mov	w21,	w23
    cmp	w0,	#0
    movz	w23,	#1
    csel	w23,	w23,	w21,	ne
    str	w23,	[sp, #196]

    ldr	w19,	[sp, #932]

    cmp	w19,	#0
    ldr	w18,	[sp, #1148]

    cset	w28,	ne
    mov	w21,	w28
    cmp	w18,	#0
    movz	w20,	#0
    csel	w25,	w21,	w20,	ne
    cmp	w25,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w25,	ne
    mov	w18,	w25
    ldr	w25,	[sp, #196]

    cmp	w25,	#0
    movz	w0,	#0
    csel	w28,	w18,	w0,	ne
    str	w28,	[sp, #700]

    ldr	w28,	[sp, #180]

    cmp	w28,	#0
    cset	w0,	ne
    mov	w25,	w0
    str	w25,	[sp, #1140]

    ldr	w20,	[sp, #932]

    cmp	w20,	#0
    ldr	w20,	[sp, #1148]

    cset	w23,	ne
    mov	w27,	w23
    cmp	w20,	#0
    movz	w21,	#0
    csel	w23,	w27,	w21,	ne
    cmp	w23,	#0
    ldr	w24,	[sp, #1140]

    cset	w26,	ne
    mov	w20,	w26
    cmp	w24,	#0
    movz	w0,	#1
    csel	w0,	w0,	w20,	ne
    str	w0,	[sp, #936]

    ldr	w0,	[sp, #236]

    cmp	w0,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w26,	ne
    mov	w24,	w26
    str	w24,	[sp, #284]

    ldr	w23,	[sp, #936]

    cmp	w23,	#0
    ldr	w24,	[sp, #284]

    cset	w25,	ne
    mov	w19,	w25
    cmp	w24,	#0
    movz	w28,	#1
    csel	w0,	w28,	w19,	ne
    str	w0,	[sp, #220]

    ldr	w24,	[sp, #936]

    cmp	w24,	#0
    cset	w0,	ne
    mov	w18,	w0
    ldr	w0,	[sp, #284]

    cmp	w0,	#0
    movz	w26,	#0
    csel	w28,	w18,	w26,	ne
    cmp	w28,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w26,	ne
    mov	w18,	w26
    ldr	w26,	[sp, #220]

    cmp	w26,	#0
    movz	w20,	#0
    csel	w26,	w18,	w20,	ne
    str	w26,	[sp, #200]

    ldr	w18,	[sp, #236]

    cmp	w18,	#0
    cset	w28,	ne
    mov	w18,	w28
    str	w18,	[sp, #1128]

    ldr	w25,	[sp, #936]

    cmp	w25,	#0
    ldr	w24,	[sp, #284]

    cset	w0,	ne
    mov	w27,	w0
    cmp	w24,	#0
    movz	w23,	#0
    csel	w26,	w27,	w23,	ne
    cmp	w26,	#0
    ldr	w27,	[sp, #1128]

    cset	w0,	ne
    mov	w21,	w0
    cmp	w27,	#0
    movz	w26,	#1
    csel	w25,	w26,	w21,	ne
    str	w25,	[sp, #224]

    ldr	w26,	[sp, #212]

    cmp	w26,	#0
    cset	w25,	ne
    cmp	w25,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w28,	ne
    mov	w25,	w28
    str	w25,	[sp, #296]

    ldr	w26,	[sp, #224]

    cmp	w26,	#0
    cset	w25,	ne
    mov	w19,	w25
    ldr	w25,	[sp, #296]

    cmp	w25,	#0
    movz	w28,	#1
    csel	w24,	w28,	w19,	ne
    str	w24,	[sp, #464]

    ldr	w27,	[sp, #224]

    cmp	w27,	#0
    ldr	w26,	[sp, #296]

    cset	w0,	ne
    mov	w19,	w0
    cmp	w26,	#0
    movz	w0,	#0
    csel	w0,	w19,	w0,	ne
    cmp	w0,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w25,	ne
    ldr	w22,	[sp, #464]

    mov	w0,	w25
    cmp	w22,	#0
    movz	w28,	#0
    csel	w20,	w0,	w28,	ne
    str	w20,	[sp, #172]

    ldr	w27,	[sp, #212]

    cmp	w27,	#0
    cset	w0,	ne
    mov	w27,	w0
    str	w27,	[sp, #1124]

    ldr	w28,	[sp, #224]

    cmp	w28,	#0
    ldr	w26,	[sp, #296]

    cset	w23,	ne
    mov	w28,	w23
    cmp	w26,	#0
    movz	w25,	#0
    csel	w19,	w28,	w25,	ne
    cmp	w19,	#0
    cset	w0,	ne
    mov	w26,	w0
    ldr	w0,	[sp, #1124]

    cmp	w0,	#0
    movz	w0,	#1
    csel	w18,	w0,	w26,	ne
    str	w18,	[sp, #228]

    ldr	w0,	[sp, #208]

    cmp	w0,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w0,	ne
    mov	w18,	w0
    str	w18,	[sp, #300]

    ldr	w19,	[sp, #228]

    cmp	w19,	#0
    cset	w25,	ne
    ldr	w20,	[sp, #300]

    mov	w18,	w25
    cmp	w20,	#0
    movz	w19,	#1
    csel	w21,	w19,	w18,	ne
    str	w21,	[sp, #460]

    ldr	w20,	[sp, #228]

    cmp	w20,	#0
    cset	w23,	ne
    ldr	w21,	[sp, #300]

    mov	w18,	w23
    cmp	w21,	#0
    movz	w0,	#0
    csel	w0,	w18,	w0,	ne
    cmp	w0,	#0
    cset	w23,	eq
    cmp	w23,	#0
    ldr	w0,	[sp, #460]

    cset	w26,	ne
    mov	w19,	w26
    cmp	w0,	#0
    movz	w0,	#0
    csel	w23,	w19,	w0,	ne
    str	w23,	[sp, #176]

    ldr	w23,	[sp, #208]

    cmp	w23,	#0
    cset	w0,	ne
    mov	w24,	w0
    str	w24,	[sp, #1120]

    ldr	w21,	[sp, #228]

    cmp	w21,	#0
    ldr	w22,	[sp, #300]

    cset	w20,	ne
    mov	w0,	w20
    cmp	w22,	#0
    movz	w25,	#0
    csel	w20,	w0,	w25,	ne
    cmp	w20,	#0
    ldr	w21,	[sp, #1120]

    cset	w23,	ne
    mov	w27,	w23
    cmp	w21,	#0
    movz	w19,	#1
    csel	w23,	w19,	w27,	ne
    str	w23,	[sp, #232]

    ldr	w21,	[sp, #240]

    cmp	w21,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w23,	ne
    str	w23,	[sp, #1152]

    ldr	w24,	[sp, #232]

    cmp	w24,	#0
    cset	w0,	ne
    mov	w27,	w0
    ldr	w0,	[sp, #1152]

    cmp	w0,	#0
    movz	w20,	#1
    csel	w28,	w20,	w27,	ne
    str	w28,	[sp, #440]

    ldr	w25,	[sp, #232]

    cmp	w25,	#0
    cset	w18,	ne
    ldr	w24,	[sp, #1152]

    mov	w26,	w18
    cmp	w24,	#0
    movz	w18,	#0
    csel	w0,	w26,	w18,	ne
    cmp	w0,	#0
    cset	w18,	eq
    cmp	w18,	#0
    ldr	w23,	[sp, #440]

    cset	w0,	ne
    mov	w26,	w0
    cmp	w23,	#0
    movz	w0,	#0
    csel	w19,	w26,	w0,	ne
    str	w19,	[sp, #444]

    ldr	w0,	[sp, #240]

    cmp	w0,	#0
    cset	w0,	ne
    mov	w18,	w0
    str	w18,	[sp, #1196]

    ldr	w26,	[sp, #232]

    cmp	w26,	#0
    ldr	w27,	[sp, #1152]

    cset	w20,	ne
    mov	w25,	w20
    cmp	w27,	#0
    movz	w0,	#0
    csel	w24,	w25,	w0,	ne
    cmp	w24,	#0
    cset	w0,	ne
    ldr	w26,	[sp, #1196]

    cmp	w26,	#0
    movz	w24,	#1
    csel	w0,	w24,	w0,	ne
    str	w0,	[sp, #448]

    ldr	w21,	[sp, #720]

    cmp	w21,	#0
    cset	w20,	ne
    cmp	w20,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w0,	ne
    mov	w28,	w0
    str	w28,	[sp, #1156]

    ldr	w23,	[sp, #448]

    cmp	w23,	#0
    ldr	w0,	[sp, #1156]

    cset	w24,	ne
    mov	w18,	w24
    cmp	w0,	#0
    movz	w24,	#1
    csel	w25,	w24,	w18,	ne
    str	w25,	[sp, #436]

    ldr	w24,	[sp, #448]

    cmp	w24,	#0
    cset	w20,	ne
    mov	w0,	w20
    ldr	w20,	[sp, #1156]

    cmp	w20,	#0
    movz	w20,	#0
    csel	w0,	w0,	w20,	ne
    cmp	w0,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w25,	ne
    ldr	w21,	[sp, #436]

    mov	w0,	w25
    cmp	w21,	#0
    movz	w18,	#0
    csel	w27,	w0,	w18,	ne
    str	w27,	[sp, #824]

    ldr	w0,	[sp, #720]

    cmp	w0,	#0
    cset	w24,	ne
    ldr	w20,	[sp, #448]

    cmp	w20,	#0
    cset	w0,	ne
    ldr	w18,	[sp, #1156]

    cmp	w18,	#0
    movz	w20,	#0
    str	w20,	[sp, #1300]

    ldr	w23,	[sp, #1300]

    str	x23,	[sp, #1304]

    ldr	x25,	[sp, #1304]

    csel	w18,	w0,	w25,	ne
    cmp	w18,	#0
    cset	w21,	ne
    mov	w25,	w21
    cmp	w24,	#0
    movz	w0,	#1
    csel	w27,	w0,	w25,	ne
    str	w27,	[sp, #452]

    ldr	w18,	[sp, #500]

    cmp	w18,	#0
    cset	w25,	ne
    cmp	w25,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w19,	ne
    mov	w21,	w19
    str	w21,	[sp, #1200]

    ldr	w28,	[sp, #452]

    cmp	w28,	#0
    ldr	w28,	[sp, #1200]

    cset	w24,	ne
    mov	w19,	w24
    cmp	w28,	#0
    movz	w26,	#1
    csel	w18,	w26,	w19,	ne
    str	w18,	[sp, #828]

    ldr	w0,	[sp, #452]

    cmp	w0,	#0
    ldr	w19,	[sp, #1200]

    cset	w0,	ne
    cmp	w19,	#0
    movz	w23,	#0
    csel	w24,	w0,	w23,	ne
    cmp	w24,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w24,	ne
    mov	w0,	w24
    ldr	w24,	[sp, #828]

    cmp	w24,	#0
    movz	w27,	#0
    mov	w25,	w27
    csel	w24,	w0,	w25,	ne
    str	w24,	[sp, #808]

    ldr	w19,	[sp, #500]

    cmp	w19,	#0
    ldr	w26,	[sp, #452]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w26,	#0
    ldr	w21,	[sp, #1200]

    cset	w20,	ne
    cmp	w21,	#0
    movz	w22,	#0
    str	w22,	[sp, #380]

    ldr	w26,	[sp, #380]

    str	x26,	[sp, #384]

    ldr	x27,	[sp, #384]

    csel	w24,	w20,	w27,	ne
    cmp	w24,	#0
    cset	w26,	ne
    mov	w18,	w26
    cmp	w0,	#0
    movz	w27,	#1
    csel	w21,	w27,	w18,	ne
    str	w21,	[sp, #832]

    ldr	w23,	[sp, #516]

    cmp	w23,	#0
    cset	w23,	ne
    cmp	w23,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w0,	ne
    mov	w26,	w0
    str	w26,	[sp, #1204]

    ldr	w0,	[sp, #832]

    cmp	w0,	#0
    cset	w23,	ne
    ldr	w22,	[sp, #1204]

    mov	w28,	w23
    cmp	w22,	#0
    movz	w0,	#1
    csel	w26,	w0,	w28,	ne
    str	w26,	[sp, #424]

    ldr	w23,	[sp, #832]

    cmp	w23,	#0
    ldr	w23,	[sp, #1204]

    cset	w25,	ne
    mov	w26,	w25
    cmp	w23,	#0
    movz	w27,	#0
    csel	w25,	w26,	w27,	ne
    cmp	w25,	#0
    cset	w23,	eq
    cmp	w23,	#0
    ldr	w21,	[sp, #424]

    cset	w0,	ne
    cmp	w21,	#0
    movz	w25,	#0
    csel	w21,	w0,	w25,	ne
    str	w21,	[sp, #1184]

    ldr	w24,	[sp, #516]

    cmp	w24,	#0
    cset	w0,	ne
    mov	w25,	w0
    ldr	w0,	[sp, #832]

    cmp	w0,	#0
    cset	w0,	ne
    ldr	w27,	[sp, #1204]

    cmp	w27,	#0
    movz	w23,	#0
    str	w23,	[sp, #412]

    ldr	w27,	[sp, #412]

    str	x27,	[sp, #416]

    ldr	x27,	[sp, #416]

    csel	w23,	w0,	w27,	ne
    cmp	w23,	#0
    cset	w26,	ne
    mov	w20,	w26
    cmp	w25,	#0
    movz	w0,	#1
    csel	w0,	w0,	w20,	ne
    str	w0,	[sp, #428]

    ldr	w25,	[sp, #544]

    cmp	w25,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w23,	ne
    mov	w19,	w23
    str	w19,	[sp, #1208]

    ldr	w18,	[sp, #428]

    cmp	w18,	#0
    cset	w19,	ne
    ldr	w27,	[sp, #1208]

    mov	w26,	w19
    cmp	w27,	#0
    movz	w21,	#1
    csel	w0,	w21,	w26,	ne
    str	w0,	[sp, #432]

    ldr	w19,	[sp, #428]

    cmp	w19,	#0
    ldr	w28,	[sp, #1208]

    cset	w0,	ne
    mov	w21,	w0
    cmp	w28,	#0
    movz	w19,	#0
    csel	w19,	w21,	w19,	ne
    cmp	w19,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w19,	ne
    ldr	w28,	[sp, #432]

    mov	w21,	w19
    cmp	w28,	#0
    movz	w26,	#0
    csel	w18,	w21,	w26,	ne
    str	w18,	[sp, #1180]

    ldr	w26,	[sp, #544]

    cmp	w26,	#0
    cset	w19,	ne
    ldr	w26,	[sp, #428]

    mov	w23,	w19
    cmp	w26,	#0
    cset	w19,	ne
    ldr	w20,	[sp, #1208]

    cmp	w20,	#0
    movz	w18,	#0
    str	w18,	[sp, #1236]

    ldr	w24,	[sp, #1236]

    str	x24,	[sp, #1240]

    ldr	x25,	[sp, #1240]

    csel	w28,	w19,	w25,	ne
    cmp	w28,	#0
    cset	w19,	ne
    mov	w25,	w19
    cmp	w23,	#0
    movz	w0,	#1
    csel	w27,	w0,	w25,	ne
    str	w27,	[sp, #812]

    ldr	w0,	[sp, #564]

    cmp	w0,	#0
    cset	w23,	ne
    cmp	w23,	#0
    cset	w19,	eq
    cmp	w19,	#0
    cset	w23,	ne
    mov	w25,	w23
    str	w25,	[sp, #1192]

    ldr	w28,	[sp, #812]

    cmp	w28,	#0
    ldr	w19,	[sp, #1192]

    cset	w0,	ne
    mov	w21,	w0
    cmp	w19,	#0
    movz	w19,	#1
    csel	w25,	w19,	w21,	ne
    str	w25,	[sp, #876]

    ldr	w0,	[sp, #812]

    cmp	w0,	#0
    cset	w0,	ne
    mov	w21,	w0
    str	w21,	[sp, #692]

    ldr	w27,	[sp, #1192]

    cmp	w27,	#0
    movz	w0,	#0
    ldr	w21,	[sp, #692]

    csel	w0,	w21,	w0,	ne
    cmp	w0,	#0
    cset	w0,	eq
    cmp	w0,	#0
    ldr	w27,	[sp, #876]

    cset	w0,	ne
    cmp	w27,	#0
    movz	w24,	#0
    csel	w26,	w0,	w24,	ne
    str	w26,	[sp, #1172]

    ldr	w18,	[sp, #564]

    cmp	w18,	#0
    ldr	w21,	[sp, #812]

    cset	w0,	ne
    mov	w25,	w0
    cmp	w21,	#0
    ldr	w23,	[sp, #1192]

    cset	w0,	ne
    cmp	w23,	#0
    movz	fp,	#1252
    movz	w27,	#0
    str	w27,	[sp, #1248]

    ldr	w19,	[sp, #1248]

    str	x19,	[sp, fp]

    movz	fp,	#1252
    ldr	x20,	[sp, fp]

    csel	w28,	w0,	w20,	ne
    cmp	w28,	#0
    cset	w24,	ne
    mov	w28,	w24
    cmp	w25,	#0
    movz	w0,	#1
    csel	w20,	w0,	w28,	ne
    str	w20,	[sp, #816]

    ldr	w26,	[sp, #560]

    cmp	w26,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w0,	ne
    mov	w24,	w0
    str	w24,	[sp, #696]

    ldr	w21,	[sp, #816]

    cmp	w21,	#0
    cset	w0,	ne
    ldr	w24,	[sp, #696]

    mov	w19,	w0
    cmp	w24,	#0
    movz	w0,	#1
    csel	w24,	w0,	w19,	ne
    str	w24,	[sp, #820]

    ldr	w0,	[sp, #816]

    cmp	w0,	#0
    ldr	w0,	[sp, #696]

    cset	w23,	ne
    mov	w26,	w23
    cmp	w0,	#0
    movz	w0,	#0
    csel	w23,	w26,	w0,	ne
    cmp	w23,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w23,	ne
    ldr	w0,	[sp, #820]

    mov	w25,	w23
    cmp	w0,	#0
    ldr	w18,	[sp, #1172]

    movz	w19,	#0
    ldr	w22,	[sp, #1180]

    csel	w23,	w25,	w19,	ne
    lsl	w0,	w23,	#1
    add	w23,	w0,	w18
    ldr	w18,	[sp, #1184]

    ldr	w28,	[sp, #808]

    lsl	w0,	w23,	#1
    ldr	w20,	[sp, #824]

    ldr	w26,	[sp, #444]

    add	w0,	w0,	w22
    lsl	w0,	w0,	#1
    add	w25,	w0,	w18
    lsl	w0,	w25,	#1
    add	w24,	w0,	w28
    lsl	w25,	w24,	#1
    ldr	w24,	[sp, #176]

    add	w19,	w25,	w20
    lsl	w20,	w19,	#1
    add	w0,	w20,	w26
    ldr	w20,	[sp, #172]

    lsl	w23,	w0,	#1
    add	w0,	w23,	w24
    lsl	w23,	w0,	#1
    ldr	w0,	[sp, #200]

    add	w25,	w23,	w20
    lsl	w26,	w25,	#1
    add	w26,	w26,	w0
    ldr	w0,	[sp, #700]

    ldr	w24,	[sp, #748]

    lsl	w18,	w26,	#1
    ldr	w23,	[sp, #492]

    add	w28,	w18,	w0
    lsl	w21,	w28,	#1
    add	w18,	w21,	w24
    lsl	w24,	w18,	#1
    add	w20,	w24,	w23
    ldr	w24,	[sp, #528]

    lsl	w25,	w20,	#1
    ldr	w20,	[sp, #552]

    add	w0,	w25,	w24
    ldr	w21,	[sp, #568]

    lsl	w27,	w0,	#1
    add	w24,	w27,	w20
    lsl	w0,	w24,	#1
    add	w0,	w0,	w21
    bl	fib
    str	w0,	[sp, #572]

    ldr	w24,	[sp, #104]

    cmp	w24,	#0
    ldr	w21,	[sp, #604]

    ldr	w0,	[sp, #104]

    csel	w26,	w21,	w0,	lt
    str	w26,	[sp, #1276]

    ldr	w26,	[sp, #112]

    cmp	w26,	#0
    ldr	w28,	[sp, #620]

    ldr	w26,	[sp, #112]

    csel	w26,	w28,	w26,	lt
    str	w26,	[sp, #164]

    ldr	w21,	[sp, #116]

    cmp	w21,	#0
    ldr	w26,	[sp, #636]

    ldr	w23,	[sp, #116]

    csel	w0,	w26,	w23,	lt
    str	w0,	[sp, #1280]

    ldr	w23,	[sp, #124]

    cmp	w23,	#0
    ldr	w0,	[sp, #648]

    ldr	w26,	[sp, #124]

    csel	w0,	w0,	w26,	lt
    str	w0,	[sp, #160]

    ldr	w28,	[sp, #120]

    cmp	w28,	#0
    ldr	w20,	[sp, #660]

    ldr	w18,	[sp, #120]

    csel	w0,	w20,	w18,	lt
    str	w0,	[sp, #1272]

    ldr	w19,	[sp, #108]

    cmp	w19,	#0
    ldr	w23,	[sp, #672]

    ldr	w20,	[sp, #108]

    csel	w18,	w23,	w20,	lt
    str	w18,	[sp, #156]

    ldr	w0,	[sp, #100]

    cmp	w0,	#0
    ldr	w24,	[sp, #664]

    ldr	w0,	[sp, #100]

    csel	w18,	w24,	w0,	lt
    str	w18,	[sp, #168]

    ldr	w18,	[sp, #668]

    cmp	w18,	#0
    ldr	w21,	[sp, #652]

    ldr	w28,	[sp, #668]

    csel	w0,	w21,	w28,	lt
    str	w0,	[sp, #1228]

    ldr	w27,	[sp, #656]

    cmp	w27,	#0
    ldr	w0,	[sp, #640]

    ldr	w28,	[sp, #656]

    csel	w26,	w0,	w28,	lt
    str	w26,	[sp, #276]

    ldr	w24,	[sp, #644]

    cmp	w24,	#0
    ldr	w20,	[sp, #628]

    ldr	w25,	[sp, #644]

    csel	w0,	w20,	w25,	lt
    str	w0,	[sp, #1220]

    ldr	w21,	[sp, #632]

    cmp	w21,	#0
    ldr	w28,	[sp, #616]

    ldr	w0,	[sp, #632]

    csel	w25,	w28,	w0,	lt
    str	w25,	[sp, #1216]

    ldr	w0,	[sp, #624]

    cmp	w0,	#0
    ldr	w28,	[sp, #608]

    ldr	w23,	[sp, #624]

    csel	w0,	w28,	w23,	lt
    str	w0,	[sp, #728]

    ldr	w19,	[sp, #612]

    cmp	w19,	#0
    ldr	w24,	[sp, #596]

    ldr	w20,	[sp, #612]

    csel	w25,	w24,	w20,	lt
    str	w25,	[sp, #496]

    ldr	w28,	[sp, #600]

    cmp	w28,	#0
    ldr	w24,	[sp, #588]

    ldr	w0,	[sp, #600]

    csel	w19,	w24,	w0,	lt
    str	w19,	[sp, #524]

    ldr	w0,	[sp, #592]

    cmp	w0,	#0
    ldr	w24,	[sp, #580]

    ldr	w18,	[sp, #592]

    csel	w0,	w24,	w18,	lt
    str	w0,	[sp, #536]

    ldr	w18,	[sp, #584]

    cmp	w18,	#0
    ldr	w18,	[sp, #576]

    ldr	w19,	[sp, #584]

    csel	w21,	w18,	w19,	lt
    str	w21,	[sp, #540]

    ldr	w27,	[sp, #1276]

    cmp	w27,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w23,	ne
    mov	w0,	w23
    str	w0,	[sp, #556]

    ldr	w27,	[sp, #164]

    cmp	w27,	#0
    cset	w22,	ne
    cmp	w22,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w22,	ne
    cmp	w22,	#0
    cset	w22,	ne
    cmp	w22,	#0
    cset	w26,	ne
    mov	w0,	w26
    str	w0,	[sp, #548]

    ldr	w28,	[sp, #164]

    cmp	w28,	#0
    cset	w22,	ne
    cmp	w22,	#0
    cset	w26,	ne
    mov	w20,	w26
    str	w20,	[sp, #984]

    ldr	w18,	[sp, #1280]

    cmp	w18,	#0
    cset	w21,	ne
    cmp	w21,	#0
    cset	w21,	eq
    cmp	w21,	#0
    cset	w20,	ne
    str	w20,	[sp, #680]

    ldr	w21,	[sp, #984]

    cmp	w21,	#0
    cset	w26,	ne
    ldr	w0,	[sp, #680]

    cmp	w0,	#0
    movz	w20,	#1
    csel	w0,	w20,	w26,	ne
    str	w0,	[sp, #676]

    ldr	w0,	[sp, #984]

    cmp	w0,	#0
    ldr	w20,	[sp, #680]

    cset	w25,	ne
    mov	w18,	w25
    cmp	w20,	#0
    movz	w24,	#0
    csel	w26,	w18,	w24,	ne
    cmp	w26,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w26,	ne
    ldr	w25,	[sp, #676]

    cmp	w25,	#0
    movz	w20,	#0
    csel	w26,	w26,	w20,	ne
    str	w26,	[sp, #532]

    ldr	w19,	[sp, #1280]

    cmp	w19,	#0
    ldr	w21,	[sp, #984]

    cset	w26,	ne
    mov	w22,	w26
    cmp	w21,	#0
    ldr	w27,	[sp, #680]

    cset	w19,	ne
    cmp	w27,	#0
    movz	w28,	#0
    csel	w23,	w19,	w28,	ne
    cmp	w23,	#0
    cset	w20,	ne
    cmp	w22,	#0
    movz	w24,	#1
    csel	w24,	w24,	w20,	ne
    str	w24,	[sp, #724]

    ldr	w23,	[sp, #160]

    cmp	w23,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w21,	eq
    cmp	w21,	#0
    ldr	w26,	[sp, #724]

    cset	w22,	ne
    mov	w24,	w22
    cmp	w26,	#0
    cset	w0,	ne
    mov	w26,	w0
    cmp	w24,	#0
    movz	w19,	#1
    csel	w0,	w19,	w26,	ne
    ldr	w26,	[sp, #724]

    cmp	w26,	#0
    cset	w25,	ne
    mov	w18,	w25
    cmp	w24,	#0
    movz	w25,	#0
    csel	w19,	w18,	w25,	ne
    cmp	w19,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w26,	ne
    cmp	w0,	#0
    movz	w19,	#0
    csel	w0,	w26,	w19,	ne
    str	w0,	[sp, #512]

    ldr	w22,	[sp, #160]

    cmp	w22,	#0
    cset	w23,	ne
    ldr	w27,	[sp, #724]

    mov	w20,	w23
    cmp	w27,	#0
    cset	w18,	ne
    cmp	w24,	#0
    movz	w0,	#0
    csel	w22,	w18,	w0,	ne
    cmp	w22,	#0
    cset	w26,	ne
    cmp	w20,	#0
    movz	w22,	#1
    csel	w28,	w22,	w26,	ne
    ldr	w22,	[sp, #1272]

    cmp	w22,	#0
    cset	w21,	ne
    cmp	w21,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w19,	ne
    mov	w24,	w19
    cmp	w28,	#0
    cset	w0,	ne
    mov	w26,	w0
    cmp	w24,	#0
    movz	w18,	#1
    csel	w26,	w18,	w26,	ne
    cmp	w28,	#0
    cset	w25,	ne
    cmp	w24,	#0
    movz	w19,	#0
    csel	w0,	w25,	w19,	ne
    cmp	w0,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w0,	ne
    cmp	w26,	#0
    movz	w20,	#0
    csel	w0,	w0,	w20,	ne
    str	w0,	[sp, #752]

    ldr	w0,	[sp, #1272]

    cmp	w0,	#0
    cset	w26,	ne
    mov	w23,	w26
    cmp	w28,	#0
    cset	w0,	ne
    cmp	w24,	#0
    movz	w18,	#0
    csel	w20,	w0,	w18,	ne
    cmp	w20,	#0
    cset	w25,	ne
    cmp	w23,	#0
    movz	w0,	#1
    csel	w18,	w0,	w25,	ne
    str	w18,	[sp, #1264]

    ldr	w19,	[sp, #156]

    cmp	w19,	#0
    cset	w18,	ne
    cmp	w18,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w24,	ne
    ldr	w0,	[sp, #1264]

    cmp	w0,	#0
    cset	w25,	ne
    cmp	w24,	#0
    movz	w19,	#1
    ldr	w23,	[sp, #1264]

    csel	w26,	w19,	w25,	ne
    cmp	w23,	#0
    cset	w25,	ne
    mov	w0,	w25
    cmp	w24,	#0
    movz	w20,	#0
    csel	w18,	w0,	w20,	ne
    cmp	w18,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w0,	ne
    cmp	w26,	#0
    movz	w19,	#0
    csel	w26,	w0,	w19,	ne
    str	w26,	[sp, #712]

    ldr	w18,	[sp, #156]

    cmp	w18,	#0
    cset	w23,	ne
    ldr	w27,	[sp, #1264]

    mov	w20,	w23
    cmp	w27,	#0
    cset	w18,	ne
    cmp	w24,	#0
    movz	w28,	#0
    csel	w0,	w18,	w28,	ne
    cmp	w0,	#0
    cset	w22,	ne
    cmp	w20,	#0
    movz	w0,	#1
    csel	w26,	w0,	w22,	ne
    ldr	w0,	[sp, #168]

    cmp	w0,	#0
    cset	w25,	ne
    cmp	w25,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w19,	ne
    cmp	w26,	#0
    cset	w24,	ne
    cmp	w19,	#0
    movz	w18,	#1
    csel	w20,	w18,	w24,	ne
    cmp	w26,	#0
    cset	w21,	ne
    cmp	w19,	#0
    movz	w0,	#0
    csel	w18,	w21,	w0,	ne
    cmp	w18,	#0
    cset	w24,	eq
    cmp	w24,	#0
    cset	w0,	ne
    cmp	w20,	#0
    movz	w18,	#0
    csel	w28,	w0,	w18,	ne
    str	w28,	[sp, #1212]

    ldr	w21,	[sp, #168]

    cmp	w21,	#0
    cset	w21,	ne
    mov	w0,	w21
    cmp	w26,	#0
    cset	w20,	ne
    cmp	w19,	#0
    movz	w26,	#0
    csel	w26,	w20,	w26,	ne
    cmp	w26,	#0
    cset	w21,	ne
    cmp	w0,	#0
    movz	w0,	#1
    ldr	w19,	[sp, #1228]

    csel	w24,	w0,	w21,	ne
    cmp	w19,	#0
    cset	w23,	ne
    cmp	w23,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w20,	w28
    cmp	w24,	#0
    cset	w21,	ne
    mov	w26,	w21
    cmp	w20,	#0
    movz	w18,	#1
    csel	w28,	w18,	w26,	ne
    cmp	w24,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w20,	#0
    movz	w0,	#0
    csel	w19,	w26,	w0,	ne
    cmp	w19,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w21,	ne
    cmp	w28,	#0
    movz	w0,	#0
    csel	w18,	w21,	w0,	ne
    str	w18,	[sp, #268]

    ldr	w21,	[sp, #1228]

    cmp	w21,	#0
    cset	w21,	ne
    mov	w0,	w21
    cmp	w24,	#0
    cset	w18,	ne
    cmp	w20,	#0
    movz	w26,	#0
    csel	w26,	w18,	w26,	ne
    cmp	w26,	#0
    cset	w21,	ne
    cmp	w0,	#0
    movz	w22,	#1
    csel	w19,	w22,	w21,	ne
    str	w19,	[sp, #892]

    ldr	w0,	[sp, #276]

    cmp	w0,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w26,	eq
    cmp	w26,	#0
    ldr	w23,	[sp, #892]

    cset	w19,	ne
    mov	w0,	w19
    cmp	w23,	#0
    cset	w22,	ne
    cmp	w0,	#0
    movz	w20,	#1
    ldr	w19,	[sp, #892]

    csel	w18,	w20,	w22,	ne
    cmp	w19,	#0
    cset	w19,	ne
    mov	w28,	w19
    cmp	w0,	#0
    movz	w20,	#0
    csel	w26,	w28,	w20,	ne
    cmp	w26,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w28,	ne
    cmp	w18,	#0
    movz	w20,	#0
    csel	w26,	w28,	w20,	ne
    str	w26,	[sp, #264]

    ldr	w25,	[sp, #276]

    cmp	w25,	#0
    cset	w22,	ne
    ldr	w20,	[sp, #892]

    mov	w19,	w22
    cmp	w20,	#0
    cset	w18,	ne
    cmp	w0,	#0
    movz	w26,	#0
    csel	w0,	w18,	w26,	ne
    cmp	w0,	#0
    cset	w21,	ne
    cmp	w19,	#0
    movz	w25,	#1
    ldr	w26,	[sp, #1220]

    csel	w21,	w25,	w21,	ne
    cmp	w26,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w28,	ne
    mov	w0,	w28
    cmp	w21,	#0
    cset	w22,	ne
    mov	w19,	w22
    cmp	w0,	#0
    movz	w18,	#1
    csel	w18,	w18,	w19,	ne
    cmp	w21,	#0
    cset	w25,	ne
    cmp	w0,	#0
    movz	w19,	#0
    csel	w28,	w25,	w19,	ne
    cmp	w28,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w22,	ne
    cmp	w18,	#0
    movz	w28,	#0
    csel	w24,	w22,	w28,	ne
    str	w24,	[sp, #256]

    ldr	w28,	[sp, #1220]

    cmp	w28,	#0
    cset	w22,	ne
    mov	w19,	w22
    cmp	w21,	#0
    cset	w18,	ne
    cmp	w0,	#0
    movz	w25,	#0
    csel	w0,	w18,	w25,	ne
    cmp	w0,	#0
    cset	w0,	ne
    cmp	w19,	#0
    ldr	w22,	[sp, #1216]

    movz	w18,	#1
    csel	w25,	w18,	w0,	ne
    cmp	w22,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w19,	ne
    mov	w22,	w19
    cmp	w25,	#0
    cset	w20,	ne
    cmp	w22,	#0
    movz	w0,	#1
    csel	w21,	w0,	w20,	ne
    cmp	w25,	#0
    cset	w0,	ne
    cmp	w22,	#0
    movz	w18,	#0
    csel	w0,	w0,	w18,	ne
    cmp	w0,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w24,	ne
    cmp	w21,	#0
    movz	w23,	#0
    csel	w19,	w24,	w23,	ne
    str	w19,	[sp, #252]

    ldr	w23,	[sp, #1216]

    cmp	w23,	#0
    cset	w20,	ne
    mov	w0,	w20
    cmp	w25,	#0
    cset	w18,	ne
    cmp	w22,	#0
    movz	w25,	#0
    csel	w18,	w18,	w25,	ne
    cmp	w18,	#0
    cset	w19,	ne
    cmp	w0,	#0
    movz	w25,	#1
    csel	w0,	w25,	w19,	ne
    str	w0,	[sp, #272]

    ldr	w18,	[sp, #728]

    cmp	w18,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w26,	eq
    cmp	w26,	#0
    ldr	w26,	[sp, #272]

    cset	w25,	ne
    mov	w0,	w25
    cmp	w26,	#0
    cset	w22,	ne
    mov	w18,	w22
    cmp	w0,	#0
    movz	w19,	#1
    ldr	w27,	[sp, #272]

    csel	w21,	w19,	w18,	ne
    cmp	w27,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w0,	#0
    movz	w19,	#0
    csel	w22,	w25,	w19,	ne
    cmp	w22,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w22,	ne
    cmp	w21,	#0
    movz	w18,	#0
    csel	w28,	w22,	w18,	ne
    str	w28,	[sp, #804]

    ldr	w21,	[sp, #728]

    cmp	w21,	#0
    cset	w19,	ne
    ldr	w26,	[sp, #272]

    mov	w28,	w19
    cmp	w26,	#0
    cset	w18,	ne
    cmp	w0,	#0
    movz	w0,	#0
    csel	w0,	w18,	w0,	ne
    cmp	w0,	#0
    cset	w21,	ne
    cmp	w28,	#0
    movz	w25,	#1
    ldr	w26,	[sp, #496]

    csel	w21,	w25,	w21,	ne
    cmp	w26,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w22,	ne
    mov	w0,	w22
    cmp	w21,	#0
    cset	w18,	ne
    mov	w22,	w18
    cmp	w0,	#0
    movz	w24,	#1
    csel	w24,	w24,	w22,	ne
    cmp	w21,	#0
    cset	w22,	ne
    mov	w18,	w22
    cmp	w0,	#0
    movz	w22,	#0
    csel	w22,	w18,	w22,	ne
    cmp	w22,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w26,	ne
    cmp	w24,	#0
    movz	w18,	#0
    csel	w28,	w26,	w18,	ne
    str	w28,	[sp, #248]

    ldr	w22,	[sp, #496]

    cmp	w22,	#0
    cset	w19,	ne
    cmp	w21,	#0
    cset	w18,	ne
    cmp	w0,	#0
    movz	w25,	#0
    csel	w0,	w18,	w25,	ne
    cmp	w0,	#0
    cset	w28,	ne
    cmp	w19,	#0
    movz	w24,	#1
    ldr	w20,	[sp, #524]

    csel	w21,	w24,	w28,	ne
    cmp	w20,	#0
    cset	w24,	ne
    cmp	w24,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w0,	ne
    mov	w18,	w0
    cmp	w21,	#0
    cset	w0,	ne
    mov	w28,	w0
    cmp	w18,	#0
    movz	w0,	#1
    csel	w28,	w0,	w28,	ne
    cmp	w21,	#0
    cset	w22,	ne
    mov	w25,	w22
    cmp	w18,	#0
    movz	w26,	#0
    mov	w23,	w26
    csel	w23,	w25,	w23,	ne
    cmp	w23,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w0,	ne
    cmp	w28,	#0
    movz	w25,	#0
    csel	w23,	w0,	w25,	ne
    str	w23,	[sp, #800]

    ldr	w23,	[sp, #524]

    cmp	w23,	#0
    cset	w28,	ne
    mov	w0,	w28
    cmp	w21,	#0
    cset	w19,	ne
    cmp	w18,	#0
    movz	w18,	#0
    csel	w22,	w19,	w18,	ne
    cmp	w22,	#0
    cset	w25,	ne
    cmp	w0,	#0
    ldr	w26,	[sp, #536]

    movz	w28,	#1
    csel	w25,	w28,	w25,	ne
    cmp	w26,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w26,	ne
    mov	w0,	w26
    cmp	w25,	#0
    cset	w22,	ne
    mov	w18,	w22
    cmp	w0,	#0
    movz	w19,	#1
    csel	w27,	w19,	w18,	ne
    str	w27,	[sp, #704]

    cmp	w25,	#0
    cset	w19,	ne
    mov	w21,	w19
    cmp	w0,	#0
    movz	w19,	#0
    csel	w24,	w21,	w19,	ne
    cmp	w24,	#0
    cset	w18,	eq
    cmp	w18,	#0
    cset	w18,	ne
    ldr	w22,	[sp, #704]

    cmp	w22,	#0
    movz	w19,	#0
    csel	w23,	w18,	w19,	ne
    str	w23,	[sp, #1116]

    ldr	w22,	[sp, #536]

    cmp	w22,	#0
    cset	w22,	ne
    mov	w19,	w22
    cmp	w25,	#0
    cset	w18,	ne
    cmp	w0,	#0
    movz	w0,	#0
    csel	w0,	w18,	w0,	ne
    cmp	w0,	#0
    cset	w0,	ne
    cmp	w19,	#0
    movz	w22,	#1
    csel	w0,	w22,	w0,	ne
    str	w0,	[sp, #708]

    ldr	w0,	[sp, #540]

    cmp	w0,	#0
    cset	w26,	ne
    cmp	w26,	#0
    cset	w20,	eq
    cmp	w20,	#0
    cset	w26,	ne
    ldr	w23,	[sp, #708]

    mov	w0,	w26
    cmp	w23,	#0
    cset	w22,	ne
    cmp	w0,	#0
    ldr	w24,	[sp, #708]

    movz	w18,	#1
    csel	w23,	w18,	w22,	ne
    cmp	w24,	#0
    cset	w22,	ne
    cmp	w0,	#0
    movz	w0,	#0
    csel	w0,	w22,	w0,	ne
    cmp	w0,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w0,	ne
    cmp	w23,	#0
    ldr	w20,	[sp, #1116]

    movz	w25,	#0
    ldr	w24,	[sp, #800]

    csel	w26,	w0,	w25,	ne
    ldr	w19,	[sp, #248]

    lsl	w0,	w26,	#1
    ldr	w18,	[sp, #804]

    add	w0,	w0,	w20
    ldr	w23,	[sp, #252]

    ldr	w27,	[sp, #256]

    lsl	w26,	w0,	#1
    add	w0,	w26,	w24
    lsl	w20,	w0,	#1
    add	w22,	w20,	w19
    ldr	w19,	[sp, #264]

    lsl	w0,	w22,	#1
    add	w0,	w0,	w18
    lsl	w24,	w0,	#1
    add	w22,	w24,	w23
    ldr	w23,	[sp, #268]

    ldr	w18,	[sp, #1212]

    lsl	w0,	w22,	#1
    add	w25,	w0,	w27
    ldr	w27,	[sp, #712]

    lsl	w26,	w25,	#1
    add	w0,	w26,	w19
    lsl	w20,	w0,	#1
    add	w28,	w20,	w23
    lsl	w19,	w28,	#1
    add	w21,	w19,	w18
    lsl	w22,	w21,	#1
    add	w23,	w22,	w27
    ldr	w27,	[sp, #752]

    ldr	w20,	[sp, #512]

    lsl	w0,	w23,	#1
    add	w24,	w0,	w27
    ldr	w27,	[sp, #532]

    ldr	w0,	[sp, #548]

    lsl	w18,	w24,	#1
    ldr	w23,	[sp, #556]

    add	w26,	w18,	w20
    lsl	w28,	w26,	#1
    add	w18,	w28,	w27
    lsl	w25,	w18,	#1
    add	w0,	w25,	w0
    lsl	w25,	w0,	#1
    add	w0,	w25,	w23
    bl	fib
    ldr	w16,	[sp, #572]

    movz	w4,	#0
    asr	w12,	w16,	#31
    ldr	w17,	[sp, #572]

    ldr	w18,	[sp, #572]

    lsr	w13,	w12,	#31
    add	w14,	w17,	w13
    asr	w5,	w14,	#1
    lsl	w6,	w5,	#1
    sub	w3,	w18,	w6
    sub	w24,	w4,	w3
    cmp	w3,	#0
    csel	w26,	w24,	w3,	lt
    str	w26,	[sp, #1056]

    ldr	w19,	[sp, #572]

    asr	w23,	w19,	#31
    ldr	w20,	[sp, #572]

    lsr	w26,	w23,	#31
    add	w25,	w20,	w26
    movz	w20,	#0
    asr	w17,	w25,	#1
    asr	w26,	w17,	#31
    lsr	w27,	w26,	#31
    add	w28,	w17,	w27
    asr	w21,	w28,	#1
    lsl	w22,	w21,	#1
    sub	w3,	w17,	w22
    sub	w6,	w20,	w3
    cmp	w3,	#0
    asr	w5,	w17,	#31
    csel	w27,	w6,	w3,	lt
    movz	w2,	#0
    str	w27,	[sp, #1032]

    lsr	w6,	w5,	#31
    add	w7,	w17,	w6
    asr	w23,	w7,	#1
    asr	w8,	w23,	#31
    lsr	w9,	w8,	#31
    add	w11,	w23,	w9
    asr	w3,	w11,	#1
    lsl	w4,	w3,	#1
    sub	w7,	w23,	w4
    sub	w12,	w2,	w7
    cmp	w7,	#0
    movz	w11,	#0
    csel	w16,	w12,	w7,	lt
    asr	w18,	w23,	#31
    str	w16,	[sp, #1024]

    lsr	w19,	w18,	#31
    add	w20,	w23,	w19
    asr	w7,	w20,	#1
    asr	w22,	w7,	#31
    lsr	w23,	w22,	#31
    add	w24,	w7,	w23
    asr	w12,	w24,	#1
    lsl	w13,	w12,	#1
    sub	w2,	w7,	w13
    sub	w12,	w11,	w2
    cmp	w2,	#0
    csel	w1,	w12,	w2,	lt
    asr	w9,	w7,	#31
    str	w1,	[sp, #844]

    lsr	w11,	w9,	#31
    movz	w1,	#0
    add	w12,	w7,	w11
    asr	w9,	w12,	#1
    asr	w13,	w9,	#31
    lsr	w14,	w13,	#31
    add	w16,	w9,	w14
    asr	w2,	w16,	#1
    lsl	w2,	w2,	#1
    sub	w17,	w9,	w2
    sub	w18,	w1,	w17
    cmp	w17,	#0
    movz	w8,	#0
    asr	w1,	w9,	#31
    csel	w22,	w18,	w17,	lt
    lsr	w2,	w1,	#31
    str	w22,	[sp, #1028]

    add	w2,	w9,	w2
    asr	w20,	w2,	#1
    asr	w3,	w20,	#31
    lsr	w4,	w3,	#31
    add	w5,	w20,	w4
    asr	w9,	w5,	#1
    lsl	w11,	w9,	#1
    sub	w1,	w20,	w11
    sub	w11,	w8,	w1
    cmp	w1,	#0
    asr	w22,	w20,	#31
    csel	w3,	w11,	w1,	lt
    str	w3,	[sp, #1036]

    lsr	w23,	w22,	#31
    add	w24,	w20,	w23
    movz	w20,	#0
    asr	w15,	w24,	#1
    asr	w25,	w15,	#31
    lsr	w27,	w25,	#31
    add	w1,	w15,	w27
    asr	w22,	w1,	#1
    lsl	w23,	w22,	#1
    sub	w5,	w15,	w23
    sub	w3,	w20,	w5
    cmp	w5,	#0
    asr	w12,	w15,	#31
    movz	w24,	#0
    csel	w8,	w3,	w5,	lt
    lsr	w13,	w12,	#31
    str	w8,	[sp, #1040]

    add	w14,	w15,	w13
    asr	w20,	w14,	#1
    asr	w16,	w20,	#31
    lsr	w18,	w16,	#31
    add	w19,	w20,	w18
    asr	w25,	w19,	#1
    lsl	w27,	w25,	#1
    sub	w21,	w20,	w27
    sub	w12,	w24,	w21
    cmp	w21,	#0
    asr	w6,	w20,	#31
    csel	w13,	w12,	w21,	lt
    movz	w1,	#0
    str	w13,	[sp, #1044]

    lsr	w7,	w6,	#31
    add	w9,	w20,	w7
    asr	w9,	w9,	#1
    asr	w11,	w9,	#31
    lsr	w12,	w11,	#31
    add	w13,	w9,	w12
    asr	w2,	w13,	#1
    lsl	w2,	w2,	#1
    sub	w6,	w9,	w2
    sub	w14,	w1,	w6
    cmp	w6,	#0
    csel	w25,	w14,	w6,	lt
    movz	w27,	#0
    asr	w2,	w9,	#31
    str	w25,	[sp, #1052]

    lsr	w2,	w2,	#31
    add	w5,	w9,	w2
    asr	w25,	w5,	#1
    asr	w6,	w25,	#31
    lsr	w7,	w6,	#31
    add	w9,	w25,	w7
    asr	w1,	w9,	#1
    lsl	w2,	w1,	#1
    sub	w15,	w25,	w2
    sub	w7,	w27,	w15
    cmp	w15,	#0
    csel	w6,	w7,	w15,	lt
    asr	w5,	w25,	#31
    movz	w1,	#0
    str	w6,	[sp, #1060]

    lsr	w6,	w5,	#31
    add	w7,	w25,	w6
    asr	w21,	w7,	#1
    asr	w9,	w21,	#31
    lsr	w11,	w9,	#31
    add	w12,	w21,	w11
    asr	w2,	w12,	#1
    lsl	w2,	w2,	#1
    sub	w7,	w21,	w2
    sub	w24,	w1,	w7
    cmp	w7,	#0
    csel	w18,	w24,	w7,	lt
    asr	w14,	w21,	#31
    str	w18,	[sp, #836]

    lsr	w16,	w14,	#31
    add	w19,	w21,	w16
    asr	w7,	w19,	#1
    asr	w20,	w7,	#31
    lsr	w22,	w20,	#31
    add	w24,	w7,	w22
    asr	w2,	w24,	#1
    lsl	w6,	w2,	#1
    movz	w2,	#0
    sub	w21,	w7,	w6
    sub	w2,	w2,	w21
    cmp	w21,	#0
    movz	w1,	#0
    csel	w8,	w2,	w21,	lt
    str	w8,	[sp, #872]

    asr	w2,	w7,	#31
    lsr	w2,	w2,	#31
    add	w6,	w7,	w2
    asr	w26,	w6,	#1
    asr	w9,	w26,	#31
    lsr	w11,	w9,	#31
    add	w12,	w26,	w11
    asr	w2,	w12,	#1
    lsl	w2,	w2,	#1
    sub	w23,	w26,	w2
    sub	w27,	w1,	w23
    cmp	w23,	#0
    csel	w25,	w27,	w23,	lt
    asr	w1,	w26,	#31
    str	w25,	[sp, #864]

    lsr	w2,	w1,	#31
    movz	w1,	#0
    add	w2,	w26,	w2
    asr	w26,	w2,	#1
    asr	w13,	w26,	#31
    lsr	w14,	w13,	#31
    add	w16,	w26,	w14
    asr	w19,	w16,	#1
    lsl	w20,	w19,	#1
    sub	w2,	w26,	w20
    sub	w9,	w1,	w2
    cmp	w2,	#0
    csel	w22,	w9,	w2,	lt
    asr	w1,	w26,	#31
    movz	w9,	#0
    str	w22,	[sp, #840]

    lsr	w2,	w1,	#31
    add	w24,	w26,	w2
    asr	w6,	w24,	#1
    asr	w2,	w6,	#31
    lsr	w11,	w2,	#31
    add	w14,	w6,	w11
    asr	w21,	w14,	#1
    lsl	w22,	w21,	#1
    sub	w3,	w6,	w22
    sub	w18,	w9,	w3
    cmp	w3,	#0
    asr	w11,	w6,	#31
    csel	w21,	w18,	w3,	lt
    movz	w2,	#0
    str	w21,	[sp, #860]

    lsr	w14,	w11,	#31
    add	w19,	w6,	w14
    asr	w21,	w19,	#1
    asr	w20,	w21,	#31
    lsr	w22,	w20,	#31
    add	w24,	w21,	w22
    asr	w6,	w24,	#1
    lsl	w9,	w6,	#1
    sub	w11,	w21,	w9
    sub	w25,	w2,	w11
    cmp	w11,	#0
    csel	w10,	w25,	w11,	lt
    asr	w24,	w0,	#31
    str	w10,	[sp, #856]

    lsr	w25,	w24,	#31
    add	w27,	w0,	w25
    asr	w2,	w27,	#1
    lsl	w6,	w2,	#1
    movz	w2,	#0
    sub	w27,	w0,	w6
    sub	w2,	w2,	w27
    cmp	w27,	#0
    asr	w9,	w0,	#31
    csel	w16,	w2,	w27,	lt
    str	w16,	[sp, #1048]

    lsr	w16,	w9,	#31
    add	w0,	w0,	w16
    asr	w7,	w0,	#1
    asr	w20,	w7,	#31
    lsr	w22,	w20,	#31
    add	w24,	w7,	w22
    asr	w22,	w24,	#1
    lsl	w24,	w22,	#1
    movz	w22,	#0
    sub	w19,	w7,	w24
    sub	w0,	w22,	w19
    cmp	w19,	#0
    csel	w3,	w0,	w19,	lt
    str	w3,	[sp, #852]

    asr	w0,	w7,	#31
    lsr	w16,	w0,	#31
    add	w27,	w7,	w16
    asr	w24,	w27,	#1
    asr	w15,	w24,	#31
    lsr	w17,	w15,	#31
    add	w18,	w24,	w17
    asr	w0,	w18,	#1
    lsl	w7,	w0,	#1
    movz	w0,	#0
    sub	w16,	w24,	w7
    sub	w0,	w0,	w16
    cmp	w16,	#0
    movz	w20,	#0
    csel	w7,	w0,	w16,	lt
    str	w7,	[sp, #1020]

    asr	w0,	w24,	#31
    lsr	w0,	w0,	#31
    add	w27,	w24,	w0
    asr	w0,	w27,	#1
    asr	w15,	w0,	#31
    lsr	w16,	w15,	#31
    add	w18,	w0,	w16
    asr	w8,	w18,	#1
    lsl	w15,	w8,	#1
    sub	w16,	w0,	w15
    sub	w18,	w20,	w16
    cmp	w16,	#0
    csel	w27,	w18,	w16,	lt
    asr	w19,	w0,	#31
    str	w27,	[sp, #848]

    movz	w18,	#0
    lsr	w21,	w19,	#31
    add	w22,	w0,	w21
    asr	w4,	w22,	#1
    asr	w27,	w4,	#31
    lsr	w7,	w27,	#31
    add	w14,	w4,	w7
    asr	w7,	w14,	#1
    lsl	w14,	w7,	#1
    sub	w9,	w4,	w14
    sub	w18,	w18,	w9
    cmp	w9,	#0
    csel	w15,	w18,	w9,	lt
    asr	w24,	w4,	#31
    lsr	w26,	w24,	#31
    add	w22,	w4,	w26
    asr	w8,	w22,	#1
    asr	w7,	w8,	#31
    lsr	w16,	w7,	#31
    add	w20,	w8,	w16
    asr	w23,	w20,	#1
    movz	w20,	#0
    lsl	w25,	w23,	#1
    sub	w24,	w8,	w25
    sub	w1,	w20,	w24
    cmp	w24,	#0
    asr	w25,	w8,	#31
    csel	w24,	w1,	w24,	lt
    str	w24,	[sp, #1008]

    lsr	w1,	w25,	#31
    add	w0,	w8,	w1
    asr	w19,	w0,	#1
    movz	w0,	#0
    asr	w20,	w19,	#31
    lsr	w21,	w20,	#31
    add	w25,	w19,	w21
    asr	w7,	w25,	#1
    lsl	w20,	w7,	#1
    sub	w25,	w19,	w20
    sub	w1,	w0,	w25
    cmp	w25,	#0
    csel	w12,	w1,	w25,	lt
    asr	w7,	w19,	#31
    str	w12,	[sp, #880]

    lsr	w20,	w7,	#31
    add	w7,	w19,	w20
    asr	w23,	w7,	#1
    asr	w1,	w23,	#31
    lsr	w0,	w1,	#31
    add	w7,	w23,	w0
    movz	w0,	#0
    asr	w7,	w7,	#1
    lsl	w14,	w7,	#1
    sub	w26,	w23,	w14
    sub	w1,	w0,	w26
    cmp	w26,	#0
    asr	w7,	w23,	#31
    csel	w0,	w1,	w26,	lt
    str	w0,	[sp, #1012]

    lsr	w20,	w7,	#31
    add	w0,	w23,	w20
    asr	w2,	w0,	#1
    movz	w0,	#0
    asr	w3,	w2,	#31
    lsr	w9,	w3,	#31
    add	w21,	w2,	w9
    asr	w9,	w21,	#1
    lsl	w21,	w9,	#1
    sub	w11,	w2,	w21
    sub	w22,	w0,	w11
    cmp	w11,	#0
    csel	w21,	w22,	w11,	lt
    str	w21,	[sp, #884]

    asr	w22,	w2,	#31
    lsr	w3,	w22,	#31
    add	w7,	w2,	w3
    asr	w22,	w7,	#1
    asr	w0,	w22,	#31
    lsr	w1,	w0,	#31
    add	w7,	w22,	w1
    asr	w7,	w7,	#1
    lsl	w0,	w7,	#1
    sub	w11,	w22,	w0
    movz	w0,	#0
    sub	w1,	w0,	w11
    cmp	w11,	#0
    csel	w3,	w1,	w11,	lt
    asr	w7,	w22,	#31
    str	w3,	[sp, #1016]

    lsr	w1,	w7,	#31
    add	w7,	w22,	w1
    asr	w10,	w7,	#1
    asr	w0,	w10,	#31
    lsr	w21,	w0,	#31
    add	w0,	w10,	w21
    asr	w21,	w0,	#1
    lsl	w0,	w21,	#1
    sub	w23,	w10,	w0
    movz	w0,	#0
    sub	w0,	w0,	w23
    cmp	w23,	#0
    csel	w8,	w0,	w23,	lt
    asr	w21,	w10,	#31
    str	w8,	[sp, #744]

    lsr	w0,	w21,	#31
    add	w7,	w10,	w0
    asr	w3,	w7,	#1
    asr	w21,	w3,	#31
    lsr	w8,	w21,	#31
    add	w21,	w3,	w8
    asr	w8,	w21,	#1
    lsl	w21,	w8,	#1
    sub	w8,	w3,	w21
    movz	w21,	#0
    mov	w20,	w21
    sub	w21,	w20,	w8
    cmp	w8,	#0
    csel	w27,	w21,	w8,	lt
    str	w27,	[sp, #520]

    asr	w8,	w3,	#31
    lsr	w21,	w8,	#31
    add	w7,	w3,	w21
    asr	w25,	w7,	#1
    asr	w0,	w25,	#31
    lsr	w7,	w0,	#31
    add	w0,	w25,	w7
    asr	w7,	w0,	#1
    lsl	w0,	w7,	#1
    sub	w9,	w25,	w0
    movz	w0,	#0
    sub	w0,	w0,	w9
    cmp	w9,	#0
    csel	w12,	w0,	w9,	lt
    asr	w7,	w25,	#31
    str	w12,	[sp, #508]

    lsr	w0,	w7,	#31
    add	w7,	w25,	w0
    asr	w10,	w7,	#1
    asr	w0,	w10,	#31
    lsr	w21,	w0,	#31
    add	w0,	w10,	w21
    asr	w21,	w0,	#1
    lsl	w0,	w21,	#1
    sub	w23,	w10,	w0
    movz	w0,	#0
    sub	w0,	w0,	w23
    cmp	w23,	#0
    asr	w21,	w10,	#31
    movz	w20,	#0
    csel	w7,	w0,	w23,	lt
    lsr	w0,	w21,	#31
    str	w7,	[sp, #504]

    add	w7,	w10,	w0
    asr	w3,	w7,	#1
    asr	w21,	w3,	#31
    lsr	w8,	w21,	#31
    add	w21,	w3,	w8
    asr	w8,	w21,	#1
    lsl	w21,	w8,	#1
    sub	w8,	w3,	w21
    sub	w21,	w20,	w8
    cmp	w8,	#0
    csel	w22,	w21,	w8,	lt
    movz	w0,	#0
    str	w22,	[sp, #756]

    asr	w8,	w3,	#31
    lsr	w21,	w8,	#31
    add	w7,	w3,	w21
    asr	w20,	w7,	#1
    asr	w1,	w20,	#31
    lsr	w7,	w1,	#31
    add	w1,	w20,	w7
    asr	w7,	w1,	#1
    lsl	w1,	w7,	#1
    sub	w9,	w20,	w1
    sub	w0,	w0,	w9
    cmp	w9,	#0
    csel	w24,	w0,	w9,	lt
    str	w24,	[sp, #868]

    ldr	w17,	[sp, #1048]

    cmp	w17,	#0
    cset	w20,	ne
    ldr	w0,	[sp, #1056]

    mov	w1,	w20
    cmp	w0,	#0
    movz	w22,	#1
    mov	w20,	w22
    csel	w0,	w20,	w1,	ne
    str	w0,	[sp, #732]

    ldr	w18,	[sp, #1048]

    cmp	w18,	#0
    cset	w20,	ne
    ldr	w1,	[sp, #1056]

    mov	w22,	w20
    cmp	w1,	#0
    movz	w1,	#0
    mov	w0,	w1
    csel	w0,	w22,	w0,	ne
    cmp	w0,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w0,	ne
    ldr	w2,	[sp, #732]

    cmp	w2,	#0
    movz	w22,	#0
    mov	w21,	w22
    csel	w0,	w0,	w21,	ne
    cmp	w0,	#0
    cset	w0,	ne
    cmp	w0,	#0
    cset	w20,	ne
    ldr	w21,	[sp, #1048]

    mov	w28,	w20
    cmp	w21,	#0
    cset	w20,	ne
    ldr	w7,	[sp, #1056]

    mov	w22,	w20
    cmp	w7,	#0
    movz	w13,	#0
    csel	w4,	w22,	w13,	ne
    cmp	w4,	#0
    ldr	w18,	[sp, #852]

    cset	w13,	ne
    mov	w20,	w13
    cmp	w18,	#0
    cset	w4,	ne
    ldr	w8,	[sp, #1032]

    mov	w16,	w4
    cmp	w8,	#0
    movz	w4,	#1
    ldr	w2,	[sp, #852]

    csel	w8,	w4,	w16,	ne
    cmp	w2,	#0
    cset	w13,	ne
    mov	w2,	w13
    str	w2,	[sp, #736]

    ldr	w11,	[sp, #1032]

    cmp	w11,	#0
    ldr	w4,	[sp, #736]

    movz	w13,	#0
    csel	w13,	w4,	w13,	ne
    cmp	w13,	#0
    cset	w13,	eq
    cmp	w13,	#0
    cset	w13,	ne
    mov	w16,	w13
    cmp	w8,	#0
    movz	w4,	#0
    csel	w10,	w16,	w4,	ne
    str	w10,	[sp, #688]

    cmp	w20,	#0
    cset	w4,	ne
    ldr	w12,	[sp, #688]

    cmp	w12,	#0
    movz	w16,	#1
    mov	w13,	w16
    csel	w19,	w13,	w4,	ne
    cmp	w20,	#0
    cset	w4,	ne
    mov	w7,	w4
    str	w7,	[sp, #684]

    ldr	w11,	[sp, #688]

    cmp	w11,	#0
    movz	w4,	#0
    ldr	w24,	[sp, #684]

    csel	w5,	w24,	w4,	ne
    cmp	w5,	#0
    cset	w4,	eq
    cmp	w4,	#0
    cset	w4,	ne
    cmp	w19,	#0
    movz	w16,	#0
    mov	w14,	w16
    csel	w17,	w4,	w14,	ne
    str	w17,	[sp, #1100]

    ldr	w22,	[sp, #852]

    cmp	w22,	#0
    ldr	w11,	[sp, #1032]

    cset	w27,	ne
    mov	w1,	w27
    cmp	w11,	#0
    movz	w5,	#0
    mov	w4,	w5
    csel	w12,	w1,	w4,	ne
    cmp	w20,	#0
    cset	w4,	ne
    ldr	w16,	[sp, #688]

    cmp	w16,	#0
    movz	w27,	#0
    mov	w25,	w27
    csel	w25,	w4,	w25,	ne
    cmp	w25,	#0
    cset	w20,	ne
    cmp	w12,	#0
    movz	w8,	#1
    ldr	w14,	[sp, #1020]

    csel	w1,	w8,	w20,	ne
    cmp	w14,	#0
    ldr	w2,	[sp, #1024]

    cset	w8,	ne
    mov	w27,	w8
    cmp	w2,	#0
    movz	w4,	#1
    ldr	w25,	[sp, #1020]

    csel	w10,	w4,	w27,	ne
    cmp	w25,	#0
    ldr	w26,	[sp, #1024]

    cset	w4,	ne
    cmp	w26,	#0
    movz	w27,	#0
    mov	w25,	w27
    csel	w27,	w4,	w25,	ne
    cmp	w27,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w25,	ne
    mov	w27,	w25
    cmp	w10,	#0
    movz	w8,	#0
    csel	w2,	w27,	w8,	ne
    cmp	w1,	#0
    cset	w4,	ne
    mov	w10,	w4
    cmp	w2,	#0
    movz	w4,	#1
    csel	w13,	w4,	w10,	ne
    cmp	w1,	#0
    cset	w8,	ne
    mov	w5,	w8
    str	w5,	[sp, #740]

    cmp	w2,	#0
    movz	w8,	#0
    ldr	w26,	[sp, #740]

    csel	w10,	w26,	w8,	ne
    cmp	w10,	#0
    cset	w8,	eq
    cmp	w8,	#0
    cset	w8,	ne
    mov	w9,	w8
    cmp	w13,	#0
    movz	w4,	#0
    csel	w6,	w9,	w4,	ne
    str	w6,	[sp, #1104]

    ldr	w26,	[sp, #1020]

    cmp	w26,	#0
    cset	w4,	ne
    ldr	w27,	[sp, #1024]

    cmp	w27,	#0
    movz	w23,	#0
    mov	w21,	w23
    csel	w26,	w4,	w21,	ne
    cmp	w1,	#0
    cset	w4,	ne
    cmp	w2,	#0
    movz	w27,	#0
    mov	w25,	w27
    csel	w4,	w4,	w25,	ne
    cmp	w4,	#0
    cset	w25,	ne
    cmp	w26,	#0
    movz	w4,	#1
    ldr	w12,	[sp, #848]

    csel	w9,	w4,	w25,	ne
    cmp	w12,	#0
    cset	w21,	ne
    mov	w6,	w21
    ldr	w21,	[sp, #844]

    cmp	w21,	#0
    movz	w0,	#1
    ldr	w27,	[sp, #848]

    csel	w1,	w0,	w6,	ne
    cmp	w27,	#0
    ldr	w21,	[sp, #844]

    cset	w0,	ne
    mov	w4,	w0
    cmp	w21,	#0
    movz	w27,	#0
    mov	w25,	w27
    csel	w0,	w4,	w25,	ne
    cmp	w0,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w4,	ne
    cmp	w1,	#0
    movz	w23,	#0
    mov	w21,	w23
    csel	w11,	w4,	w21,	ne
    cmp	w9,	#0
    cset	w4,	ne
    mov	w23,	w4
    cmp	w11,	#0
    movz	w0,	#1
    csel	w3,	w0,	w23,	ne
    cmp	w9,	#0
    cset	w0,	ne
    mov	w6,	w0
    cmp	w11,	#0
    movz	w0,	#0
    csel	w5,	w6,	w0,	ne
    cmp	w5,	#0
    cset	w4,	eq
    cmp	w4,	#0
    cset	w4,	ne
    cmp	w3,	#0
    movz	w23,	#0
    mov	w21,	w23
    csel	w26,	w4,	w21,	ne
    str	w26,	[sp, #1096]

    ldr	w0,	[sp, #848]

    cmp	w0,	#0
    ldr	w23,	[sp, #844]

    cset	w4,	ne
    mov	w6,	w4
    cmp	w23,	#0
    movz	w0,	#0
    csel	w7,	w6,	w0,	ne
    cmp	w9,	#0
    cset	w0,	ne
    mov	w1,	w0
    cmp	w11,	#0
    movz	w21,	#0
    mov	w20,	w21
    csel	w0,	w1,	w20,	ne
    cmp	w0,	#0
    cset	w25,	ne
    cmp	w7,	#0
    movz	w4,	#1
    csel	w20,	w4,	w25,	ne
    cmp	w15,	#0
    cset	w0,	ne
    ldr	w5,	[sp, #1028]

    mov	w2,	w0
    cmp	w5,	#0
    movz	w0,	#1
    csel	w7,	w0,	w2,	ne
    cmp	w15,	#0
    cset	w27,	ne
    ldr	w4,	[sp, #1028]

    mov	w1,	w27
    cmp	w4,	#0
    movz	w0,	#0
    csel	w1,	w1,	w0,	ne
    cmp	w1,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w25,	ne
    mov	w26,	w25
    cmp	w7,	#0
    movz	w4,	#0
    csel	w8,	w26,	w4,	ne
    cmp	w20,	#0
    cset	w0,	ne
    mov	w6,	w0
    cmp	w8,	#0
    movz	w0,	#1
    csel	w9,	w0,	w6,	ne
    cmp	w20,	#0
    cset	w0,	ne
    mov	w1,	w0
    cmp	w8,	#0
    movz	w0,	#0
    csel	w0,	w1,	w0,	ne
    cmp	w0,	#0
    cset	w0,	eq
    cmp	w0,	#0
    cset	w27,	ne
    mov	w1,	w27
    cmp	w9,	#0
    movz	w5,	#0
    mov	w4,	w5
    csel	w23,	w1,	w4,	ne
    str	w23,	[sp, #1092]

    cmp	w15,	#0
    cset	w26,	ne
    ldr	w7,	[sp, #1028]

    mov	w0,	w26
    cmp	w7,	#0
    movz	w16,	#0
    mov	w15,	w16
    csel	w17,	w0,	w15,	ne
    cmp	w20,	#0
    cset	w25,	ne
    cmp	w8,	#0
    movz	w24,	#0
    csel	w26,	w25,	w24,	ne
    cmp	w26,	#0
    cset	w18,	ne
    cmp	w17,	#0
    ldr	w23,	[sp, #1008]

    movz	w15,	#1
    csel	w6,	w15,	w18,	ne
    cmp	w23,	#0
    cset	w25,	ne
    ldr	w8,	[sp, #1036]

    mov	w19,	w25
    cmp	w8,	#0
    movz	w0,	#1
    csel	w1,	w0,	w19,	ne
    ldr	w0,	[sp, #1008]

    cmp	w0,	#0
    ldr	w18,	[sp, #1036]

    cset	w26,	ne
    mov	w25,	w26
    cmp	w18,	#0
    movz	w0,	#0
    mov	w26,	w0
    csel	w22,	w25,	w26,	ne
    cmp	w22,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w15,	ne
    cmp	w1,	#0
    movz	w0,	#0
    csel	w10,	w15,	w0,	ne
    cmp	w6,	#0
    cset	w26,	ne
    mov	w15,	w26
    cmp	w10,	#0
    movz	w25,	#1
    mov	w23,	w25
    csel	w9,	w23,	w15,	ne
    cmp	w6,	#0
    cset	w0,	ne
    mov	w25,	w0
    cmp	w10,	#0
    movz	w18,	#0
    csel	w1,	w25,	w18,	ne
    cmp	w1,	#0
    cset	w15,	eq
    cmp	w15,	#0
    cset	w23,	ne
    mov	w25,	w23
    cmp	w9,	#0
    movz	w15,	#0
    csel	w8,	w25,	w15,	ne
    str	w8,	[sp, #1088]

    ldr	w1,	[sp, #1008]

    cmp	w1,	#0
    ldr	w19,	[sp, #1036]

    cset	w26,	ne
    mov	w27,	w26
    cmp	w19,	#0
    movz	w0,	#0
    csel	w9,	w27,	w0,	ne
    cmp	w6,	#0
    cset	w6,	ne
    cmp	w10,	#0
    movz	w27,	#0
    csel	w24,	w6,	w27,	ne
    cmp	w24,	#0
    cset	w0,	ne
    cmp	w9,	#0
    movz	w27,	#1
    ldr	w15,	[sp, #880]

    csel	w8,	w27,	w0,	ne
    cmp	w15,	#0
    ldr	w13,	[sp, #1040]

    cset	w23,	ne
    cmp	w13,	#0
    movz	w26,	#1
    csel	w6,	w26,	w23,	ne
    ldr	w26,	[sp, #880]

    cmp	w26,	#0
    ldr	w25,	[sp, #1040]

    cset	w0,	ne
    cmp	w25,	#0
    movz	w25,	#0
    mov	w23,	w25
    csel	w27,	w0,	w23,	ne
    cmp	w27,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w15,	ne
    cmp	w6,	#0
    movz	w22,	#0
    csel	w23,	w15,	w22,	ne
    cmp	w8,	#0
    cset	w25,	ne
    mov	w22,	w25
    cmp	w23,	#0
    movz	w0,	#1
    csel	w3,	w0,	w22,	ne
    cmp	w8,	#0
    cset	w25,	ne
    mov	w20,	w25
    cmp	w23,	#0
    movz	w26,	#0
    mov	w24,	w26
    csel	w26,	w20,	w24,	ne
    cmp	w26,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w0,	ne
    cmp	w3,	#0
    movz	w26,	#0
    mov	w25,	w26
    csel	w3,	w0,	w25,	ne
    str	w3,	[sp, #1084]

    ldr	w27,	[sp, #880]

    cmp	w27,	#0
    ldr	w26,	[sp, #1040]

    cset	w20,	ne
    cmp	w26,	#0
    movz	w25,	#0
    mov	w24,	w25
    csel	w4,	w20,	w24,	ne
    cmp	w8,	#0
    cset	w2,	ne
    cmp	w23,	#0
    movz	w24,	#0
    csel	w2,	w2,	w24,	ne
    cmp	w2,	#0
    cset	w15,	ne
    cmp	w4,	#0
    ldr	w1,	[sp, #1012]

    movz	w2,	#1
    csel	w0,	w2,	w15,	ne
    cmp	w1,	#0
    cset	w20,	ne
    ldr	w18,	[sp, #1044]

    cmp	w18,	#0
    ldr	w6,	[sp, #1012]

    movz	w2,	#1
    csel	w2,	w2,	w20,	ne
    cmp	w6,	#0
    cset	w24,	ne
    ldr	w4,	[sp, #1044]

    cmp	w4,	#0
    movz	w27,	#0
    mov	w25,	w27
    csel	w8,	w24,	w25,	ne
    cmp	w8,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w24,	ne
    cmp	w2,	#0
    movz	w2,	#0
    csel	w19,	w24,	w2,	ne
    cmp	w0,	#0
    cset	w22,	ne
    cmp	w19,	#0
    movz	w27,	#1
    mov	w26,	w27
    csel	w10,	w26,	w22,	ne
    cmp	w0,	#0
    cset	w2,	ne
    mov	w26,	w2
    cmp	w19,	#0
    movz	w22,	#0
    csel	w1,	w26,	w22,	ne
    cmp	w1,	#0
    cset	w24,	eq
    cmp	w24,	#0
    cset	w6,	ne
    cmp	w10,	#0
    movz	w22,	#0
    mov	w21,	w22
    csel	w2,	w6,	w21,	ne
    str	w2,	[sp, #1080]

    ldr	w6,	[sp, #1012]

    cmp	w6,	#0
    ldr	w2,	[sp, #1044]

    cset	w20,	ne
    cmp	w2,	#0
    movz	w24,	#0
    csel	w3,	w20,	w24,	ne
    cmp	w0,	#0
    cset	w25,	ne
    cmp	w19,	#0
    movz	w6,	#0
    csel	w21,	w25,	w6,	ne
    cmp	w21,	#0
    cset	w24,	ne
    cmp	w3,	#0
    movz	w6,	#1
    ldr	w20,	[sp, #884]

    csel	w18,	w6,	w24,	ne
    cmp	w20,	#0
    cset	w25,	ne
    ldr	w0,	[sp, #1052]

    cmp	w0,	#0
    ldr	w1,	[sp, #884]

    movz	w0,	#1
    csel	w20,	w0,	w25,	ne
    cmp	w1,	#0
    cset	w15,	ne
    ldr	w9,	[sp, #1052]

    cmp	w9,	#0
    movz	w27,	#0
    mov	w26,	w27
    csel	w24,	w15,	w26,	ne
    cmp	w24,	#0
    cset	w25,	eq
    cmp	w25,	#0
    cset	w6,	ne
    cmp	w20,	#0
    movz	w24,	#0
    csel	w7,	w6,	w24,	ne
    cmp	w18,	#0
    cset	w0,	ne
    cmp	w7,	#0
    movz	w22,	#1
    mov	w21,	w22
    csel	w25,	w21,	w0,	ne
    cmp	w18,	#0
    cset	w20,	ne
    cmp	w7,	#0
    movz	w22,	#0
    mov	w21,	w22
    csel	w1,	w20,	w21,	ne
    cmp	w1,	#0
    cset	w6,	eq
    cmp	w6,	#0
    cset	w20,	ne
    cmp	w25,	#0
    movz	w14,	#0
    csel	w27,	w20,	w14,	ne
    str	w27,	[sp, #1076]

    ldr	w2,	[sp, #884]

    cmp	w2,	#0
    ldr	w13,	[sp, #1052]

    cset	w17,	ne
    cmp	w13,	#0
    movz	w1,	#0
    csel	w4,	w17,	w1,	ne
    cmp	w18,	#0
    cset	w24,	ne
    cmp	w7,	#0
    movz	w14,	#0
    csel	w21,	w24,	w14,	ne
    cmp	w21,	#0
    cset	w23,	ne
    cmp	w4,	#0
    movz	w1,	#1
    ldr	w5,	[sp, #1016]

    csel	w6,	w1,	w23,	ne
    cmp	w5,	#0
    cset	w1,	ne
    ldr	w14,	[sp, #1060]

    cmp	w14,	#0
    ldr	w10,	[sp, #1016]

    movz	w0,	#1
    csel	w18,	w0,	w1,	ne
    cmp	w10,	#0
    ldr	w25,	[sp, #1060]

    cset	w1,	ne
    cmp	w25,	#0
    movz	w27,	#0
    csel	w19,	w1,	w27,	ne
    cmp	w19,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w24,	ne
    cmp	w18,	#0
    movz	w23,	#0
    csel	w21,	w24,	w23,	ne
    cmp	w6,	#0
    cset	w22,	ne
    cmp	w21,	#0
    movz	w25,	#1
    csel	w1,	w25,	w22,	ne
    cmp	w6,	#0
    cset	w14,	ne
    cmp	w21,	#0
    movz	w26,	#0
    mov	w25,	w26
    csel	w23,	w14,	w25,	ne
    cmp	w23,	#0
    cset	w22,	eq
    cmp	w22,	#0
    cset	w25,	ne
    cmp	w1,	#0
    movz	w1,	#0
    csel	w24,	w25,	w1,	ne
    str	w24,	[sp, #1072]

    ldr	w11,	[sp, #1016]

    cmp	w11,	#0
    ldr	w24,	[sp, #1060]

    cset	w25,	ne
    cmp	w24,	#0
    movz	w16,	#0
    csel	w0,	w25,	w16,	ne
    cmp	w6,	#0
    cset	w27,	ne
    cmp	w21,	#0
    movz	w16,	#0
    csel	w14,	w27,	w16,	ne
    cmp	w14,	#0
    cset	w16,	ne
    cmp	w0,	#0
    ldr	w9,	[sp, #744]

    movz	w23,	#1
    csel	w12,	w23,	w16,	ne
    cmp	w9,	#0
    cset	w21,	ne
    ldr	w26,	[sp, #836]

    cmp	w26,	#0
    movz	w1,	#1
    ldr	w10,	[sp, #744]

    csel	w26,	w1,	w21,	ne
    cmp	w10,	#0
    cset	w0,	ne
    ldr	w9,	[sp, #836]

    cmp	w9,	#0
    movz	w2,	#0
    csel	w23,	w0,	w2,	ne
    cmp	w23,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w1,	ne
    cmp	w26,	#0
    movz	w0,	#0
    csel	w7,	w1,	w0,	ne
    cmp	w12,	#0
    cset	w17,	ne
    cmp	w7,	#0
    movz	w23,	#1
    csel	w3,	w23,	w17,	ne
    cmp	w12,	#0
    cset	w0,	ne
    cmp	w7,	#0
    movz	w18,	#0
    mov	w17,	w18
    csel	w18,	w0,	w17,	ne
    cmp	w18,	#0
    cset	w17,	eq
    cmp	w17,	#0
    cset	w21,	ne
    cmp	w3,	#0
    movz	w16,	#0
    csel	w20,	w21,	w16,	ne
    str	w20,	[sp, #1068]

    ldr	w11,	[sp, #744]

    cmp	w11,	#0
    cset	w27,	ne
    ldr	w10,	[sp, #836]

    cmp	w10,	#0
    movz	w15,	#0
    csel	w22,	w27,	w15,	ne
    cmp	w12,	#0
    cset	w20,	ne
    cmp	w7,	#0
    movz	w17,	#0
    csel	w24,	w20,	w17,	ne
    cmp	w24,	#0
    cset	w27,	ne
    cmp	w22,	#0
    movz	w23,	#1
    ldr	w25,	[sp, #520]

    csel	w4,	w23,	w27,	ne
    cmp	w25,	#0
    ldr	w14,	[sp, #872]

    cset	w27,	ne
    cmp	w14,	#0
    ldr	w26,	[sp, #520]

    movz	w21,	#1
    csel	w0,	w21,	w27,	ne
    cmp	w26,	#0
    cset	w21,	ne
    ldr	w2,	[sp, #872]

    cmp	w2,	#0
    movz	w3,	#0
    csel	w21,	w21,	w3,	ne
    cmp	w21,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w3,	ne
    cmp	w0,	#0
    movz	w1,	#0
    csel	w13,	w3,	w1,	ne
    cmp	w4,	#0
    cset	w20,	ne
    cmp	w13,	#0
    movz	w0,	#1
    csel	w19,	w0,	w20,	ne
    cmp	w4,	#0
    cset	w27,	ne
    cmp	w13,	#0
    movz	w1,	#0
    csel	w23,	w27,	w1,	ne
    cmp	w23,	#0
    cset	w1,	eq
    cmp	w1,	#0
    cset	w14,	ne
    cmp	w19,	#0
    movz	w19,	#0
    csel	w18,	w14,	w19,	ne
    str	w18,	[sp, #1064]

    ldr	w27,	[sp, #520]

    cmp	w27,	#0
    cset	w27,	ne
    ldr	w1,	[sp, #872]

    cmp	w1,	#0
    movz	w14,	#0
    csel	w2,	w27,	w14,	ne
    cmp	w4,	#0
    cset	w5,	ne
    cmp	w13,	#0
    movz	w1,	#0
    csel	w15,	w5,	w1,	ne
    cmp	w15,	#0
    cset	w20,	ne
    cmp	w2,	#0
    movz	w0,	#1
    ldr	w13,	[sp, #508]

    csel	w2,	w0,	w20,	ne
    cmp	w13,	#0
    ldr	w6,	[sp, #864]

    cset	w14,	ne
    cmp	w6,	#0
    movz	w27,	#1
    csel	w20,	w27,	w14,	ne
    ldr	w14,	[sp, #508]

    cmp	w14,	#0
    cset	w21,	ne
    ldr	w19,	[sp, #864]

    cmp	w19,	#0
    movz	w5,	#0
    csel	w23,	w21,	w5,	ne
    cmp	w23,	#0
    cset	w27,	eq
    cmp	w27,	#0
    cset	w3,	ne
    cmp	w20,	#0
    movz	w7,	#0
    csel	w14,	w3,	w7,	ne
    cmp	w2,	#0
    cset	w5,	ne
    cmp	w14,	#0
    movz	w1,	#1
    csel	w3,	w1,	w5,	ne
    cmp	w2,	#0
    cset	w0,	ne
    cmp	w14,	#0
    movz	w20,	#0
    csel	w5,	w0,	w20,	ne
    cmp	w5,	#0
    cset	w15,	eq
    cmp	w15,	#0
    cset	w21,	ne
    cmp	w3,	#0
    movz	w15,	#0
    ldr	w16,	[sp, #508]

    csel	w4,	w21,	w15,	ne
    cmp	w16,	#0
    ldr	w22,	[sp, #864]

    cset	w1,	ne
    cmp	w22,	#0
    movz	w22,	#0
    csel	w0,	w1,	w22,	ne
    cmp	w2,	#0
    cset	w26,	ne
    cmp	w14,	#0
    movz	w10,	#0
    csel	w1,	w26,	w10,	ne
    cmp	w1,	#0
    cset	w10,	ne
    cmp	w0,	#0
    ldr	w9,	[sp, #504]

    movz	w6,	#1
    csel	w0,	w6,	w10,	ne
    cmp	w9,	#0
    cset	w22,	ne
    ldr	w15,	[sp, #840]

    cmp	w15,	#0
    movz	w1,	#1
    ldr	w10,	[sp, #504]

    csel	w2,	w1,	w22,	ne
    cmp	w10,	#0
    ldr	w17,	[sp, #840]

    cset	w1,	ne
    cmp	w17,	#0
    movz	w16,	#0
    csel	w25,	w1,	w16,	ne
    cmp	w25,	#0
    cset	w16,	eq
    cmp	w16,	#0
    cset	w6,	ne
    cmp	w2,	#0
    movz	w18,	#0
    csel	w18,	w6,	w18,	ne
    cmp	w0,	#0
    cset	w27,	ne
    cmp	w18,	#0
    movz	w6,	#1
    csel	w12,	w6,	w27,	ne
    cmp	w0,	#0
    cset	w10,	ne
    cmp	w18,	#0
    movz	w25,	#0
    csel	w25,	w10,	w25,	ne
    cmp	w25,	#0
    cset	w26,	eq
    cmp	w26,	#0
    cset	w6,	ne
    cmp	w12,	#0
    ldr	w12,	[sp, #504]

    movz	w23,	#0
    csel	w7,	w6,	w23,	ne
    cmp	w12,	#0
    cset	w2,	ne
    ldr	w19,	[sp, #840]

    cmp	w19,	#0
    movz	w26,	#0
    csel	w6,	w2,	w26,	ne
    cmp	w0,	#0
    cset	w19,	ne
    cmp	w18,	#0
    movz	w17,	#0
    csel	w23,	w19,	w17,	ne
    cmp	w23,	#0
    cset	w23,	ne
    cmp	w6,	#0
    ldr	w22,	[sp, #756]

    movz	w16,	#1
    csel	w8,	w16,	w23,	ne
    cmp	w22,	#0
    ldr	w15,	[sp, #860]

    cset	w1,	ne
    cmp	w15,	#0
    ldr	w23,	[sp, #756]

    movz	w14,	#1
    csel	w22,	w14,	w1,	ne
    cmp	w23,	#0
    ldr	w15,	[sp, #860]

    cset	w17,	ne
    cmp	w15,	#0
    movz	w11,	#0
    csel	w26,	w17,	w11,	ne
    cmp	w26,	#0
    cset	w1,	eq
    cmp	w1,	#0
    cset	w11,	ne
    cmp	w22,	#0
    movz	w19,	#0
    csel	w9,	w11,	w19,	ne
    cmp	w8,	#0
    cset	w20,	ne
    cmp	w9,	#0
    movz	w13,	#1
    csel	w1,	w13,	w20,	ne
    cmp	w8,	#0
    cset	w0,	ne
    cmp	w9,	#0
    movz	w22,	#0
    csel	w11,	w0,	w22,	ne
    cmp	w11,	#0
    cset	w16,	eq
    cmp	w16,	#0
    cset	w23,	ne
    cmp	w1,	#0
    ldr	w25,	[sp, #756]

    movz	w19,	#0
    csel	w1,	w23,	w19,	ne
    cmp	w25,	#0
    ldr	w3,	[sp, #860]

    cset	w6,	ne
    cmp	w3,	#0
    movz	w0,	#0
    csel	w12,	w6,	w0,	ne
    cmp	w8,	#0
    cset	w25,	ne
    cmp	w9,	#0
    movz	w23,	#0
    csel	w17,	w25,	w23,	ne
    cmp	w17,	#0
    cset	w3,	ne
    cmp	w12,	#0
    movz	w21,	#1
    ldr	w27,	[sp, #868]

    csel	w11,	w21,	w3,	ne
    cmp	w27,	#0
    cset	w17,	ne
    ldr	w12,	[sp, #856]

    cmp	w12,	#0
    movz	w21,	#1
    ldr	w3,	[sp, #868]

    csel	w21,	w21,	w17,	ne
    cmp	w3,	#0
    cset	w19,	ne
    ldr	w25,	[sp, #856]

    cmp	w25,	#0
    movz	w10,	#0
    csel	w26,	w19,	w10,	ne
    cmp	w26,	#0
    cset	w23,	eq
    cmp	w23,	#0
    cset	w27,	ne
    cmp	w21,	#0
    movz	w0,	#0
    csel	w13,	w27,	w0,	ne
    cmp	w11,	#0
    cset	w12,	ne
    cmp	w13,	#0
    movz	w27,	#1
    csel	w22,	w27,	w12,	ne
    cmp	w11,	#0
    cset	w0,	ne
    cmp	w13,	#0
    movz	w26,	#0
    csel	w23,	w0,	w26,	ne
    cmp	w23,	#0
    cset	w12,	eq
    cmp	w12,	#0
    cset	w14,	ne
    cmp	w22,	#0
    movz	w0,	#0
    csel	w17,	w14,	w0,	ne
    lsl	w18,	w17,	#1
    add	w13,	w18,	w1
    lsl	w14,	w13,	#1
    add	w12,	w14,	w7
    lsl	w13,	w12,	#1
    add	w10,	w13,	w4
    lsl	w11,	w10,	#1
    ldr	w10,	[sp, #1064]

    ldr	w15,	[sp, #1068]

    add	w3,	w11,	w10
    ldr	w16,	[sp, #1072]

    lsl	w5,	w3,	#1
    add	w21,	w5,	w15
    lsl	w23,	w21,	#1
    ldr	w21,	[sp, #1076]

    add	w14,	w23,	w16
    ldr	w22,	[sp, #1080]

    lsl	w15,	w14,	#1
    add	w25,	w15,	w21
    lsl	w27,	w25,	#1
    add	w9,	w27,	w22
    ldr	w27,	[sp, #1084]

    ldr	w1,	[sp, #1088]

    lsl	w10,	w9,	#1
    ldr	w4,	[sp, #1092]

    ldr	w7,	[sp, #1096]

    add	w12,	w10,	w27
    ldr	w13,	[sp, #1104]

    lsl	w14,	w12,	#1
    add	w16,	w14,	w1
    lsl	w17,	w16,	#1
    add	w10,	w17,	w4
    lsl	w11,	w10,	#1
    add	w12,	w11,	w7
    lsl	w14,	w12,	#1
    add	w10,	w14,	w13
    lsl	w11,	w10,	#1
    ldr	w10,	[sp, #1100]

    add	w5,	w11,	w10
    lsl	w6,	w5,	#1
    add	w0,	w6,	w28
    b	fib_1892

fib_1891:
    movz	w0,	#1

fib_1892:
    movz	w18,	#1
    ldr	x20,	[sp, #136]

    str	w18,	[x20]

    ldr	x4,	[sp, #128]

    ldr	w2,	[sp, #152]

    str	w2,	[x4]

    ldr	x14,	[sp, #144]

    add	x12,	x14,	#4
    str	w0,	[x12]

    ldp	x19, x20, [sp, #0]
    ldp	x21, x22, [sp, #16]
    ldp	x23, x24, [sp, #32]
    ldp	x25, x26, [sp, #48]
    ldp	x27, x28, [sp, #64]
    ldp	fp, lr, [sp, #80]
    
    add	sp, sp, #1344
    ret


.globl main
main:
main_0:
    sub	sp, sp, #16
    stp	fp, lr, [sp, #0]
    
    movz	w20,	#1

main_1:
    cmp	w20,	#16
    bge	main_23

main_4:
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w20
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w20
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w23,	w20,	#1
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w23
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w23
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w25,	w23,	#1
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w25
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w25
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#102
    add	w27,	w25,	#1
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w27
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w27
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#102
    add	w19,	w27,	#1
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w19
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w19
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    movz	w0,	#102
    add	w21,	w19,	#1
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w21
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w21
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w23,	w21,	#1
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w23
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w23
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w25,	w23,	#1
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w25
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w25
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w20,	w25,	#1
    b	main_1

main_23:
    movz	w0,	#102
    bl	putch
    movz	w0,	#105
    bl	putch
    movz	w0,	#98
    bl	putch
    movz	w0,	#40
    bl	putch
    mov	w0,	w20
    bl	putint
    movz	w0,	#41
    bl	putch
    movz	w0,	#32
    bl	putch
    movz	w0,	#61
    bl	putch
    movz	w0,	#32
    bl	putch
    mov	w0,	w20
    bl	fib
    bl	putint
    movz	w0,	#10
    bl	putch
    add	w20,	w20,	#1
    cmp	w20,	#20
    ble	main_23

main_28:
    movz	w0,	#0
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #16
    ret


