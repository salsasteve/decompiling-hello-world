	.intel_syntax noprefix
	.file	"main.8f81e49356787d17-cgu.0"
	.section	.text._ZN3std2rt10lang_start17h37ec48243b8dd23aE,"ax",@progbits
	.hidden	_ZN3std2rt10lang_start17h37ec48243b8dd23aE
	.globl	_ZN3std2rt10lang_start17h37ec48243b8dd23aE
	.p2align	4
	.type	_ZN3std2rt10lang_start17h37ec48243b8dd23aE,@function
_ZN3std2rt10lang_start17h37ec48243b8dd23aE:
	.cfi_startproc
	push	rax
	.cfi_def_cfa_offset 16
	mov	r8d, ecx
	mov	rcx, rdx
	mov	rdx, rsi
	mov	qword ptr [rsp], rdi
	lea	rsi, [rip + .Lanon.71cc8978aafdad452e4de9b14db389e9.0]
	mov	rdi, rsp
	call	qword ptr [rip + _RNvNtCs75vJTIYSa2J_3std2rt19lang_start_internal@GOTPCREL]
	pop	rcx
	.cfi_def_cfa_offset 8
	ret
.Lfunc_end0:
	.size	_ZN3std2rt10lang_start17h37ec48243b8dd23aE, .Lfunc_end0-_ZN3std2rt10lang_start17h37ec48243b8dd23aE
	.cfi_endproc

	.section	".text._ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he6dd0c326092176dE","ax",@progbits
	.p2align	4
	.type	_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he6dd0c326092176dE,@function
_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he6dd0c326092176dE:
	.cfi_startproc
	push	rax
	.cfi_def_cfa_offset 16
	mov	rdi, qword ptr [rdi]
	call	_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hafa657e659eb3b9aE
	xor	eax, eax
	pop	rcx
	.cfi_def_cfa_offset 8
	ret
.Lfunc_end1:
	.size	_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he6dd0c326092176dE, .Lfunc_end1-_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he6dd0c326092176dE
	.cfi_endproc

	.section	.text._ZN3std3sys9backtrace28__rust_begin_short_backtrace17hafa657e659eb3b9aE,"ax",@progbits
	.p2align	4
	.type	_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hafa657e659eb3b9aE,@function
_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hafa657e659eb3b9aE:
	.cfi_startproc
	push	rax
	.cfi_def_cfa_offset 16
	call	rdi
	#APP
	#NO_APP
	pop	rax
	.cfi_def_cfa_offset 8
	ret
.Lfunc_end2:
	.size	_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hafa657e659eb3b9aE, .Lfunc_end2-_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hafa657e659eb3b9aE
	.cfi_endproc

	.section	".text._ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h601a936d8304b915E","ax",@progbits
	.p2align	4
	.type	_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h601a936d8304b915E,@function
_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h601a936d8304b915E:
	.cfi_startproc
	push	rax
	.cfi_def_cfa_offset 16
	mov	rdi, qword ptr [rdi]
	call	_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hafa657e659eb3b9aE
	xor	eax, eax
	pop	rcx
	.cfi_def_cfa_offset 8
	ret
.Lfunc_end3:
	.size	_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h601a936d8304b915E, .Lfunc_end3-_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h601a936d8304b915E
	.cfi_endproc

	.section	.text._ZN4main4main17h2dd6e7c25b480450E,"ax",@progbits
	.hidden	_ZN4main4main17h2dd6e7c25b480450E
	.globl	_ZN4main4main17h2dd6e7c25b480450E
	.p2align	4
	.type	_ZN4main4main17h2dd6e7c25b480450E,@function
_ZN4main4main17h2dd6e7c25b480450E:
	.cfi_startproc
	lea	rdi, [rip + .Lanon.71cc8978aafdad452e4de9b14db389e9.1]
	mov	esi, 29
	jmp	qword ptr [rip + _RNvNtNtCs75vJTIYSa2J_3std2io5stdio6__print@GOTPCREL]
.Lfunc_end4:
	.size	_ZN4main4main17h2dd6e7c25b480450E, .Lfunc_end4-_ZN4main4main17h2dd6e7c25b480450E
	.cfi_endproc

	.section	.text.main,"ax",@progbits
	.globl	main
	.p2align	4
	.type	main,@function
main:
	.cfi_startproc
	push	rax
	.cfi_def_cfa_offset 16
	mov	rcx, rsi
	movsxd	rdx, edi
	lea	rax, [rip + _ZN4main4main17h2dd6e7c25b480450E]
	mov	qword ptr [rsp], rax
	lea	rsi, [rip + .Lanon.71cc8978aafdad452e4de9b14db389e9.0]
	mov	rdi, rsp
	xor	r8d, r8d
	call	qword ptr [rip + _RNvNtCs75vJTIYSa2J_3std2rt19lang_start_internal@GOTPCREL]
	pop	rcx
	.cfi_def_cfa_offset 8
	ret
.Lfunc_end5:
	.size	main, .Lfunc_end5-main
	.cfi_endproc

	.type	.Lanon.71cc8978aafdad452e4de9b14db389e9.0,@object
	.section	.data.rel.ro..Lanon.71cc8978aafdad452e4de9b14db389e9.0,"aw",@progbits
	.p2align	3, 0x0
.Lanon.71cc8978aafdad452e4de9b14db389e9.0:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h601a936d8304b915E
	.quad	_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he6dd0c326092176dE
	.quad	_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he6dd0c326092176dE
	.size	.Lanon.71cc8978aafdad452e4de9b14db389e9.0, 48

	.type	.Lanon.71cc8978aafdad452e4de9b14db389e9.1,@object
	.section	.rodata..Lanon.71cc8978aafdad452e4de9b14db389e9.1,"a",@progbits
.Lanon.71cc8978aafdad452e4de9b14db389e9.1:
	.ascii	"Hello, world!\n"
	.size	.Lanon.71cc8978aafdad452e4de9b14db389e9.1, 14

	.ident	"rustc version 1.96.0 (ac68faa20 2026-05-25)"
	.section	".note.GNU-stack","",@progbits
