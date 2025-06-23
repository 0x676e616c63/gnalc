.arch armv8-a
.cpu cortex-a53
.arch_extension crypto

.data

.text

.globl main
main:
main_0:
    sub	sp, sp, #368
    stp	fp, lr, [sp, #0]
    
    bl	getint
    str	w0,	[sp, #20]

    ldr	w20,	[sp, #20]

    add	w28,	w20,	#18
    str	w28,	[sp, #156]

    bl	getint
    str	w0,	[sp, #80]

    bl	getint
    str	w0,	[sp, #84]

    bl	getint
    str	w0,	[sp, #96]

    bl	getint
    str	w0,	[sp, #88]

    ldr	w26,	[sp, #80]

    add	w20,	w26,	#2
    str	w20,	[sp, #100]

    ldr	w21,	[sp, #100]

    add	w24,	w21,	#1
    str	w24,	[sp, #52]

    ldr	w18,	[sp, #84]

    add	w24,	w18,	#4
    str	w24,	[sp, #104]

    ldr	w25,	[sp, #104]

    add	w28,	w25,	#2
    str	w28,	[sp, #56]

    ldr	w0,	[sp, #96]

    add	w19,	w0,	#6
    str	w19,	[sp, #112]

    ldr	w20,	[sp, #112]

    add	w23,	w20,	#3
    str	w23,	[sp, #64]

    ldr	w0,	[sp, #88]

    add	w23,	w0,	#8
    str	w23,	[sp, #116]

    ldr	w24,	[sp, #116]

    add	w27,	w24,	#4
    str	w27,	[sp, #68]

    ldr	w25,	[sp, #52]

    add	w24,	w25,	#6
    str	w24,	[sp, #176]

    ldr	w0,	[sp, #56]

    add	w20,	w0,	#8
    str	w20,	[sp, #172]

    ldr	w24,	[sp, #64]

    add	w25,	w24,	#10
    str	w25,	[sp, #40]

    ldr	w28,	[sp, #68]

    add	w0,	w28,	#12
    str	w0,	[sp, #44]

    ldr	w25,	[sp, #176]

    add	w28,	w25,	#10
    str	w28,	[sp, #168]

    ldr	w21,	[sp, #172]

    add	w24,	w21,	#12
    str	w24,	[sp, #164]

    ldr	w26,	[sp, #40]

    add	w20,	w26,	#14
    str	w20,	[sp, #160]

    ldr	w18,	[sp, #44]

    add	w25,	w18,	#16
    str	w25,	[sp, #240]

    ldr	w0,	[sp, #168]

    add	w18,	w0,	#15
    str	w18,	[sp, #124]

    ldr	w19,	[sp, #124]

    add	w21,	w19,	#1
    str	w21,	[sp, #236]

    ldr	w25,	[sp, #164]

    add	w0,	w25,	#18
    str	w0,	[sp, #128]

    ldr	w23,	[sp, #128]

    add	w0,	w23,	#2
    str	w0,	[sp, #232]

    ldr	w21,	[sp, #160]

    add	w26,	w21,	#21
    str	w26,	[sp, #132]

    ldr	w27,	[sp, #132]

    add	w23,	w27,	#3
    str	w23,	[sp, #24]

    ldr	w26,	[sp, #240]

    add	w18,	w26,	#24
    str	w18,	[sp, #136]

    ldr	w19,	[sp, #136]

    add	w27,	w19,	#4
    str	w27,	[sp, #28]

    ldr	w22,	[sp, #236]

    add	w0,	w22,	#15
    str	w0,	[sp, #140]

    ldr	w18,	[sp, #232]

    add	w26,	w18,	#18
    str	w26,	[sp, #144]

    ldr	w24,	[sp, #24]

    add	w18,	w24,	#21
    str	w18,	[sp, #148]

    ldr	w28,	[sp, #28]

    add	w0,	w28,	#24
    str	w0,	[sp, #152]

    ldr	w23,	[sp, #140]

    add	w22,	w23,	#1
    str	w22,	[sp, #288]

    ldr	w27,	[sp, #144]

    add	w22,	w27,	#2
    str	w22,	[sp, #296]

    ldr	w19,	[sp, #148]

    add	w19,	w19,	#3
    str	w19,	[sp, #292]

    ldr	w23,	[sp, #152]

    add	w28,	w23,	#4
    str	w28,	[sp, #16]

    ldr	w24,	[sp, #20]

    ldr	w18,	[sp, #156]

    sub	w28,	w24,	w18
    add	w28,	w28,	#10
    str	w28,	[sp, #180]

    ldr	w23,	[sp, #288]

    add	w27,	w23,	#13
    str	w27,	[sp, #120]

    ldr	w23,	[sp, #296]

    add	w28,	w23,	#14
    str	w28,	[sp, #108]

    ldr	w20,	[sp, #292]

    add	w25,	w20,	#15
    str	w25,	[sp, #92]

    ldr	w0,	[sp, #16]

    add	w0,	w0,	#16
    str	w0,	[sp, #76]

    ldr	w23,	[sp, #236]

    add	w19,	w23,	#5
    str	w19,	[sp, #72]

    ldr	w19,	[sp, #232]

    add	w20,	w19,	#6
    str	w20,	[sp, #60]

    ldr	w25,	[sp, #24]

    add	w21,	w25,	#7
    str	w21,	[sp, #48]

    ldr	w0,	[sp, #28]

    add	w0,	w0,	#8
    str	w0,	[sp, #36]

    ldr	w18,	[sp, #168]

    add	w19,	w18,	#13
    str	w19,	[sp, #284]

    ldr	w26,	[sp, #164]

    add	w22,	w26,	#14
    str	w22,	[sp, #272]

    ldr	w22,	[sp, #160]

    add	w28,	w22,	#15
    str	w28,	[sp, #280]

    ldr	w27,	[sp, #240]

    add	w25,	w27,	#16
    str	w25,	[sp, #276]

    ldr	w26,	[sp, #176]

    add	w28,	w26,	#9
    str	w28,	[sp, #320]

    ldr	w22,	[sp, #172]

    add	w19,	w22,	#10
    str	w19,	[sp, #324]

    ldr	w27,	[sp, #40]

    add	w22,	w27,	#11
    str	w22,	[sp, #312]

    ldr	w19,	[sp, #44]

    add	w25,	w19,	#12
    str	w25,	[sp, #316]

    ldr	w26,	[sp, #52]

    add	w19,	w26,	#5
    str	w19,	[sp, #32]

    ldr	w18,	[sp, #56]

    add	w25,	w18,	#6
    str	w25,	[sp, #300]

    ldr	w25,	[sp, #64]

    add	w28,	w25,	#7
    str	w28,	[sp, #304]

    ldr	w0,	[sp, #68]

    add	w19,	w0,	#8
    str	w19,	[sp, #308]

    ldr	w18,	[sp, #80]

    ldr	w0,	[sp, #180]

    ldr	w23,	[sp, #84]

    add	w0,	w0,	w18
    add	w26,	w0,	w23
    ldr	w23,	[sp, #96]

    ldr	w27,	[sp, #88]

    add	w20,	w26,	w23
    add	w20,	w20,	w27
    ldr	w27,	[sp, #100]

    sub	w22,	w20,	w27
    ldr	w20,	[sp, #104]

    ldr	w27,	[sp, #112]

    sub	w23,	w22,	w20
    ldr	w19,	[sp, #116]

    sub	w26,	w23,	w27
    sub	w22,	w26,	w19
    ldr	w19,	[sp, #32]

    ldr	w26,	[sp, #300]

    add	w27,	w19,	w22
    ldr	w0,	[sp, #304]

    ldr	w20,	[sp, #308]

    add	w21,	w26,	w27
    add	w23,	w0,	w21
    ldr	w0,	[sp, #320]

    add	w24,	w23,	w20
    ldr	w20,	[sp, #324]

    ldr	w23,	[sp, #312]

    sub	w25,	w24,	w0
    ldr	w26,	[sp, #316]

    sub	w27,	w25,	w20
    sub	w20,	w27,	w23
    sub	w23,	w20,	w26
    ldr	w20,	[sp, #284]

    add	w24,	w20,	w23
    ldr	w23,	[sp, #272]

    ldr	w0,	[sp, #280]

    add	w25,	w23,	w24
    ldr	w26,	[sp, #276]

    add	w27,	w0,	w25
    add	w0,	w27,	w26
    ldr	w27,	[sp, #124]

    ldr	w21,	[sp, #128]

    sub	w20,	w0,	w27
    ldr	w0,	[sp, #132]

    ldr	w28,	[sp, #136]

    sub	w24,	w20,	w21
    sub	w0,	w24,	w0
    ldr	w24,	[sp, #72]

    sub	w18,	w0,	w28
    add	w19,	w24,	w18
    ldr	w24,	[sp, #60]

    add	w20,	w24,	w19
    ldr	w24,	[sp, #48]

    ldr	w23,	[sp, #36]

    add	w21,	w24,	w20
    add	w24,	w21,	w23
    ldr	w21,	[sp, #140]

    sub	w26,	w24,	w21
    ldr	w24,	[sp, #144]

    ldr	w0,	[sp, #148]

    sub	w21,	w26,	w24
    ldr	w22,	[sp, #152]

    sub	w24,	w21,	w0
    sub	w19,	w24,	w22
    ldr	w24,	[sp, #120]

    ldr	w23,	[sp, #108]

    add	w27,	w24,	w19
    ldr	w19,	[sp, #92]

    ldr	w26,	[sp, #76]

    add	w28,	w23,	w27
    add	w0,	w19,	w28
    add	w18,	w0,	w26
    add	w19,	w18,	#1
    sub	w20,	w19,	#2
    add	w21,	w20,	#3
    sub	w0,	w21,	#4
    add	w23,	w0,	#5
    sub	w24,	w23,	#6
    add	w25,	w24,	#7
    sub	w26,	w25,	#8
    add	w27,	w26,	#9
    sub	w28,	w27,	#10
    add	w0,	w28,	#11
    sub	w18,	w0,	#12
    add	w19,	w18,	#13
    sub	w20,	w19,	#14
    add	w21,	w20,	#15
    sub	w0,	w21,	#16
    add	w23,	w0,	#1
    sub	w24,	w23,	#2
    add	w25,	w24,	#3
    sub	w26,	w25,	#4
    add	w27,	w26,	#5
    sub	w28,	w27,	#6
    add	w0,	w28,	#7
    sub	w18,	w0,	#8
    add	w19,	w18,	#9
    sub	w20,	w19,	#10
    add	w21,	w20,	#11
    sub	w0,	w21,	#12
    add	w23,	w0,	#13
    sub	w24,	w23,	#14
    add	w25,	w24,	#15
    sub	w26,	w25,	#16
    mov	w0,	w26
    bl	putint
    mov	w0,	w26
    ldp	fp, lr, [sp, #0]
    
    add	sp, sp, #368
    ret


