	.intel_syntax noprefix			# using Intel-style syntax
	.text					# starting the section
	.globl	left				# declaring and exporting outside the "left" symbol
	.bss					# memory allocation section
	.align 4				# stack alignment
	.type	left, @object			# type of the left is the object
	.size	left, 4				# size of the left equals 4 bytes
left:
	.zero	4				# generating four spaces
	.globl	right				# declaring and exporting outside the "right" symbol
	.align 4				# stack alignment
	.type	right, @object			# type of the right is the object
	.size	right, 4			# size of the right equals 4 bytes
right:
	.zero	4				# generating four spaces
	.globl	koef1				# declaring and exporting outside the "koef1" symbol
	.align 8				# stack alignment
	.type	koef1, @object			# type of the koef1 is the object
	.size	koef1, 8			# size of the koef1 equals 8 bytes
koef1:
	.zero	8				# generating eight spaces
	.globl	koef2				# declaring and exporting outside the "koef2" symbol
	.align 8				# stack alignment
	.type	koef2, @object			# type of the koef2 is the object
	.size	koef2, 8			# size of the koef2 equals 8 bytes
koef2:
	.zero	8				# generating eight spaces
	.section	.rodata			# section .rodata
.LC0:
	.string	"r"				# mark for "r"
.LC1:
	.string	"w"				# mark for "w"
.LC2:
	.string	"Elapsed: %ld ns\n"		# mark for "Elapsed: %ld ns\n"
	.text					# starting the section
	.globl	main				# declaring and exporting outside the "main" symbol
	.type	main, @function			# type of the main is the function
main:
	push	rbp				# save stack pointer
	mov	rbp, rsp			# move stack pointer to the new position
	sub	rsp, 80				# reserve 80 bytes on stack
	mov	r12d, edi			# r12d := edi - getting 1st argument argc
	mov	QWORD PTR -80[rbp], rsi		# rbp[-80] := rsi - getting 2nd argument argv
	mov	rax, QWORD PTR -80[rbp]		# rax := argv
	add	rax, 8				# rax += 8 - &argv[1]
	mov	rax, QWORD PTR [rax]		# rax := argv[1]
	lea	rdx, .LC0[rip]			# rdx := rip[.LC0] = "r"
	mov	rsi, rdx			# rsi := rdx - putting in the 2nd argument "r"
	mov	rdi, rax			# rdi := rax - putting in the 1st argument argv[1]
	call	fopen@PLT			# call fopen(rdi, rsi) ~~ fopen(argv[1], "r")
	mov	QWORD PTR -8[rbp], rax		# rbp[-8] := rax = input
	mov	rax, QWORD PTR -80[rbp]		# rax := argv
	add	rax, 16				# rax += 16 ~~ &argv[2]
	mov	rax, QWORD PTR [rax]		# rax := argv[2]
	lea	rdx, .LC1[rip]			# rdx := rip[.LC1] = "w"
	mov	rsi, rdx			# rsi := rdx - putting in the 2nd argument "w"
	mov	rdi, rax			# rdi := rax - putting in the 1st argument argv[2]
	call	fopen@PLT			# call fopen(rdi, rsi) ~~ fopen(argv[2], "w")
	mov	QWORD PTR -16[rbp], rax		# rbp[-16] := rax = output
	cmp	r12d, 4				# comparison of r12d and 4 ~~ argc and 4
	jne	.L2				# if argc != 4 jump to .L2
	mov	rax, QWORD PTR -80[rbp]		# rax := argv
	add	rax, 24				# rax += 24 - &argv[3]
	mov	rax, QWORD PTR [rax]		# rax := argv[3]
	mov	rdi, rax			# rdi := rax - putting in the 1st argument argv[3] - seed
	call	atoi@PLT			# call atoi(seed)
	mov	edi, eax			# edi := eax - putting in the 1st argument atoi(seed)
	call	random_read@PLT			# call random_read(atoi(seed))
	jmp	.L3				# jump to mark .L3
.L2:
	mov	rax, QWORD PTR -8[rbp]		# rax := rbp[-8] - backup
	mov	rdi, rax			# rdi := rax = argv[1] - putting in the 1st argument argv[1]
	call	read_nums@PLT			# call read_nums(argv[1])
.L3:
	lea	rax, -48[rbp]			# rax := rbp[-48] = &start
	mov	rsi, rax			# rsi := rax - putting in the 2nd argument &start
	mov	edi, 1				# edi := 1 - putting in the 1st argument 1
	call	clock_gettime@PLT		# call clock_gettime(edi, rsi) ~~ clock_gettime(1, &start)
	mov	eax, 0				# zeroing out of rax
	call	integration@PLT			# call integration()
	movq	rax, xmm0			# rax := xmm0 = sum
	mov	QWORD PTR -24[rbp], rax		# rbp[-24] = sum
	lea	rax, -64[rbp]			# rax := rbp[-64] = &end
	mov	rsi, rax			# rsi := rax = &end - putting in the 2nd argument &end
	mov	edi, 1				# edi := 1 - putting in the 1st argument 1
	call	clock_gettime@PLT		# call clock_gettime(edi, rsi) ~~ clock_gettime(1, &end)
	mov	rax, QWORD PTR -48[rbp]		# rax := rbp[-48]
	mov	rdx, QWORD PTR -40[rbp]		# rdx := rbp[-40]
	mov	rdi, QWORD PTR -64[rbp]		# rdi := rbp[-64] = &end
	mov	rsi, QWORD PTR -56[rbp]		# rsi := rbp[-56] = &start
	mov	rcx, rdx			# rcx := rdx
	mov	rdx, rax			# rdx := rax
	call	time_dif@PLT			# call time_dif(rdi, rsi) ~~ time_dif(&end, &start)
	mov	QWORD PTR -32[rbp], rax		# rbp[-32] := rax = time
	mov	rax, QWORD PTR -32[rbp]		# rax := rbp[-32] = time
	mov	rsi, rax			# rsi := rax = time
	lea	rax, .LC2[rip]			# rax := rip[.LC2] = "Elapsed: %ld ns\n"
	mov	rdi, rax			# putting string in the 1st argument
	mov	eax, 0				# eax := 0 - zeroing out rax
	call	printf@PLT			# call printf(rdi, rsi) ~~ printf("Elapsed: %ld ns", time)
	mov	rdx, QWORD PTR -24[rbp]		# rdx := sum
	mov	rax, QWORD PTR -16[rbp]		# rax := output
	movq	xmm0, rdx			# using float register
	mov	rdi, rax			# rdi := rax = output - putting in the 1st argument output
	call	print@PLT			# call print(output, sum)
	mov	eax, 0				# eax := 0 - zeroing out rax
	leave					# leave the function
	ret					# return 0
