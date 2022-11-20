	.intel_syntax noprefix			# using Intel-style syntax
	.text					# starting the section
	.globl	func				# declaring and exporting outside "func" symbol
	.type	func, @function			# type of the func is the function
func:
	push	rbp				# save stack pointer
	mov	rbp, rsp			# move stack pointer to the new position
	movsd	QWORD PTR -8[rbp], xmm0		# rbp[-8] := xmm0 = x
	movsd	xmm1, QWORD PTR koef2[rip]	# xmm1 := rip[koef2]
	movsd	xmm0, QWORD PTR -8[rbp]		# xmm0 := x
	mulsd	xmm0, xmm0			# x *= x
	mulsd	xmm0, QWORD PTR -8[rbp]		# x^2 *= x
	mulsd	xmm0, QWORD PTR -8[rbp]		# x^3 *= x
	divsd	xmm1, xmm0			# xmm1 /= x^4
	movsd	xmm0, QWORD PTR koef1[rip]	# xmm0 := rip[koef1]
	addsd	xmm0, xmm1			# koef1 += xmm1 / x^4
	movq	rax, xmm0			# rax := xmm0 = koef1 + xmm1 / x^4
	movq	xmm0, rax			# xmm0 := rax
	pop	rbp				# return previous stack pointer
	ret					# return rax;
