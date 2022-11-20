	.intel_syntax noprefix			# using Intel-style syntax
	.text					# starting the section
	.section	.rodata			# section .rodata
.LC0:
	.string	"%lf\n"				# mark for "%lf\n"
	.text					# code section
	.globl	print				# declaring and exporting outside "print" symbol
	.type	print, @function		# type of the print is the function
print:
	push	rbp				# save stack pointer
	mov	rbp, rsp			# move stack pointer to the new position
	sub	rsp, 16				# reserve 16 bytes on stack
	mov	r12, rdi			# getting the &output from the argument rdi
	movsd	QWORD PTR -16[rbp], xmm0	# getting the sum
	mov	rdx, QWORD PTR -16[rbp]		# rdx := sum
	mov	rax, r12			# rax := r12 = output
	movq	xmm0, rdx			# xmm0 := rdx
	lea	rdx, .LC0[rip]			# rdx := rip[.LC0] = "%lf\n"
	mov	rsi, rdx			# putting in the 2nd argument "%lf\n"
	mov	rdi, rax			# putting in the 1st argument output
	mov	eax, 1				# eax := 1
	call	fprintf@PLT			# call fprintf(output, "%lf\n", sum)
	leave					# leave the function
	ret					# return;
