	.text
	.syntax unified
	.eabi_attribute	67, "2.09"	@ Tag_conformance
	.eabi_attribute	6, 10	@ Tag_CPU_arch
	.eabi_attribute	7, 65	@ Tag_CPU_arch_profile
	.eabi_attribute	8, 1	@ Tag_ARM_ISA_use
	.eabi_attribute	9, 2	@ Tag_THUMB_ISA_use
	.fpu	vfpv3-d16
	.eabi_attribute	34, 1	@ Tag_CPU_unaligned_access
	.eabi_attribute	15, 1	@ Tag_ABI_PCS_RW_data
	.eabi_attribute	16, 1	@ Tag_ABI_PCS_RO_data
	.eabi_attribute	17, 2	@ Tag_ABI_PCS_GOT_use
	.eabi_attribute	20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute	21, 0	@ Tag_ABI_FP_exceptions
	.eabi_attribute	23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute	24, 1	@ Tag_ABI_align_needed
	.eabi_attribute	25, 1	@ Tag_ABI_align_preserved
	.eabi_attribute	28, 1	@ Tag_ABI_VFP_args
	.eabi_attribute	38, 1	@ Tag_ABI_FP_16bit_format
	.eabi_attribute	18, 4	@ Tag_ABI_PCS_wchar_t
	.eabi_attribute	26, 2	@ Tag_ABI_enum_size
	.eabi_attribute	14, 0	@ Tag_ABI_PCS_R9_use
	.file	"sylib.c"
	.globl	getint                          @ -- Begin function getint
	.p2align	2
	.type	getint,%function
	.code	32                              @ @getint
