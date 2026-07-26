	.build_version macos, 11, 0
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZN3std2rt10lang_start17hf66e9cda02e72e37E
	.globl	__ZN3std2rt10lang_start17hf66e9cda02e72e37E
	.p2align	2
__ZN3std2rt10lang_start17hf66e9cda02e72e37E:
	.cfi_startproc
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x4, x3
	mov	x3, x2
	mov	x2, x1
	str	x0, [sp, #8]
Lloh0:
	adrp	x1, l_anon.6ab74d13209e48453bd53c398428a1ae.0@PAGE
Lloh1:
	add	x1, x1, l_anon.6ab74d13209e48453bd53c398428a1ae.0@PAGEOFF
	add	x0, sp, #8
	bl	__RNvNtCsaLOjE9VYtxK_3std2rt19lang_start_internal
	.cfi_def_cfa wsp, 32
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #32
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
	.loh AdrpAdd	Lloh0, Lloh1
	.cfi_endproc

	.p2align	2
__ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17hbcef59d852f4b506E:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	__ZN3std3sys9backtrace28__rust_begin_short_backtrace17hb05ff8d5cc5951c5E
	mov	w0, #0
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
	.cfi_endproc

	.p2align	2
__ZN3std3sys9backtrace28__rust_begin_short_backtrace17hb05ff8d5cc5951c5E:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	blr	x0
	; InlineAsm Start
	; InlineAsm End
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
	.cfi_endproc

	.p2align	2
__ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h35fbfd43d88ec7aeE:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	__ZN3std3sys9backtrace28__rust_begin_short_backtrace17hb05ff8d5cc5951c5E
	mov	w0, #0
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
	.cfi_endproc

	.private_extern	__ZN4main4main17h2dd6e7c25b480450E
	.globl	__ZN4main4main17h2dd6e7c25b480450E
	.p2align	2
__ZN4main4main17h2dd6e7c25b480450E:
	.cfi_startproc
Lloh2:
	adrp	x0, l_anon.6ab74d13209e48453bd53c398428a1ae.1@PAGE
Lloh3:
	add	x0, x0, l_anon.6ab74d13209e48453bd53c398428a1ae.1@PAGEOFF
	mov	w1, #29
	b	__RNvNtNtCsaLOjE9VYtxK_3std2io5stdio6__print
	.loh AdrpAdd	Lloh2, Lloh3
	.cfi_endproc

	.globl	_main
	.p2align	2
_main:
	.cfi_startproc
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x3, x1
	sxtw	x2, w0
Lloh4:
	adrp	x8, __ZN4main4main17h2dd6e7c25b480450E@PAGE
Lloh5:
	add	x8, x8, __ZN4main4main17h2dd6e7c25b480450E@PAGEOFF
	str	x8, [sp, #8]
Lloh6:
	adrp	x1, l_anon.6ab74d13209e48453bd53c398428a1ae.0@PAGE
Lloh7:
	add	x1, x1, l_anon.6ab74d13209e48453bd53c398428a1ae.0@PAGEOFF
	add	x0, sp, #8
	mov	w4, #0
	bl	__RNvNtCsaLOjE9VYtxK_3std2rt19lang_start_internal
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #32
	ret
	.loh AdrpAdd	Lloh6, Lloh7
	.loh AdrpAdd	Lloh4, Lloh5
	.cfi_endproc

	.section	__DATA,__const
	.p2align	3, 0x0
l_anon.6ab74d13209e48453bd53c398428a1ae.0:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	__ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h35fbfd43d88ec7aeE
	.quad	__ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17hbcef59d852f4b506E
	.quad	__ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17hbcef59d852f4b506E

	.section	__TEXT,__const
l_anon.6ab74d13209e48453bd53c398428a1ae.1:
	.ascii	"Hello, world!\n"

.subsections_via_symbols
