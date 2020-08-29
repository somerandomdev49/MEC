	.file	"main.c"
	.text
	.section	.rodata
.LC0:
	.string	"mk_num(%d, %d)\n"
	.text
	.globl	mk_num
	.type	mk_num, @function
mk_num:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, %eax
	movl	%esi, %edx
	movb	%al, -4(%rbp)
	movl	%edx, %eax
	movb	%al, -8(%rbp)
	movzbl	-8(%rbp), %edx
	movzbl	-4(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movzbl	-4(%rbp), %eax
	sall	$8, %eax
	movl	%eax, %edx
	movzbl	-8(%rbp), %eax
	orl	%edx, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	mk_num, .-mk_num
	.globl	draw
	.type	draw, @function
draw:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movw	$0, -2(%rbp)
	jmp	.L4
.L9:
	movw	$0, -4(%rbp)
	jmp	.L5
.L8:
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	movzwl	-4(%rbp), %ecx
	movzwl	-2(%rbp), %esi
	movq	-24(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	imull	%esi, %eax
	addl	%ecx, %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L6
	movl	$42, %eax
	jmp	.L7
.L6:
	movl	$32, %eax
.L7:
	movl	%eax, %edi
	call	putchar@PLT
	addw	$1, -4(%rbp)
.L5:
	movq	-24(%rbp), %rax
	movzwl	(%rax), %eax
	cmpw	%ax, -4(%rbp)
	jb	.L8
	movl	$10, %edi
	call	putchar@PLT
	addw	$1, -2(%rbp)
.L4:
	movq	-24(%rbp), %rax
	movzwl	2(%rax), %eax
	cmpw	%ax, -2(%rbp)
	jb	.L9
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	draw, .-draw
	.globl	flush_stdin
	.type	flush_stdin, @function
flush_stdin:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
.L12:
	call	getchar@PLT
	movl	%eax, -4(%rbp)
	cmpl	$10, -4(%rbp)
	je	.L13
	cmpl	$-1, -4(%rbp)
	jne	.L12
.L13:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	flush_stdin, .-flush_stdin
	.globl	fpeek
	.type	fpeek, @function
fpeek:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	fgetc@PLT
	movl	%eax, -4(%rbp)
	movq	-24(%rbp), %rdx
	movl	-4(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	ungetc@PLT
	movl	-4(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	fpeek, .-fpeek
	.section	.rodata
.LC1:
	.string	"%hu"
.LC2:
	.string	"Press [Enter]"
.LC3:
	.string	"%s"
	.text
	.globl	run
	.type	run, @function
run:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movq	%r8, -56(%rbp)
	movq	-40(%rbp), %rax
	movzwl	(%rax), %eax
	leal	1(%rax), %ecx
	movq	-40(%rbp), %rdx
	movw	%cx, (%rdx)
	movzwl	%ax, %edx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzwl	(%rax), %edx
	movw	%dx, -3(%rbp)
	movzbl	2(%rax), %eax
	movb	%al, -1(%rbp)
	movzbl	-3(%rbp), %eax
	movzbl	%al, %eax
	cmpl	$23, %eax
	ja	.L41
	movl	%eax, %eax
	leaq	0(,%rax,4), %rdx
	leaq	.L19(%rip), %rax
	movl	(%rdx,%rax), %eax
	cltq
	leaq	.L19(%rip), %rdx
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L19:
	.long	.L39-.L19
	.long	.L38-.L19
	.long	.L37-.L19
	.long	.L36-.L19
	.long	.L35-.L19
	.long	.L34-.L19
	.long	.L41-.L19
	.long	.L33-.L19
	.long	.L41-.L19
	.long	.L32-.L19
	.long	.L31-.L19
	.long	.L30-.L19
	.long	.L29-.L19
	.long	.L28-.L19
	.long	.L27-.L19
	.long	.L26-.L19
	.long	.L25-.L19
	.long	.L24-.L19
	.long	.L23-.L19
	.long	.L41-.L19
	.long	.L22-.L19
	.long	.L21-.L19
	.long	.L20-.L19
	.long	.L18-.L19
	.text
.L39:
	movzbl	-1(%rbp), %eax
	movzbl	%al, %edx
	movzbl	-2(%rbp), %eax
	movzbl	%al, %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	mk_num
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	movw	%dx, 2(%rax)
	jmp	.L17
.L38:
	movzbl	-1(%rbp), %eax
	movzbl	%al, %edx
	movzbl	-2(%rbp), %eax
	movzbl	%al, %esi
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %ecx
	movq	-40(%rbp), %rax
	movslq	%esi, %rdx
	movw	%cx, 2(%rax,%rdx,2)
	jmp	.L17
.L37:
	movzbl	-1(%rbp), %eax
	movzbl	%al, %edx
	movzbl	-2(%rbp), %eax
	movzbl	%al, %eax
	leaq	(%rax,%rax), %rcx
	movq	-32(%rbp), %rax
	addq	%rax, %rcx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %eax
	movw	%ax, (%rcx)
	jmp	.L17
.L36:
	movzbl	-1(%rbp), %eax
	movzbl	%al, %eax
	leaq	(%rax,%rax), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movzbl	-2(%rbp), %edx
	movzbl	%dl, %edx
	movzwl	(%rax), %ecx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movw	%cx, 2(%rax,%rdx,2)
	jmp	.L17
.L35:
	movq	-48(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-2(%rbp), %eax
	movzbl	%al, %ecx
	movzbl	-1(%rbp), %eax
	movzbl	%al, %esi
	movq	-48(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	imull	%esi, %eax
	addl	%ecx, %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	sete	%dil
	movq	-48(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-2(%rbp), %eax
	movzbl	%al, %ecx
	movzbl	-1(%rbp), %eax
	movzbl	%al, %esi
	movq	-48(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	imull	%esi, %eax
	addl	%ecx, %eax
	cltq
	addq	%rdx, %rax
	movl	%edi, %edx
	movb	%dl, (%rax)
	jmp	.L17
.L34:
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	draw
	jmp	.L17
.L30:
	movzbl	-1(%rbp), %eax
	movzbl	%al, %edx
	movzbl	-2(%rbp), %eax
	movzbl	%al, %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	mk_num
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	movw	%dx, (%rax)
	jmp	.L17
.L29:
	movq	-40(%rbp), %rax
	movzwl	2(%rax), %eax
	testw	%ax, %ax
	je	.L42
	movzbl	-1(%rbp), %eax
	movzbl	%al, %edx
	movzbl	-2(%rbp), %eax
	movzbl	%al, %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	mk_num
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	movw	%dx, (%rax)
	jmp	.L42
.L28:
	movzbl	-2(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %ecx
	movzbl	-1(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %eax
	leal	(%rcx,%rax), %edx
	movq	-40(%rbp), %rax
	movw	%dx, 2(%rax)
	jmp	.L17
.L33:
	movzbl	-2(%rbp), %eax
	movzbl	%al, %eax
	cltq
	leaq	(%rax,%rax), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	addq	$2, %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	jmp	.L17
.L32:
	leaq	.LC2(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	call	flush_stdin
	call	getchar@PLT
	jmp	.L17
.L31:
	movzbl	-2(%rbp), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	movq	%rax, %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movq	8(%rax), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L17
.L27:
	movzbl	-2(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %ecx
	movzbl	-1(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movq	-40(%rbp), %rax
	movw	%dx, 2(%rax)
	jmp	.L17
.L26:
	movzbl	-2(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %ecx
	movzbl	-1(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %eax
	imull	%eax, %ecx
	movl	%ecx, %edx
	movq	-40(%rbp), %rax
	movw	%dx, 2(%rax)
	jmp	.L17
.L25:
	movzbl	-2(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %eax
	movzbl	-1(%rbp), %edx
	movzbl	%dl, %ecx
	movq	-40(%rbp), %rdx
	movslq	%ecx, %rcx
	movzwl	2(%rdx,%rcx,2), %edi
	movl	$0, %edx
	divw	%di
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	movw	%dx, 2(%rax)
	jmp	.L17
.L24:
	movzbl	-2(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %ecx
	movzbl	-1(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %eax
	andl	%eax, %ecx
	movl	%ecx, %edx
	movq	-40(%rbp), %rax
	movw	%dx, 2(%rax)
	jmp	.L17
.L23:
	movzbl	-2(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %ecx
	movzbl	-1(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %eax
	orl	%eax, %ecx
	movl	%ecx, %edx
	movq	-40(%rbp), %rax
	movw	%dx, 2(%rax)
	jmp	.L17
.L22:
	movzbl	-2(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %ecx
	movzbl	-1(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %eax
	cmpw	%ax, %cx
	setb	%al
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movw	%dx, 2(%rax)
	jmp	.L17
.L21:
	movzbl	-2(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %ecx
	movzbl	-1(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %eax
	cmpw	%ax, %cx
	seta	%al
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movw	%dx, 2(%rax)
	jmp	.L17
.L20:
	movzbl	-2(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %ecx
	movzbl	-1(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %eax
	cmpw	%ax, %cx
	setbe	%al
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movw	%dx, 2(%rax)
	jmp	.L17
.L18:
	movzbl	-2(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %ecx
	movzbl	-1(%rbp), %eax
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movslq	%edx, %rdx
	movzwl	2(%rax,%rdx,2), %eax
	cmpw	%ax, %cx
	setnb	%al
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movw	%dx, 2(%rax)
	jmp	.L17
.L42:
	nop
.L17:
.L41:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	run, .-run
	.section	.rodata
.LC4:
	.string	"reading a byte %d, next %d\n"
	.text
	.globl	read_byte
	.type	read_byte, @function
read_byte:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	getc@PLT
	movb	%al, -1(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	fpeek
	movl	%eax, %edx
	movzbl	-1(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movzbl	-1(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	read_byte, .-read_byte
	.globl	read_num
	.type	read_num, @function
read_num:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	read_byte
	movb	%al, -1(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	read_byte
	movb	%al, -2(%rbp)
	movzbl	-2(%rbp), %edx
	movzbl	-1(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	mk_num
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	read_num, .-read_num
	.section	.rodata
.LC5:
	.string	"reading a string..."
.LC6:
	.string	"reading a character: '%c' %d\n"
	.text
	.globl	read_str
	.type	read_str, @function
read_str:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	leaq	.LC5(%rip), %rdi
	call	puts@PLT
	movw	$0, -2(%rbp)
	movzwl	-2(%rbp), %eax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -16(%rbp)
	jmp	.L48
.L50:
	movsbl	-17(%rbp), %edx
	movsbl	-17(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC6(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addw	$1, -2(%rbp)
	movzwl	-2(%rbp), %edx
	movq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc@PLT
	movq	%rax, -16(%rbp)
	movzwl	-2(%rbp), %eax
	leaq	-1(%rax), %rdx
	movq	-16(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-17(%rbp), %eax
	movb	%al, (%rdx)
.L48:
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	read_byte
	movb	%al, -17(%rbp)
	cmpb	$0, -17(%rbp)
	je	.L49
	cmpb	$-1, -17(%rbp)
	jne	.L50
.L49:
	movq	-16(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	read_str, .-read_str
	.section	.rodata
.LC7:
	.string	"reading..."
.LC8:
	.string	"value count: %d\n"
.LC9:
	.string	"reading values:"
	.align 8
.LC10:
	.string	"instruction count: %d, (%lu bytes per INS -> %lu bytes total)\n"
.LC11:
	.string	"reading instructions:"
.LC12:
	.string	"reading ins #%d\n"
.LC13:
	.string	"Next byte: %d\n"
.LC14:
	.string	"reading byte t"
.LC15:
	.string	"reading byte a"
.LC16:
	.string	"reading byte b"
.LC17:
	.string	"done reading ins."
	.text
	.globl	read
	.type	read, @function
read:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$64, %rsp
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	%rcx, -64(%rbp)
	movq	%r8, -72(%rbp)
	leaq	.LC7(%rip), %rdi
	call	puts@PLT
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	read_num
	movzwl	%ax, %edx
	movq	-56(%rbp), %rax
	movl	%edx, (%rax)
	movq	-56(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	leaq	.LC8(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-56(%rbp), %rax
	movl	(%rax), %eax
	cltq
	salq	$4, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, %rdx
	movq	-48(%rbp), %rax
	movq	%rdx, (%rax)
	leaq	.LC9(%rip), %rdi
	call	puts@PLT
	movl	$0, -20(%rbp)
	jmp	.L53
.L54:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rbx
	movl	-20(%rbp), %eax
	movl	%eax, %r12d
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	read_str
	movb	%r12b, (%rbx)
	movq	%rax, 8(%rbx)
	addl	$1, -20(%rbp)
.L53:
	movq	-56(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -20(%rbp)
	jl	.L54
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	read_num
	movzwl	%ax, %edx
	movq	-72(%rbp), %rax
	movl	%edx, (%rax)
	movq	-72(%rbp), %rax
	movl	(%rax), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-72(%rbp), %rax
	movl	(%rax), %eax
	movq	%rdx, %rcx
	movl	$3, %edx
	movl	%eax, %esi
	leaq	.LC10(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-72(%rbp), %rax
	movl	(%rax), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, %rdx
	movq	-64(%rbp), %rax
	movq	%rdx, (%rax)
	leaq	.LC11(%rip), %rdi
	call	puts@PLT
	movl	$0, -24(%rbp)
	jmp	.L55
.L56:
	movl	-24(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC12(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	fpeek
	movl	%eax, %esi
	leaq	.LC13(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-64(%rbp), %rax
	movq	(%rax), %rcx
	movl	-24(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	movb	$0, (%rax)
	movb	$0, 1(%rax)
	movb	$0, 2(%rax)
	leaq	.LC14(%rip), %rdi
	call	puts@PLT
	movq	-64(%rbp), %rax
	movq	(%rax), %rcx
	movl	-24(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	leaq	(%rcx,%rax), %rbx
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	read_byte
	movb	%al, (%rbx)
	leaq	.LC15(%rip), %rdi
	call	puts@PLT
	movq	-64(%rbp), %rax
	movq	(%rax), %rcx
	movl	-24(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	leaq	(%rcx,%rax), %rbx
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	read_byte
	movb	%al, 1(%rbx)
	leaq	.LC16(%rip), %rdi
	call	puts@PLT
	movq	-64(%rbp), %rax
	movq	(%rax), %rcx
	movl	-24(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	leaq	(%rcx,%rax), %rbx
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	read_byte
	movb	%al, 2(%rbx)
	leaq	.LC17(%rip), %rdi
	call	puts@PLT
	addl	$1, -24(%rbp)
.L55:
	movq	-72(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -24(%rbp)
	jl	.L56
	nop
	addq	$64, %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	read, .-read
	.section	.rodata
.LC18:
	.string	"r"
.LC19:
	.string	"out.mecc"
	.text
	.globl	main
	.type	main, @function
main:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	leaq	.LC18(%rip), %rsi
	leaq	.LC19(%rip), %rdi
	call	fopen@PLT
	movq	%rax, -16(%rbp)
	leaq	-44(%rbp), %rdi
	leaq	-40(%rbp), %rcx
	leaq	-28(%rbp), %rdx
	leaq	-24(%rbp), %rsi
	movq	-16(%rbp), %rax
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	read
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movw	$10, -64(%rbp)
	movw	$10, -62(%rbp)
	movl	$100, %edi
	call	malloc@PLT
	movq	%rax, -56(%rbp)
	movw	$0, -2(%rbp)
	jmp	.L58
.L61:
	movw	$0, -4(%rbp)
	jmp	.L59
.L60:
	movq	-56(%rbp), %rdx
	movzwl	-4(%rbp), %ecx
	movzwl	-2(%rbp), %esi
	movzwl	-64(%rbp), %eax
	movzwl	%ax, %eax
	imull	%esi, %eax
	addl	%ecx, %eax
	cltq
	addq	%rdx, %rax
	movb	$0, (%rax)
	addw	$1, -4(%rbp)
.L59:
	movzwl	-64(%rbp), %eax
	cmpw	%ax, -4(%rbp)
	jb	.L60
	addw	$1, -2(%rbp)
.L58:
	movzwl	-62(%rbp), %eax
	cmpw	%ax, -2(%rbp)
	jb	.L61
	movw	$0, -112(%rbp)
	jmp	.L62
.L63:
	movq	-24(%rbp), %rsi
	movq	-40(%rbp), %rax
	leaq	-64(%rbp), %rcx
	leaq	-112(%rbp), %rdx
	movq	%rsi, %r8
	movl	$0, %esi
	movq	%rax, %rdi
	call	run
.L62:
	movzwl	-112(%rbp), %eax
	movzwl	%ax, %edx
	movl	-44(%rbp), %eax
	cmpl	%eax, %edx
	jl	.L63
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	main, .-main
	.ident	"GCC: (Debian 8.3.0-6) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
