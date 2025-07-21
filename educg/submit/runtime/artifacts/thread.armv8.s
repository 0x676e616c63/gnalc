	.arch armv8-a
	.file	"thread.cpp"
	.text
	.align	2
	.p2align 4,,15
	.type	_ZL12worker_entryPv, %function
_ZL12worker_entryPv:
.LFB1296:
	.cfi_startproc
	stp	x30, x19, [sp, -176]!
	.cfi_def_cfa_offset 176
	.cfi_offset 30, -176
	.cfi_offset 19, -168
	mov	x4, 8
	adrp	x19, .LANCHOR0
	add	x19, x19, :lo12:.LANCHOR0
	add	x3, sp, 56
	movi	v31.4s, 0
	stp	x20, x21, [sp, 16]
	add	x2, sp, 48
	str	x22, [sp, 32]
	.cfi_offset 20, -160
	.cfi_offset 21, -152
	.cfi_offset 22, -144
	add	x20, x19, 64
	str	x4, [sp, 48]
	add	x21, x19, 192
	str	q31, [sp, 56]
	add	x22, x19, 128
	mov	x1, 128
	stp	q31, q31, [x3, 16]
	mov	w0, 0
	stp	q31, q31, [x3, 48]
	stp	q31, q31, [x3, 80]
	str	xzr, [sp, 168]
	bl	sched_setaffinity
	.p2align 3,,7
.L2:
	ldarb	w0, [x20]
	tst	w0, 255
	beq	.L4
.L12:
	ldr	x2, [x19]
	ldp	w0, w1, [x19, 8]
	blr	x2
	mov	w0, 1
	stlrb	w0, [x22]
	stlrb	wzr, [x20]
	ldarb	w0, [x20]
	tst	w0, 255
	bne	.L12
.L4:
	ldarb	w0, [x21]
	tst	w0, 255
	beq	.L2
	mov	w0, 1
	add	x19, x19, 193
	stlrb	w0, [x19]
	ldr	x22, [sp, 32]
	mov	w0, 0
	ldp	x20, x21, [sp, 16]
	ldp	x30, x19, [sp], 176
	.cfi_restore 19
	.cfi_restore 30
	.cfi_restore 22
	.cfi_restore 20
	.cfi_restore 21
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE1296:
	.size	_ZL12worker_entryPv, .-_ZL12worker_entryPv
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 4,,15
	.global	gnalc_thread_init
	.type	gnalc_thread_init, %function
gnalc_thread_init:
.LFB1297:
	.cfi_startproc
	stp	x30, x19, [sp, -144]!
	.cfi_def_cfa_offset 144
	.cfi_offset 30, -144
	.cfi_offset 19, -136
	mov	x4, 4
	mov	x1, 128
	movi	v31.4s, 0
	add	x3, sp, 24
	str	x4, [sp, 16]
	add	x2, sp, 16
	mov	w0, 0
	adrp	x19, .LANCHOR0
	add	x19, x19, :lo12:.LANCHOR0
	str	q31, [sp, 24]
	stp	q31, q31, [x3, 16]
	stp	q31, q31, [x3, 48]
	stp	q31, q31, [x3, 80]
	str	xzr, [sp, 136]
	bl	sched_setaffinity
	add	x0, x19, 64
	stlrb	wzr, [x0]
	add	x0, x19, 128
	stlrb	wzr, [x0]
	add	x0, x19, 192
	stlrb	wzr, [x0]
	mov	w4, -1
	mov	x5, 0
	mov	w2, 3
	mov	x1, 65536
	mov	w3, 34
	movk	w3, 0x2, lsl 16
	mov	x0, 0
	bl	mmap
	mov	x4, x0
	adrp	x1, _ZL12worker_entryPv
	mov	x3, 0
	add	x0, x1, :lo12:_ZL12worker_entryPv
	mov	w2, 3840
	movk	w2, 0x5, lsl 16
	add	x1, x4, 65536
	str	x4, [x19, 256]
	bl	clone
	ldp	x30, x19, [sp], 144
	.cfi_restore 19
	.cfi_restore 30
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE1297:
	.size	gnalc_thread_init, .-gnalc_thread_init
	.section	.init_array,"aw"
	.align	3
	.xword	gnalc_thread_init
	.section	.text.exit,"ax",@progbits
	.align	2
	.p2align 4,,15
	.global	gnalc_thread_deinit
	.type	gnalc_thread_deinit, %function
gnalc_thread_deinit:
.LFB1298:
	.cfi_startproc
	adrp	x2, .LANCHOR0
	add	x2, x2, :lo12:.LANCHOR0
	mov	w1, 1
	add	x0, x2, 192
	stlrb	w1, [x0]
	add	x1, x2, 193
	.p2align 3,,7
