	.intel_syntax noprefix			# using Intel-style syntax
	.text					# starting the section
	.globl	integration			# declaration and exporting outside "integration" symbol
	.type	integration, @function		# type of the time_dif is the function
integration:
	push	rbp				# save stack pointer
	mov	rbp, rsp			# move stack pointer to the new position
	sub	rsp, 32				# allocation of memory on the stack
	pxor	xmm0, xmm0			# xmm0 ^ xmm0 = 0 -- sum
	movsd	QWORD PTR -8[rbp], xmm0		# rbp[-8] := xmm0 -- sum
	mov	r12d, 0				# r12d := 0 = i
	jmp	.L2				# jump to the mark .L2
.L3:
	mov	eax, DWORD PTR left[rip]	# eax := left
	pxor	xmm1, xmm1			# xmm1 ^ xmm1
	cvtsi2sd	xmm1, eax		# left to double = xmm1
	pxor	xmm2, xmm2			# xmm2 := 0
	cvtsi2sd	xmm2, r12d		# i to double = xmm2
	movsd	xmm0, QWORD PTR .LC1[rip]	# xmm0 := rip[.LC1] = 0.0001
	mulsd	xmm0, xmm2			# xmm0 *= xmm2 ~~ i * 0.0001
	addsd	xmm0, xmm1			# xmm0 += xmm1 ~~ left + i * 0.0001
	movsd	QWORD PTR -24[rbp], xmm0	# rbp[-24] := xmm0 - backup
	mov	eax, DWORD PTR left[rip]	# eax := left
	pxor	xmm1, xmm1			# xmm1 ^ xmm1 = 0 - zeroing out
	cvtsi2sd	xmm1, eax		# left to double
	mov	eax, r12d			# eax := r12d = i
	add	eax, 1				# eax += 1 ~~ i + 1
	pxor	xmm2, xmm2			# xmm2 ^ xmm2 = 0 - zeroing out
	cvtsi2sd	xmm2, eax		# i to double
	movsd	xmm0, QWORD PTR .LC1[rip]	# xmm0 := 0.0001
	mulsd	xmm0, xmm2			# xmm0 *= xmm2 ~~ 0.0001 * (i + 1)
	addsd	xmm0, xmm1			# xmm0 += xmm1 ~~ left + 0.0001 * (i + 1)
	movsd	QWORD PTR -32[rbp], xmm0	# rbp[-32] := xmm0 - backup
	movsd	xmm0, QWORD PTR -24[rbp]	# xmm0 := x_i;
	addsd	xmm0, QWORD PTR -32[rbp]	# xmm0 += x_i1;
	movsd	xmm1, QWORD PTR .LC2[rip]	# xmm1 := 2
	divsd	xmm0, xmm1			# xmm0 / 2
	movq	rax, xmm0			# rax := xmm0
	movq	xmm0, rax			# xmm0 := rax
	call	func@PLT			# call func(xmm0)
	movsd	xmm1, QWORD PTR -32[rbp]	# xmm1 := x_i1
	subsd	xmm1, QWORD PTR -24[rbp]	# xmm1 -= x_i
	mulsd	xmm0, xmm1			# func((x_i + x_i1) / 2) * (x_i1 - x_i)
	movsd	xmm1, QWORD PTR -8[rbp]		# xmm1 := sum
	addsd	xmm0, xmm1			# xmm0 += sum
	movsd	QWORD PTR -8[rbp], xmm0		# rbp[-8] := xmm0 = sum
	add	r12d, 1				# i++
.L2:
	mov	eax, DWORD PTR right[rip]	# eax := right
	mov	edx, DWORD PTR left[rip]	# edx := left
	sub	eax, edx			# eax -= edx ~~ right - left
	imul	eax, eax, 10000			# eax *= 10000 ~~ (right - left) * 10000
	cmp	r12d, eax			# comparison of i and (right - left) * 10000
	jl	.L3				# if (i < (right - left) * 10000) jump to the mark .L3
	movsd	xmm0, QWORD PTR -8[rbp]		# xmm0 := rbp[-8] = sum
	movq	rax, xmm0			# rax := xmm0 = sum
	movq	xmm0, rax			# xmm0 := rax
	leave					# leave the function
	ret					# return rax = sum;
	.section	.rodata			# section .rodata
	.align 8				# stack alignment
.LC1:
	.long	-350469331			# 0.0001
	.long	1058682594
	.align 8				# stack alignment
.LC2:
	.long	0				# 2
	.long	1073741824

