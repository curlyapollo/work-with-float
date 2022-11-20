	.intel_syntax noprefix				# using Intel-style syntax
	.text						# starting the section
	.section	.rodata				# section .rodata
	.align 8					# stack alignment
.LC1:
	.string	"left: %d\nright: %d\na: %lf\nb: %lf\n"	# mark for string
	.text						# code section
	.globl	random_read				# declaration and exporting outside "random_read" symbol
	.type	random_read, @function			# type of the random_read is the function
random_read:
	push	rbp					# save stack pointer
	mov	rbp, rsp				# move stack pointer to the new position
	sub	rsp, 32					# reserve 32 bytes on stack
	mov	r12d, edi				# r12d := edi = seed
	mov	eax, r12d				# eax := r12d
	mov	edi, eax				# edi := eax - seed
	call	srand@PLT				# call srand(seed) - set seed
	call	rand@PLT				# call rand()
	mov	edx, eax				# edx := eax
	movsx	rax, edx				# rax := edx
	imul	rax, rax, 1717986919			# rax := rax * integer
	shr	rax, 32					# rax >> 32
	sar	eax, 3					# eax << 3
	mov	esi, edx				# esi := edx
	sar	esi, 31					# esi << 31
	sub	eax, esi				# eax - esi
	mov	ecx, eax				# ecx := eax
	mov	eax, ecx				# eax := ecx
	sal	eax, 2					# eax << 2
	add	eax, ecx				# eax += ecx
	sal	eax, 2					# eax << 2
	mov	ecx, edx				# ecx := edx
	sub	ecx, eax				# ecx -= eax
	lea	eax, -10[rcx]				# eax := rcx[-10]
	mov	DWORD PTR left[rip], eax		# left := eax
	call	rand@PLT				# same shit with right
	mov	edx, eax
	movsx	rax, edx
	imul	rax, rax, 1717986919
	shr	rax, 32
	sar	eax, 4
	mov	esi, edx
	sar	esi, 31
	sub	eax, esi
	mov	ecx, eax
	mov	eax, ecx
	sal	eax, 2
	add	eax, ecx
	sal	eax, 3
	mov	ecx, edx
	sub	ecx, eax
	mov	eax, DWORD PTR left[rip]
	add	eax, ecx
	mov	DWORD PTR right[rip], eax		# right := eax
	call	rand@PLT				# same shit with koef1
	movsx	rdx, eax
	imul	rdx, rdx, 1374389535
	shr	rdx, 32
	sar	edx, 7
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 400
	sub	eax, ecx
	mov	edx, eax
	lea	eax, -200[rdx]
	mov	DWORD PTR -32[rbp], eax
	fild	DWORD PTR -32[rbp]
	fstp	TBYTE PTR -32[rbp]
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 274877907
	shr	rdx, 32
	sar	edx, 6
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 1000
	sub	eax, ecx
	mov	edx, eax
	mov	DWORD PTR -8[rbp], edx
	fild	DWORD PTR -8[rbp]
	fld	TBYTE PTR .LC0[rip]
	fdivp	st(1), st
	fld	TBYTE PTR -32[rbp]
	faddp	st(1), st
	fstp	QWORD PTR -32[rbp]
	movsd	xmm0, QWORD PTR -32[rbp]
	movsd	QWORD PTR koef1[rip], xmm0		# koef1 := xmm0
	call	rand@PLT				# same shit with koef2
	movsx	rdx, eax
	imul	rdx, rdx, 1374389535
	shr	rdx, 32
	sar	edx, 7
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 400
	sub	eax, ecx
	mov	edx, eax
	lea	eax, -200[rdx]
	mov	DWORD PTR -32[rbp], eax
	fild	DWORD PTR -32[rbp]
	fstp	TBYTE PTR -32[rbp]
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 274877907
	shr	rdx, 32
	sar	edx, 6
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 1000
	sub	eax, ecx
	mov	edx, eax
	mov	DWORD PTR -8[rbp], edx
	fild	DWORD PTR -8[rbp]
	fld	TBYTE PTR .LC0[rip]
	fdivp	st(1), st
	fld	TBYTE PTR -32[rbp]
	faddp	st(1), st
	fstp	QWORD PTR -32[rbp]
	movsd	xmm0, QWORD PTR -32[rbp]
	movsd	QWORD PTR koef2[rip], xmm0		# koef2 := xmm0
	movsd	xmm0, QWORD PTR koef2[rip]		# putting in arguments fo printf
	mov	rcx, QWORD PTR koef1[rip]
	mov	edx, DWORD PTR right[rip]
	mov	eax, DWORD PTR left[rip]
	movapd	xmm1, xmm0
	movq	xmm0, rcx
	mov	esi, eax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 2
	call	printf@PLT				# call printf
	leave						# leave the function
	ret						# return;
        .section        .rodata				# section .rodata
        .align 16					# stack alignment
.LC0:
        .long   0
        .long   -100663296
        .long   16392
        .long   0