getint:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	ldr	r0, .LCPI0_0
.LPC0_0:
	add	r0, pc, r0
	add	r1, sp, #4
	bl	__isoc99_scanf
	ldr	r0, [sp, #4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI0_0:
	.long	.L.str-(.LPC0_0+8)
.Lfunc_end0:
	.size	getint, .Lfunc_end0-getint
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	getch                           @ -- Begin function getch
	.p2align	2
	.type	getch,%function
	.code	32                              @ @getch
getch:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	ldr	r0, .LCPI1_0
.LPC1_0:
	add	r0, pc, r0
	sub	r1, r11, #1
	bl	__isoc99_scanf
	ldrb	r0, [r11, #-1]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI1_0:
	.long	.L.str.1-(.LPC1_0+8)
.Lfunc_end1:
	.size	getch, .Lfunc_end1-getch
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	getfloat                        @ -- Begin function getfloat
	.p2align	2
	.type	getfloat,%function
	.code	32                              @ @getfloat
getfloat:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	ldr	r0, .LCPI2_0
.LPC2_0:
	add	r0, pc, r0
	add	r1, sp, #4
	bl	__isoc99_scanf
	vldr	s0, [sp, #4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI2_0:
	.long	.L.str.2-(.LPC2_0+8)
.Lfunc_end2:
	.size	getfloat, .Lfunc_end2-getfloat
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	getarray                        @ -- Begin function getarray
	.p2align	2
	.type	getarray,%function
	.code	32                              @ @getarray
getarray:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	str	r0, [r11, #-4]
	ldr	r0, .LCPI3_0
.LPC3_0:
	add	r0, pc, r0
	add	r1, sp, #8
	bl	__isoc99_scanf
	movw	r0, #0
	str	r0, [sp, #4]
.LBB3_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #8]
	cmp	r0, r1
	bge	.LBB3_4
@ %bb.2:                                @   in Loop: Header=BB3_1 Depth=1
	ldr	r0, [r11, #-4]
	ldr	r1, [sp, #4]
	add	r1, r0, r1, lsl #2
	ldr	r0, .LCPI3_1
.LPC3_1:
	add	r0, pc, r0
	bl	__isoc99_scanf
@ %bb.3:                                @   in Loop: Header=BB3_1 Depth=1
	ldr	r0, [sp, #4]
	add	r0, r0, #1
	str	r0, [sp, #4]
	b	.LBB3_1
.LBB3_4:
	ldr	r0, [sp, #8]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.5:
.LCPI3_0:
	.long	.L.str-(.LPC3_0+8)
.LCPI3_1:
	.long	.L.str-(.LPC3_1+8)
.Lfunc_end3:
	.size	getarray, .Lfunc_end3-getarray
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	getfarray                       @ -- Begin function getfarray
	.p2align	2
	.type	getfarray,%function
	.code	32                              @ @getfarray
getfarray:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	str	r0, [r11, #-4]
	ldr	r0, .LCPI4_0
.LPC4_0:
	add	r0, pc, r0
	add	r1, sp, #8
	bl	__isoc99_scanf
	movw	r0, #0
	str	r0, [sp, #4]
.LBB4_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #8]
	cmp	r0, r1
	bge	.LBB4_4
@ %bb.2:                                @   in Loop: Header=BB4_1 Depth=1
	ldr	r0, [r11, #-4]
	ldr	r1, [sp, #4]
	add	r1, r0, r1, lsl #2
	ldr	r0, .LCPI4_1
.LPC4_1:
	add	r0, pc, r0
	bl	__isoc99_scanf
@ %bb.3:                                @   in Loop: Header=BB4_1 Depth=1
	ldr	r0, [sp, #4]
	add	r0, r0, #1
	str	r0, [sp, #4]
	b	.LBB4_1
.LBB4_4:
	ldr	r0, [sp, #8]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.5:
.LCPI4_0:
	.long	.L.str-(.LPC4_0+8)
.LCPI4_1:
	.long	.L.str.2-(.LPC4_1+8)
.Lfunc_end4:
	.size	getfarray, .Lfunc_end4-getfarray
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	putint                          @ -- Begin function putint
	.p2align	2
	.type	putint,%function
	.code	32                              @ @putint
putint:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	str	r0, [sp, #4]
	ldr	r1, [sp, #4]
	ldr	r0, .LCPI5_0
.LPC5_0:
	add	r0, pc, r0
	bl	printf
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI5_0:
	.long	.L.str-(.LPC5_0+8)
.Lfunc_end5:
	.size	putint, .Lfunc_end5-putint
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	putch                           @ -- Begin function putch
	.p2align	2
	.type	putch,%function
	.code	32                              @ @putch
putch:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	str	r0, [sp, #4]
	ldr	r1, [sp, #4]
	ldr	r0, .LCPI6_0
.LPC6_0:
	add	r0, pc, r0
	bl	printf
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI6_0:
	.long	.L.str.1-(.LPC6_0+8)
.Lfunc_end6:
	.size	putch, .Lfunc_end6-putch
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	putarray                        @ -- Begin function putarray
	.p2align	2
	.type	putarray,%function
	.code	32                              @ @putarray
putarray:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	str	r0, [r11, #-4]
	str	r1, [sp, #8]
	ldr	r1, [r11, #-4]
	ldr	r0, .LCPI7_0
.LPC7_0:
	add	r0, pc, r0
	bl	printf
	movw	r0, #0
	str	r0, [sp, #4]
.LBB7_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #4]
	ldr	r1, [r11, #-4]
	cmp	r0, r1
	bge	.LBB7_4
@ %bb.2:                                @   in Loop: Header=BB7_1 Depth=1
	ldr	r0, [sp, #8]
	ldr	r1, [sp, #4]
	add	r0, r0, r1, lsl #2
	ldr	r1, [r0]
	ldr	r0, .LCPI7_2
.LPC7_2:
	add	r0, pc, r0
	bl	printf
@ %bb.3:                                @   in Loop: Header=BB7_1 Depth=1
	ldr	r0, [sp, #4]
	add	r0, r0, #1
	str	r0, [sp, #4]
	b	.LBB7_1
.LBB7_4:
	ldr	r0, .LCPI7_1
.LPC7_1:
	add	r0, pc, r0
	bl	printf
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.5:
.LCPI7_0:
	.long	.L.str.3-(.LPC7_0+8)
.LCPI7_1:
	.long	.L.str.5-(.LPC7_1+8)
.LCPI7_2:
	.long	.L.str.4-(.LPC7_2+8)
.Lfunc_end7:
	.size	putarray, .Lfunc_end7-putarray
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	putfloat                        @ -- Begin function putfloat
	.p2align	2
	.type	putfloat,%function
	.code	32                              @ @putfloat
putfloat:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	vstr	s0, [sp, #4]
	vldr	s0, [sp, #4]
	vcvt.f64.f32	d0, s0
	ldr	r0, .LCPI8_0
.LPC8_0:
	add	r0, pc, r0
	vmov	r2, r3, d0
	bl	printf
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI8_0:
	.long	.L.str.2-(.LPC8_0+8)
.Lfunc_end8:
	.size	putfloat, .Lfunc_end8-putfloat
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	putfarray                       @ -- Begin function putfarray
	.p2align	2
	.type	putfarray,%function
	.code	32                              @ @putfarray
putfarray:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	str	r0, [r11, #-4]
	str	r1, [sp, #8]
	ldr	r1, [r11, #-4]
	ldr	r0, .LCPI9_0
.LPC9_0:
	add	r0, pc, r0
	bl	printf
	movw	r0, #0
	str	r0, [sp, #4]
.LBB9_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #4]
	ldr	r1, [r11, #-4]
	cmp	r0, r1
	bge	.LBB9_4
@ %bb.2:                                @   in Loop: Header=BB9_1 Depth=1
	ldr	r0, [sp, #8]
	ldr	r1, [sp, #4]
	add	r0, r0, r1, lsl #2
	vldr	s0, [r0]
	vcvt.f64.f32	d0, s0
	ldr	r0, .LCPI9_2
.LPC9_2:
	add	r0, pc, r0
	vmov	r2, r3, d0
	bl	printf
@ %bb.3:                                @   in Loop: Header=BB9_1 Depth=1
	ldr	r0, [sp, #4]
	add	r0, r0, #1
	str	r0, [sp, #4]
	b	.LBB9_1
.LBB9_4:
	ldr	r0, .LCPI9_1
.LPC9_1:
	add	r0, pc, r0
	bl	printf
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.5:
.LCPI9_0:
	.long	.L.str.3-(.LPC9_0+8)
.LCPI9_1:
	.long	.L.str.5-(.LPC9_1+8)
.LCPI9_2:
	.long	.L.str.6-(.LPC9_2+8)
.Lfunc_end9:
	.size	putfarray, .Lfunc_end9-putfarray
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	putf                            @ -- Begin function putf
	.p2align	2
	.type	putf,%function
	.code	32                              @ @putf
putf:
	.fnstart
@ %bb.0:
	.pad	#12
	sub	sp, sp, #12
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#12
	sub	sp, sp, #12
	str	r3, [r11, #16]
	str	r2, [r11, #12]
	str	r1, [r11, #8]
	str	r0, [r11, #-4]
	add	r0, r11, #8
	str	r0, [sp, #4]
	ldr	r0, .LCPI10_0
.LPC10_0:
	ldr	r0, [pc, r0]
	ldr	r0, [r0]
	ldr	r1, [r11, #-4]
	ldr	r2, [sp, #4]
	bl	vfprintf
	mov	sp, r11
	pop	{r11, lr}
	add	sp, sp, #12
	bx	lr
	.p2align	2
@ %bb.1:
.LCPI10_0:
.Ltmp0:
	.long	stdout(GOT_PREL)-((.LPC10_0+8)-.Ltmp0)
.Lfunc_end10:
	.size	putf, .Lfunc_end10-putf
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	before_main                     @ -- Begin function before_main
	.p2align	2
	.type	before_main,%function
	.code	32                              @ @before_main
before_main:
	.fnstart
@ %bb.0:
	.pad	#4
	sub	sp, sp, #4
	movw	r0, #0
	str	r0, [sp]
.LBB11_1:                               @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp]
	cmp	r0, #1024
	bge	.LBB11_4
@ %bb.2:                                @   in Loop: Header=BB11_1 Depth=1
	ldr	r0, .LCPI11_1
.LPC11_1:
	add	r0, pc, r0
	ldr	r2, [sp]
	ldr	r1, .LCPI11_2
.LPC11_2:
	add	r1, pc, r1
	mov	r0, #0
	str	r0, [r1, r2, lsl #2]
	ldr	r2, [sp]
	ldr	r1, .LCPI11_3
.LPC11_3:
	add	r1, pc, r1
	str	r0, [r1, r2, lsl #2]
	ldr	r2, [sp]
	ldr	r1, .LCPI11_4
.LPC11_4:
	add	r1, pc, r1
	str	r0, [r1, r2, lsl #2]
	ldr	r1, [sp]
	ldr	r0, .LCPI11_5
.LPC11_5:
	add	r0, pc, r0
	add	r1, r0, r1, lsl #2
	movw	r0, #0
	str	r0, [r1]
@ %bb.3:                                @   in Loop: Header=BB11_1 Depth=1
	ldr	r0, [sp]
	add	r0, r0, #1
	str	r0, [sp]
	b	.LBB11_1
.LBB11_4:
	movw	r0, #1
	ldr	r1, .LCPI11_0
.LPC11_0:
	add	r1, pc, r1
	str	r0, [r1]
	add	sp, sp, #4
	bx	lr
	.p2align	2
@ %bb.5:
.LCPI11_0:
	.long	_sysy_idx-(.LPC11_0+8)
.LCPI11_1:
	.long	_sysy_h-(.LPC11_1+8)
.LCPI11_2:
	.long	_sysy_us-(.LPC11_2+8)
.LCPI11_3:
	.long	_sysy_s-(.LPC11_3+8)
.LCPI11_4:
	.long	_sysy_m-(.LPC11_4+8)
.LCPI11_5:
	.long	_sysy_h-(.LPC11_5+8)
.Lfunc_end11:
	.size	before_main, .Lfunc_end11-before_main
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	after_main                      @ -- Begin function after_main
	.p2align	2
	.type	after_main,%function
	.code	32                              @ @after_main
after_main:
	.fnstart
@ %bb.0:
	.save	{r4, r5, r11, lr}
	push	{r4, r5, r11, lr}
	.setfp	r11, sp, #8
	add	r11, sp, #8
	.pad	#40
	sub	sp, sp, #40
	movw	r0, #1
	str	r0, [r11, #-12]
.LBB12_1:                               @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-12]
	ldr	r1, .LCPI12_0
.LPC12_0:
	add	r1, pc, r1
	ldr	r1, [r1]
	cmp	r0, r1
	bge	.LBB12_4
@ %bb.2:                                @   in Loop: Header=BB12_1 Depth=1
	ldr	r0, .LCPI12_8
.LPC12_8:
	ldr	r0, [pc, r0]
	ldr	r0, [r0]
	ldr	r5, [r11, #-12]
	ldr	r1, .LCPI12_9
.LPC12_9:
	add	r1, pc, r1
	ldr	r2, [r1, r5, lsl #2]
	ldr	r1, .LCPI12_10
.LPC12_10:
	add	r1, pc, r1
	ldr	r3, [r1, r5, lsl #2]
	ldr	r1, .LCPI12_11
.LPC12_11:
	add	r1, pc, r1
	str	r1, [r11, #-16]                 @ 4-byte Spill
	ldr	r1, [r1, r5, lsl #2]
	ldr	r12, .LCPI12_12
.LPC12_12:
	add	r12, pc, r12
	str	r12, [sp, #24]                  @ 4-byte Spill
	ldr	lr, [r12, r5, lsl #2]
	ldr	r12, .LCPI12_13
.LPC12_13:
	add	r12, pc, r12
	str	r12, [r11, #-20]                @ 4-byte Spill
	ldr	r4, [r12, r5, lsl #2]
	ldr	r12, .LCPI12_14
.LPC12_14:
	add	r12, pc, r12
	str	r12, [sp, #20]                  @ 4-byte Spill
	ldr	r5, [r12, r5, lsl #2]
	mov	r12, sp
	str	r5, [r12, #12]
	str	r4, [r12, #8]
	str	lr, [r12, #4]
	str	r1, [r12]
	ldr	r1, .LCPI12_15
.LPC12_15:
	add	r1, pc, r1
	bl	fprintf
	ldr	r12, [sp, #20]                  @ 4-byte Reload
	ldr	r1, [sp, #24]                   @ 4-byte Reload
	ldr	r3, [r11, #-20]                 @ 4-byte Reload
	ldr	r2, [r11, #-16]                 @ 4-byte Reload
	ldr	r0, [r11, #-12]
	ldr	lr, [r12, r0, lsl #2]
	ldr	r0, .LCPI12_16
.LPC12_16:
	ldr	r0, [pc, r0]
	add	r0, r0, lr
	str	r0, [r12]
	ldr	r0, [r11, #-12]
	ldr	lr, [r3, r0, lsl #2]
	ldr	r0, .LCPI12_17
.LPC12_17:
	ldr	r0, [pc, r0]
	add	r0, r0, lr
	str	r0, [r3]
	ldr	r0, .LCPI12_18
.LPC12_18:
	ldr	r0, [pc, r0]
	movw	lr, #56963
	movt	lr, #17179
	smmul	r4, r0, lr
	asr	lr, r4, #18
	add	lr, lr, r4, lsr #31
	movw	r4, #15625
	smulbb	lr, lr, r4
	sub	r0, r0, lr, lsl #6
	str	r0, [r12]
	ldr	r0, [r11, #-12]
	ldr	r12, [r1, r0, lsl #2]
	ldr	r0, .LCPI12_19
.LPC12_19:
	ldr	r0, [pc, r0]
	add	r0, r0, r12
	str	r0, [r1]
	ldr	r0, .LCPI12_20
.LPC12_20:
	ldr	r0, [pc, r0]
	movw	r1, #34953
	movt	r1, #34952
	smmla	lr, r0, r1, r0
	asr	r12, lr, #5
	add	r12, r12, lr, lsr #31
	rsb	r12, r12, r12, lsl #4
	sub	r0, r0, r12, lsl #2
	str	r0, [r3]
	ldr	r0, [r11, #-12]
	ldr	r3, [r2, r0, lsl #2]
	ldr	r0, .LCPI12_21
.LPC12_21:
	ldr	r0, [pc, r0]
	add	r0, r0, r3
	str	r0, [r2]
	ldr	r0, .LCPI12_22
.LPC12_22:
	ldr	r0, [pc, r0]
	smmla	r2, r0, r1, r0
	asr	r1, r2, #5
	add	r1, r1, r2, lsr #31
	rsb	r1, r1, r1, lsl #4
	sub	r0, r0, r1, lsl #2
	ldr	r1, .LCPI12_7
.LPC12_7:
	add	r1, pc, r1
	str	r0, [r1]
@ %bb.3:                                @   in Loop: Header=BB12_1 Depth=1
	ldr	r0, [r11, #-12]
	add	r0, r0, #1
	str	r0, [r11, #-12]
	b	.LBB12_1
.LBB12_4:
	ldr	r0, .LCPI12_6
.LPC12_6:
	ldr	r0, [pc, r0]
	ldr	r0, [r0]
	ldr	r1, .LCPI12_5
.LPC12_5:
	add	r1, pc, r1
	ldr	r2, [r1]
	ldr	r1, .LCPI12_4
.LPC12_4:
	add	r1, pc, r1
	ldr	r3, [r1]
	ldr	r1, .LCPI12_3
.LPC12_3:
	add	r1, pc, r1
	ldr	lr, [r1]
	ldr	r1, .LCPI12_2
.LPC12_2:
	add	r1, pc, r1
	ldr	r12, [r1]
	ldr	r1, .LCPI12_1
.LPC12_1:
	add	r1, pc, r1
	str	lr, [sp]
	str	r12, [sp, #4]
	bl	fprintf
	sub	sp, r11, #8
	pop	{r4, r5, r11, pc}
	.p2align	2
@ %bb.5:
.LCPI12_0:
	.long	_sysy_idx-(.LPC12_0+8)
.LCPI12_1:
	.long	.L.str.8-(.LPC12_1+8)
.LCPI12_2:
	.long	_sysy_us-(.LPC12_2+8)
.LCPI12_3:
	.long	_sysy_s-(.LPC12_3+8)
.LCPI12_4:
	.long	_sysy_m-(.LPC12_4+8)
.LCPI12_5:
	.long	_sysy_h-(.LPC12_5+8)
.LCPI12_6:
.Ltmp1:
	.long	stderr(GOT_PREL)-((.LPC12_6+8)-.Ltmp1)
.LCPI12_7:
	.long	_sysy_m-(.LPC12_7+8)
.LCPI12_8:
.Ltmp2:
	.long	stderr(GOT_PREL)-((.LPC12_8+8)-.Ltmp2)
.LCPI12_9:
	.long	_sysy_l1-(.LPC12_9+8)
.LCPI12_10:
	.long	_sysy_l2-(.LPC12_10+8)
.LCPI12_11:
	.long	_sysy_h-(.LPC12_11+8)
.LCPI12_12:
	.long	_sysy_m-(.LPC12_12+8)
.LCPI12_13:
	.long	_sysy_s-(.LPC12_13+8)
.LCPI12_14:
	.long	_sysy_us-(.LPC12_14+8)
.LCPI12_15:
	.long	.L.str.7-(.LPC12_15+8)
.LCPI12_16:
	.long	_sysy_us-(.LPC12_16+8)
.LCPI12_17:
	.long	_sysy_s-(.LPC12_17+8)
.LCPI12_18:
	.long	_sysy_us-(.LPC12_18+8)
.LCPI12_19:
	.long	_sysy_m-(.LPC12_19+8)
.LCPI12_20:
	.long	_sysy_s-(.LPC12_20+8)
.LCPI12_21:
	.long	_sysy_h-(.LPC12_21+8)
.LCPI12_22:
	.long	_sysy_m-(.LPC12_22+8)
.Lfunc_end12:
	.size	after_main, .Lfunc_end12-after_main
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_sysy_starttime                 @ -- Begin function _sysy_starttime
	.p2align	2
	.type	_sysy_starttime,%function
	.code	32                              @ @_sysy_starttime
_sysy_starttime:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	ldr	r1, .LCPI13_1
.LPC13_1:
	add	r1, pc, r1
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	ldr	r2, .LCPI13_2
.LPC13_2:
	ldr	r2, [pc, r2]
	ldr	r1, .LCPI13_3
.LPC13_3:
	add	r1, pc, r1
	add	r1, r1, r2, lsl #2
	str	r0, [r1]
	ldr	r0, .LCPI13_0
.LPC13_0:
	add	r0, pc, r0
	movw	r1, #0
	bl	gettimeofday
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI13_0:
	.long	_sysy_start-(.LPC13_0+8)
.LCPI13_1:
	.long	_sysy_l1-(.LPC13_1+8)
.LCPI13_2:
	.long	_sysy_idx-(.LPC13_2+8)
.LCPI13_3:
	.long	_sysy_l1-(.LPC13_3+8)
.Lfunc_end13:
	.size	_sysy_starttime, .Lfunc_end13-_sysy_starttime
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_sysy_stoptime                  @ -- Begin function _sysy_stoptime
	.p2align	2
	.type	_sysy_stoptime,%function
	.code	32                              @ @_sysy_stoptime
_sysy_stoptime:
	.fnstart
@ %bb.0:
	.save	{r4, r10, r11, lr}
	push	{r4, r10, r11, lr}
	.setfp	r11, sp, #8
	add	r11, sp, #8
	.pad	#8
	sub	sp, sp, #8
	str	r0, [sp, #4]
	ldr	r0, .LCPI14_2
.LPC14_2:
	add	r0, pc, r0
	str	r0, [sp]                        @ 4-byte Spill
	mov	r1, #0
	bl	gettimeofday
	ldr	r2, [sp]                        @ 4-byte Reload
	ldr	r0, [sp, #4]
	ldr	r3, .LCPI14_3
.LPC14_3:
	ldr	r3, [pc, r3]
	ldr	r1, .LCPI14_4
.LPC14_4:
	add	r1, pc, r1
	str	r0, [r1, r3, lsl #2]
	ldr	r0, .LCPI14_5
.LPC14_5:
	ldr	r0, [pc, r0]
	ldr	r1, .LCPI14_6
.LPC14_6:
	add	r1, pc, r1
	ldr	r3, .LCPI14_7
.LPC14_7:
	ldr	r3, [pc, r3]
	sub	r0, r0, r3
	ldr	r2, [r2, #4]
	movw	r12, #16960
	movt	r12, #15
	mla	r0, r0, r12, r2
	ldr	r1, [r1, #4]
	sub	r3, r0, r1
	ldr	r2, .LCPI14_8
.LPC14_8:
	ldr	r2, [pc, r2]
	ldr	r1, .LCPI14_9
.LPC14_9:
	add	r1, pc, r1
	ldr	r0, [r1, r2, lsl #2]
	add	r0, r0, r3
	str	r0, [r1, r2, lsl #2]
	ldr	lr, .LCPI14_10
.LPC14_10:
	ldr	lr, [pc, lr]
	ldr	r2, [r1, lr, lsl #2]
	movw	r0, #56963
	movt	r0, #17179
	smmul	r3, r2, r0
	asr	r2, r3, #18
	add	r4, r2, r3, lsr #31
	ldr	r3, .LCPI14_11
.LPC14_11:
	add	r3, pc, r3
	ldr	r2, [r3, lr, lsl #2]
	add	r2, r2, r4
	str	r2, [r3, lr, lsl #2]
	ldr	r2, .LCPI14_12
.LPC14_12:
	ldr	r2, [pc, r2]
	ldr	lr, [r1, r2, lsl #2]
	smmul	r4, lr, r0
	asr	r0, r4, #18
	add	r0, r0, r4, lsr #31
	mls	r0, r0, r12, lr
	str	r0, [r1, r2, lsl #2]
	ldr	r12, .LCPI14_13
.LPC14_13:
	ldr	r12, [pc, r12]
	ldr	r0, [r3, r12, lsl #2]
	movw	r2, #34953
	movt	r2, #34952
	smmla	r1, r0, r2, r0
	asr	r0, r1, #5
	add	lr, r0, r1, lsr #31
	ldr	r1, .LCPI14_14
.LPC14_14:
	add	r1, pc, r1
	ldr	r0, [r1, r12, lsl #2]
	add	r0, r0, lr
	str	r0, [r1, r12, lsl #2]
	ldr	r12, .LCPI14_15
.LPC14_15:
	ldr	r12, [pc, r12]
	ldr	r0, [r3, r12, lsl #2]
	smmla	r4, r0, r2, r0
	asr	lr, r4, #5
	add	lr, lr, r4, lsr #31
	rsb	lr, lr, lr, lsl #4
	sub	r0, r0, lr, lsl #2
	str	r0, [r3, r12, lsl #2]
	ldr	r12, .LCPI14_16
.LPC14_16:
	ldr	r12, [pc, r12]
	ldr	r0, [r1, r12, lsl #2]
	smmla	r3, r0, r2, r0
	asr	r0, r3, #5
	add	lr, r0, r3, lsr #31
	ldr	r3, .LCPI14_17
.LPC14_17:
	add	r3, pc, r3
	ldr	r0, [r3, r12, lsl #2]
	add	r0, r0, lr
	str	r0, [r3, r12, lsl #2]
	ldr	r0, .LCPI14_18
.LPC14_18:
	ldr	r0, [pc, r0]
	ldr	r0, [r1, r0, lsl #2]!
	smmla	r3, r0, r2, r0
	asr	r2, r3, #5
	add	r2, r2, r3, lsr #31
	rsb	r2, r2, r2, lsl #4
	sub	r0, r0, r2, lsl #2
	str	r0, [r1]
	ldr	r0, .LCPI14_1
.LPC14_1:
	add	r0, pc, r0
	ldr	r0, [r0]
	add	r0, r0, #1
	ldr	r1, .LCPI14_0
.LPC14_0:
	add	r1, pc, r1
	str	r0, [r1]
	sub	sp, r11, #8
	pop	{r4, r10, r11, pc}
	.p2align	2
@ %bb.1:
.LCPI14_0:
	.long	_sysy_idx-(.LPC14_0+8)
.LCPI14_1:
	.long	_sysy_idx-(.LPC14_1+8)
.LCPI14_2:
	.long	_sysy_end-(.LPC14_2+8)
.LCPI14_3:
	.long	_sysy_idx-(.LPC14_3+8)
.LCPI14_4:
	.long	_sysy_l2-(.LPC14_4+8)
.LCPI14_5:
	.long	_sysy_end-(.LPC14_5+8)
.LCPI14_6:
	.long	_sysy_start-(.LPC14_6+8)
.LCPI14_7:
	.long	_sysy_start-(.LPC14_7+8)
.LCPI14_8:
	.long	_sysy_idx-(.LPC14_8+8)
.LCPI14_9:
	.long	_sysy_us-(.LPC14_9+8)
.LCPI14_10:
	.long	_sysy_idx-(.LPC14_10+8)
.LCPI14_11:
	.long	_sysy_s-(.LPC14_11+8)
.LCPI14_12:
	.long	_sysy_idx-(.LPC14_12+8)
.LCPI14_13:
	.long	_sysy_idx-(.LPC14_13+8)
.LCPI14_14:
	.long	_sysy_m-(.LPC14_14+8)
.LCPI14_15:
	.long	_sysy_idx-(.LPC14_15+8)
.LCPI14_16:
	.long	_sysy_idx-(.LPC14_16+8)
.LCPI14_17:
	.long	_sysy_h-(.LPC14_17+8)
.LCPI14_18:
	.long	_sysy_idx-(.LPC14_18+8)
.Lfunc_end14:
	.size	_sysy_stoptime, .Lfunc_end14-_sysy_stoptime
	.cantunwind
	.fnend
                                        @ -- End function
	.type	.L.str,%object                  @ @.str
	.section	.rodata.str1.1,"aMS",%progbits,1
.L.str:
	.asciz	"%d"
	.size	.L.str, 3

	.type	.L.str.1,%object                @ @.str.1
.L.str.1:
	.asciz	"%c"
	.size	.L.str.1, 3

	.type	.L.str.2,%object                @ @.str.2
.L.str.2:
	.asciz	"%a"
	.size	.L.str.2, 3

	.type	.L.str.3,%object                @ @.str.3
.L.str.3:
	.asciz	"%d:"
	.size	.L.str.3, 4

	.type	.L.str.4,%object                @ @.str.4
.L.str.4:
	.asciz	" %d"
	.size	.L.str.4, 4

	.type	.L.str.5,%object                @ @.str.5
.L.str.5:
	.asciz	"\n"
	.size	.L.str.5, 2

	.type	.L.str.6,%object                @ @.str.6
.L.str.6:
	.asciz	" %a"
	.size	.L.str.6, 4

	.type	_sysy_us,%object                @ @_sysy_us
	.bss
	.globl	_sysy_us
	.p2align	2, 0x0
_sysy_us:
	.zero	4096
	.size	_sysy_us, 4096

	.type	_sysy_s,%object                 @ @_sysy_s
	.globl	_sysy_s
	.p2align	2, 0x0
_sysy_s:
	.zero	4096
	.size	_sysy_s, 4096

	.type	_sysy_m,%object                 @ @_sysy_m
	.globl	_sysy_m
	.p2align	2, 0x0
_sysy_m:
	.zero	4096
	.size	_sysy_m, 4096

	.type	_sysy_h,%object                 @ @_sysy_h
	.globl	_sysy_h
	.p2align	2, 0x0
_sysy_h:
	.zero	4096
	.size	_sysy_h, 4096

	.type	_sysy_idx,%object               @ @_sysy_idx
	.globl	_sysy_idx
	.p2align	2, 0x0
_sysy_idx:
	.long	0                               @ 0x0
	.size	_sysy_idx, 4

	.type	.L.str.7,%object                @ @.str.7
	.section	.rodata.str1.1,"aMS",%progbits,1
.L.str.7:
	.asciz	"Timer@%04d-%04d: %dH-%dM-%dS-%dus\n"
	.size	.L.str.7, 35

	.type	_sysy_l1,%object                @ @_sysy_l1
	.bss
	.globl	_sysy_l1
	.p2align	2, 0x0
_sysy_l1:
	.zero	4096
	.size	_sysy_l1, 4096

	.type	_sysy_l2,%object                @ @_sysy_l2
	.globl	_sysy_l2
	.p2align	2, 0x0
_sysy_l2:
	.zero	4096
	.size	_sysy_l2, 4096

	.type	.L.str.8,%object                @ @.str.8
	.section	.rodata.str1.1,"aMS",%progbits,1
.L.str.8:
	.asciz	"TOTAL: %dH-%dM-%dS-%dus\n"
	.size	.L.str.8, 25

	.type	_sysy_start,%object             @ @_sysy_start
	.bss
	.globl	_sysy_start
	.p2align	2, 0x0
_sysy_start:
	.zero	8
	.size	_sysy_start, 8

	.type	_sysy_end,%object               @ @_sysy_end
	.globl	_sysy_end
	.p2align	2, 0x0
_sysy_end:
	.zero	8
	.size	_sysy_end, 8

	.section	.init_array,"aw",%init_array
	.p2align	2, 0x0
	.long	before_main(target1)
	.section	.fini_array,"aw",%fini_array
	.p2align	2, 0x0
	.long	after_main(target1)
	.ident	"Ubuntu clang version 18.1.3 (1ubuntu1)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym __isoc99_scanf
	.addrsig_sym printf
	.addrsig_sym vfprintf
	.addrsig_sym before_main
	.addrsig_sym after_main
	.addrsig_sym fprintf
	.addrsig_sym gettimeofday
	.addrsig_sym stdout
	.addrsig_sym _sysy_us
	.addrsig_sym _sysy_s
	.addrsig_sym _sysy_m
	.addrsig_sym _sysy_h
	.addrsig_sym _sysy_idx
	.addrsig_sym stderr
	.addrsig_sym _sysy_l1
	.addrsig_sym _sysy_l2
	.addrsig_sym _sysy_start
	.addrsig_sym _sysy_end
	.eabi_attribute	30, 6	@ Tag_ABI_optimization_goals
