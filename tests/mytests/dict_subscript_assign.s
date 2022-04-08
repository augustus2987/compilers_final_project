.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

	call create_dict
	pushl %eax
	call inject_big
	movl %eax, %esi
	pushl $1
	call inject_int
	movl %eax, %ebx
	pushl $1
	call inject_bool
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	pushl $2
	call inject_int
	movl %eax, %ebx
	pushl $1
	call inject_bool
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	pushl $3
	call inject_int
	movl %eax, %ebx
	pushl $0
	call inject_bool
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	movl %esi, %ebx
	pushl $222
	call inject_int
	movl %eax, %edx
	pushl $3
	call inject_int
	pushl %edx
	pushl %eax
	pushl %ebx
	call set_subscript
	movl $0, %eax
	leave
	ret