.L16:
	ldarb	w0, [x1]
	tst	w0, 255
	beq	.L16
	ldr	x0, [x2, 256]
	mov	x1, 65536
	b	munmap
	.cfi_endproc
.LFE1298:
	.size	gnalc_thread_deinit, .-gnalc_thread_deinit
	.section	.fini_array,"aw"
	.align	3
	.xword	gnalc_thread_deinit
	.text
	.align	2
	.p2align 4,,15
	.global	gnalc_parallel_for
	.type	gnalc_parallel_for, %function
gnalc_parallel_for:
.LFB1299:
	.cfi_startproc
	sub	w4, w1, w0
	cmp	w4, 128
	bgt	.L20
	mov	x16, x2
	br	x16
	.p2align 2,,3
.L20:
	adrp	x7, .LANCHOR0
	add	x6, x7, :lo12:.LANCHOR0
	stp	x30, x19, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 30, -16
	.cfi_offset 19, -8
	mov	w3, w1
	add	w1, w0, w4, asr 1
	str	x2, [x7, #:lo12:.LANCHOR0]
	add	x19, x6, 128
	stp	w1, w3, [x6, 8]
	strb	wzr, [x19]
	dmb	ish
	mov	w3, 1
	add	x6, x6, 64
	stlrb	w3, [x6]
	blr	x2
	.p2align 3,,7
.L21:
	ldarb	w0, [x19]
	tst	w0, 255
	beq	.L21
	ldp	x30, x19, [sp], 16
	.cfi_restore 19
	.cfi_restore 30
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE1299:
	.size	gnalc_parallel_for, .-gnalc_parallel_for
	.align	2
	.p2align 4,,15
	.global	gnalc_atomic_add_i32
	.type	gnalc_atomic_add_i32, %function
gnalc_atomic_add_i32:
.LFB1300:
	.cfi_startproc
	mov	x2, x0
	str	x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 30, -16
	mov	w0, w1
	mov	x1, x2
	bl	__aarch64_ldadd4_acq_rel
	ldr	x30, [sp], 16
	.cfi_restore 30
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE1300:
	.size	gnalc_atomic_add_i32, .-gnalc_atomic_add_i32
	.align	2
	.p2align 4,,15
	.global	gnalc_atomic_add_f32
	.type	gnalc_atomic_add_f32, %function
gnalc_atomic_add_f32:
.LFB1301:
	.cfi_startproc
	stp	x30, x19, [sp, -64]!
	.cfi_def_cfa_offset 64
	.cfi_offset 30, -64
	.cfi_offset 19, -56
	mov	x19, x0
	stp	x20, x21, [sp, 16]
	stp	d14, d15, [sp, 32]
	.cfi_offset 20, -48
	.cfi_offset 21, -40
	.cfi_offset 78, -32
	.cfi_offset 79, -24
	fmov	s15, s0
	ldar	w0, [x0]
	add	x21, sp, 60
	fmov	s14, w0
	str	w0, [sp, 60]
.L31:
	fadd	s31, s15, s14
	ldr	w20, [x21]
	mov	x2, x19
	mov	w0, w20
	fmov	w1, s31
	bl	__aarch64_cas4_acq_rel
	cmp	w0, w20
	cset	w1, eq
	beq	.L29
	str	w0, [x21]
.L29:
	cbz	w1, .L33
	ldp	x20, x21, [sp, 16]
	ldp	d14, d15, [sp, 32]
	ldp	x30, x19, [sp], 64
	.cfi_remember_state
	.cfi_restore 19
	.cfi_restore 30
	.cfi_restore 20
	.cfi_restore 21
	.cfi_restore 78
	.cfi_restore 79
	.cfi_def_cfa_offset 0
	ret
.L33:
	.cfi_restore_state
	ldr	s14, [sp, 60]
	b	.L31
	.cfi_endproc
.LFE1301:
	.size	gnalc_atomic_add_f32, .-gnalc_atomic_add_f32
	.bss
	.align	6
	.set	.LANCHOR0,. + 0
	.type	_ZL5state, %object
	.size	_ZL5state, 256
_ZL5state:
	.zero	256
	.type	_ZL12worker_stack, %object
	.size	_ZL12worker_stack, 8
_ZL12worker_stack:
	.zero	8
	.global	__aarch64_cas4_acq_rel
	.global	__aarch64_ldadd4_acq_rel
	.ident	"GCC: (GNU) 15.1.0"
	.section	.note.GNU-stack,"",@progbits
