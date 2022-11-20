	.intel_syntax noprefix		# using Intel-style syntax
	.text				# starting the section
	.section	.rodata		# section .rodata
.LC0:
	.string	"%lf"			# mark for "%lf"
.LC1:
	.string	"%d"			# mark for "%d"
	.text				# code section
	.globl	read_nums		# declaring and exporting outside "read_nums" symbol
	.type	read_nums, @function	# type of the read_nums is the function
read_nums:
	push	rbp			# save stack pointer
	mov	rbp, rsp		# move stack pointer to the new position
	sub	rsp, 16			# reserve 16 bytes on stack
	mov	r12, rdi		# getting the &input from the argument rdi
	mov	rax, r12		# rax := r12 = input
	lea	rdx, koef1[rip]		# rdx := koef1
	lea	rcx, .LC0[rip]		# rcx := "%lf"
	mov	rsi, rcx		# rsi := rcx = "%lf" - 2nd argument in function
	mov	rdi, rax		# rdi := rax = input - 1st argument in function
	mov	eax, 0			# eax := 0 - zeroing out
	call	fscanf@PLT		# call fscanf(input, "%lf", &koef1)
	mov	rax, r12		# rax := r12 = input
	lea	rdx, koef2[rip]		# rdx := koef2
	lea	rcx, .LC0[rip]		# rcx := "%lf"
	mov	rsi, rcx		# rsi := rcx = "%lf" - 2nd argument in function
	mov	rdi, rax		# rdi := rax = input - 1st argument in function
	mov	eax, 0			# eax := 0 - zeroing out
	call	fscanf@PLT		# call fscanf(input, "%lf", &koef2)
	mov	rax, r12		# rax := r12 = input
	lea	rdx, left[rip]		# rdx := left
	lea	rcx, .LC1[rip]		# rcx := "%d"
	mov	rsi, rcx		# rsi := rcx = "%d" - 2nd argument in function
	mov	rdi, rax		# rdi := rax = input - 1st argument in function
	mov	eax, 0			# eax := 0 - zeroing out
	call	fscanf@PLT		# call fscanf(input, "%d", &left)
	mov	rax, r12		# rax := r12 = input
	lea	rdx, right[rip]		# rdx := right
	lea	rcx, .LC1[rip]		# rcx := "%d"
	mov	rsi, rcx		# rsi := rcx = "%d" - 2nd argument in function
	mov	rdi, rax		# rdi := rax = input - 1st argument in function
	mov	eax, 0			# eax := 0 - zeroing out
	call	fscanf@PLT		# call fscanf(input, "%d", &right)
	leave				# leave the function
	ret				# return;
